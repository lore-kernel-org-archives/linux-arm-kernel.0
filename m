From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Aug 2016 16:42:32 +0200
Subject: [PATCH v3 05/12] firmware: tegra: Add BPMP support
In-Reply-To: <20160822140211.GE17367@ulmo.ba.sec>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <2059006.oN1pE0IkCo@wuerfel> <20160822140211.GE17367@ulmo.ba.sec>
Message-ID: <5669893.Rd6yQObxH6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 22, 2016 4:02:11 PM CEST Thierry Reding wrote:
> On Mon, Aug 22, 2016 at 03:34:15PM +0200, Arnd Bergmann wrote:
> > On Friday, August 19, 2016 7:32:26 PM CEST Thierry Reding wrote:
> > > diff --git a/include/soc/tegra/bpmp-abi.h b/include/soc/tegra/bpmp-abi.h
> > > new file mode 100644
> > > index 000000000000..0aaef5960e29
> > > --- /dev/null
> > > +++ b/include/soc/tegra/bpmp-abi.h
> > > +#ifndef _ABI_BPMP_ABI_H_
> > > +#define _ABI_BPMP_ABI_H_
> > > +
> > > +#ifdef LK
> > > +#include <stdint.h>
> > > +#endif
> > > +
> > > +#ifndef __ABI_PACKED
> > > +#define __ABI_PACKED __attribute__((packed))
> > > +#endif
> > > +
> > > +#ifdef NO_GCC_EXTENSIONS
> > > +#define EMPTY char empty;
> > > +#define EMPTY_ARRAY 1
> > > +#else
> > > +#define EMPTY
> > > +#define EMPTY_ARRAY 0
> > > +#endif
> > > +
> > > +#ifndef __UNION_ANON
> > > +#define __UNION_ANON
> > > +#endif
> > 
> > Maybe keep these all out of the kernel?
> 
> This was discussed a little in an earlier posting. This header file is
> maintained by the BPMP firmware team and using it verbatim means little
> to no effort required to update it.

The usual recommendation is to just use Linux coding style in shared
files, and possibly add another header that provides the required
definitions. Otherwise you end up with people randomly cleaning up
the file later ;-)


> > > +struct mrq_request {
> > > +	/** @brief MRQ number of the request */
> > > +	uint32_t mrq;
> > > +	/** @brief flags for the request */
> > > +	uint32_t flags;
> > > +} __ABI_PACKED;
> > 
> > Marking the structure as packed may result in byte-wise access, depending
> > on compiler flags. Is that what you intended? The structure is fully
> > packed already, so you won't avoid any padding here.
> 
> Agreed, the packing seems unnecessary in many places. However this is
> defining an ABI that's used across multiple operating systems, so the
> packing may still be required on some systems or toolchains to ensure
> the exact same format in the transport.

However, if __ABI_PACKED is defined to an empty string, it is different
in some cases.

Also, setting 'NO_GCC_EXTENSIONS' changes the structure layout of
some of the structures, by adding an extra member. If the firmware
has a compiler that is less than 10 years old, I'd suggest using C99
syntax instead, which should avoid those differences and eliminate
all gcc extensions.

> > > +/**
> > > + * @addtogroup Debugfs
> > > + * @{
> > > + *
> > > + * The BPMP firmware implements a pseudo-filesystem called
> > > + * debugfs. Any driver within the firmware may register with debugfs
> > > + * to expose an arbitrary set of "files" in the filesystem. When
> > > + * software on the CPU writes to a debugfs file, debugfs passes the
> > > + * written data to a callback provided by the driver. When software on
> > > + * the CPU reads a debugfs file, debugfs queries the driver for the
> > > + * data to return to the CPU. The intention of the debugfs filesystem
> > > + * is to provide information useful for debugging the system at
> > > + * runtime.
> > > + *
> > > + * @note The files exposed via debugfs are not part of the
> > > + * BPMP firmware's ABI. debugfs files may be added or removed in any
> > > + * given version of the firmware. Typically the semantics of a debugfs
> > > + * file are consistent from version to version but even that is not
> > > + * guaranteed.
> > > + *
> > > + * @}
> > > + */
> > > +/** @ingroup Debugfs */
> > > +enum mrq_debugfs_commands {
> > > +	CMD_DEBUGFS_READ = 1,
> > > +	CMD_DEBUGFS_WRITE = 2,
> > > +	CMD_DEBUGFS_DUMPDIR = 3,
> > > +	CMD_DEBUGFS_MAX
> > > +};
> > > +
> > > +/**
> > > + * @ingroup Debugfs
> > > + * @brief parameters for CMD_DEBUGFS_READ/WRITE command
> > > + */
> > > +struct cmd_debugfs_fileop_request {
> > > +	/** @brief physical address pointing at filename */
> > > +	uint32_t fnameaddr;
> > > +	/** @brief length in bytes of filename buffer */
> > > +	uint32_t fnamelen;
> > > +	/** @brief physical address pointing to data buffer */
> > > +	uint32_t dataaddr;
> > > +	/** @brief length in bytes of data buffer */
> > > +	uint32_t datalen;
> > > +} __ABI_PACKED;
> > >
> > 
> > If the ABI is version specific, maybe add the firmware version name
> > to the structure definition?
> 
> I don't think the ABI is version specific. Only the set and contents of
> the files in the BPMP's debugfs may change per version. The messages
> which are exchanged between the CPU and the BPMP remain the same.

Ah, got it.

> > > +struct cmd_clk_set_rate_request {
> > > +	int32_t unused;
> > > +	int64_t rate;
> > > +} __ABI_PACKED;
> > 
> > This structure actually has a non-aligned struct member, but you
> > can write that as
> > 
> > struct cmd_clk_set_rate_request {
> > 	int32_t unused;
> > 	int64_t rate;
> > } __attribute__((packed, aligned(4)));
> > 
> > to still use a default four-byte alignment.
> 
> I thought the original would yield something like this in memory:
> 
> 	[unused]
> 	[rate  ]
> 	[rate  ]
> 
> because packing makes sure to avoid any padding introduced for natural
> alignment. Isn't __attribute__((packd, aligned(4))) going to yield the
> exact same layout?

Yes, only the alignment of the structure itself is changed, not
the contents. The main difference is that accessing 'rate' on
a target machine without unaligned access will use two 32-bit
loads rather than eight 8-bit loads.

Also, embedding this structure in another one is different
(in theory, I don't expect this to actually appear somewhere):

struct example {
	char a;
	struct cmd_clk_set_rate_request b;
};

would currently be 13 bytes long, with the alignment I suggested you
get three bytes of padding after 'a'.

	Arnd
