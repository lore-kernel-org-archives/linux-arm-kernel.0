From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 22 Aug 2016 16:02:11 +0200
Subject: [PATCH v3 05/12] firmware: tegra: Add BPMP support
In-Reply-To: <2059006.oN1pE0IkCo@wuerfel>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-6-thierry.reding@gmail.com>
 <2059006.oN1pE0IkCo@wuerfel>
Message-ID: <20160822140211.GE17367@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 03:34:15PM +0200, Arnd Bergmann wrote:
> On Friday, August 19, 2016 7:32:26 PM CEST Thierry Reding wrote:
> > +static bool tegra_bpmp_master_acked(struct tegra_bpmp_channel *channel)
> > +{
> > +	void *frame;
> > +
> > +	frame = tegra_ivc_read_get_next_frame(channel->ivc);
> > +	if (IS_ERR_OR_NULL(frame)) {
> > +		channel->ib = NULL;
> > +		return false;
> > +	}
> > +
> > +	channel->ib = frame;
> > +
> > +	return true;
> > +}
> 
> Something is wrong with your API if you need IS_ERR_OR_NULL(). If you
> can return NULL, use that for all error. Alternatively make sure
> that you never return NULL 

You're absolutely right, I had missed those on my first pass. I've since
revised all of the error handling based on earlier comments from Jon and
there are IS_ERR_OR_NULL() left.

> > +static int tegra_bpmp_wait_ack(struct tegra_bpmp_channel *channel)
> > +{
> > +	unsigned long timeout = channel->bpmp->soc->channels.cpu_tx.timeout;
> > +	ktime_t start, now;
> > +
> > +	start = ns_to_ktime(local_clock());
> > +
> > +	do {
> > +		if (tegra_bpmp_master_acked(channel))
> > +			return 0;
> > +
> > +		now = ns_to_ktime(local_clock());
> > +	} while (ktime_us_delta(now, start) < timeout);
> > +
> > +	return -ETIMEDOUT;
> > +}
> 
> local_clock() is not guaranteed to be in nanoseconds, why not use
> ktime_get() instead?

We don't need nanosecond resolution anyway, all timeouts are specified
in microseconds.

> ktime_us_delta() is a bit slow because of the 64-bit division,
> you could multiply timeout by NSEC_PER_USEC instead and do a
> straight comparison.
> 
> 
> 	ktime_t end = ktime_add_us(ktime_get(), timeout);
> 	do {
> 		...
> 	} while (ktime_before(ktime_get(), end);

Yes, I think that should work better. Thanks.

> > diff --git a/include/soc/tegra/bpmp-abi.h b/include/soc/tegra/bpmp-abi.h
> > new file mode 100644
> > index 000000000000..0aaef5960e29
> > --- /dev/null
> > +++ b/include/soc/tegra/bpmp-abi.h
> > +#ifndef _ABI_BPMP_ABI_H_
> > +#define _ABI_BPMP_ABI_H_
> > +
> > +#ifdef LK
> > +#include <stdint.h>
> > +#endif
> > +
> > +#ifndef __ABI_PACKED
> > +#define __ABI_PACKED __attribute__((packed))
> > +#endif
> > +
> > +#ifdef NO_GCC_EXTENSIONS
> > +#define EMPTY char empty;
> > +#define EMPTY_ARRAY 1
> > +#else
> > +#define EMPTY
> > +#define EMPTY_ARRAY 0
> > +#endif
> > +
> > +#ifndef __UNION_ANON
> > +#define __UNION_ANON
> > +#endif
> 
> Maybe keep these all out of the kernel?

This was discussed a little in an earlier posting. This header file is
maintained by the BPMP firmware team and using it verbatim means little
to no effort required to update it.

> > +/**
> > + * @ingroup MRQ_Format
> > + * @brief header for an MRQ message
> > + *
> > + * Provides the MRQ number for the MRQ message: #mrq. The remainder of
> > + * the MRQ message is a payload (immediately following the
> > + * mrq_request) whose format depends on mrq.
> > + *
> > + * @todo document the flags
> > + */
> 
> What's the deal with the odd documentation format?

This is also a side-effect of this coming straight out of the repository
for the BPMP firmware. Presumably this used to generate documentation
for internal (or possibly public) consumption.

> > +struct mrq_request {
> > +	/** @brief MRQ number of the request */
> > +	uint32_t mrq;
> > +	/** @brief flags for the request */
> > +	uint32_t flags;
> > +} __ABI_PACKED;
> 
> Marking the structure as packed may result in byte-wise access, depending
> on compiler flags. Is that what you intended? The structure is fully
> packed already, so you won't avoid any padding here.

Agreed, the packing seems unnecessary in many places. However this is
defining an ABI that's used across multiple operating systems, so the
packing may still be required on some systems or toolchains to ensure
the exact same format in the transport.

> > +/**
> > + * @addtogroup Debugfs
> > + * @{
> > + *
> > + * The BPMP firmware implements a pseudo-filesystem called
> > + * debugfs. Any driver within the firmware may register with debugfs
> > + * to expose an arbitrary set of "files" in the filesystem. When
> > + * software on the CPU writes to a debugfs file, debugfs passes the
> > + * written data to a callback provided by the driver. When software on
> > + * the CPU reads a debugfs file, debugfs queries the driver for the
> > + * data to return to the CPU. The intention of the debugfs filesystem
> > + * is to provide information useful for debugging the system at
> > + * runtime.
> > + *
> > + * @note The files exposed via debugfs are not part of the
> > + * BPMP firmware's ABI. debugfs files may be added or removed in any
> > + * given version of the firmware. Typically the semantics of a debugfs
> > + * file are consistent from version to version but even that is not
> > + * guaranteed.
> > + *
> > + * @}
> > + */
> > +/** @ingroup Debugfs */
> > +enum mrq_debugfs_commands {
> > +	CMD_DEBUGFS_READ = 1,
> > +	CMD_DEBUGFS_WRITE = 2,
> > +	CMD_DEBUGFS_DUMPDIR = 3,
> > +	CMD_DEBUGFS_MAX
> > +};
> > +
> > +/**
> > + * @ingroup Debugfs
> > + * @brief parameters for CMD_DEBUGFS_READ/WRITE command
> > + */
> > +struct cmd_debugfs_fileop_request {
> > +	/** @brief physical address pointing at filename */
> > +	uint32_t fnameaddr;
> > +	/** @brief length in bytes of filename buffer */
> > +	uint32_t fnamelen;
> > +	/** @brief physical address pointing to data buffer */
> > +	uint32_t dataaddr;
> > +	/** @brief length in bytes of data buffer */
> > +	uint32_t datalen;
> > +} __ABI_PACKED;
> >
> 
> If the ABI is version specific, maybe add the firmware version name
> to the structure definition?

I don't think the ABI is version specific. Only the set and contents of
the files in the BPMP's debugfs may change per version. The messages
which are exchanged between the CPU and the BPMP remain the same.

> > +struct cmd_clk_set_rate_request {
> > +	int32_t unused;
> > +	int64_t rate;
> > +} __ABI_PACKED;
> 
> This structure actually has a non-aligned struct member, but you
> can write that as
> 
> struct cmd_clk_set_rate_request {
> 	int32_t unused;
> 	int64_t rate;
> } __attribute__((packed, aligned(4)));
> 
> to still use a default four-byte alignment.

I thought the original would yield something like this in memory:

	[unused]
	[rate  ]
	[rate  ]

because packing makes sure to avoid any padding introduced for natural
alignment. Isn't __attribute__((packd, aligned(4))) going to yield the
exact same layout?

If it's not going to yield the same layout, it's probably too late to
change it now because products are going to ship with this ABI as far
as I understand.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/9ac2d1bc/attachment-0001.sig>
