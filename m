From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Aug 2016 15:34:15 +0200
Subject: [PATCH v3 05/12] firmware: tegra: Add BPMP support
In-Reply-To: <20160819173233.13260-6-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
 <20160819173233.13260-6-thierry.reding@gmail.com>
Message-ID: <2059006.oN1pE0IkCo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, August 19, 2016 7:32:26 PM CEST Thierry Reding wrote:
> +static bool tegra_bpmp_master_acked(struct tegra_bpmp_channel *channel)
> +{
> +	void *frame;
> +
> +	frame = tegra_ivc_read_get_next_frame(channel->ivc);
> +	if (IS_ERR_OR_NULL(frame)) {
> +		channel->ib = NULL;
> +		return false;
> +	}
> +
> +	channel->ib = frame;
> +
> +	return true;
> +}

Something is wrong with your API if you need IS_ERR_OR_NULL(). If you
can return NULL, use that for all error. Alternatively make sure
that you never return NULL 

> +
> +static int tegra_bpmp_wait_ack(struct tegra_bpmp_channel *channel)
> +{
> +	unsigned long timeout = channel->bpmp->soc->channels.cpu_tx.timeout;
> +	ktime_t start, now;
> +
> +	start = ns_to_ktime(local_clock());
> +
> +	do {
> +		if (tegra_bpmp_master_acked(channel))
> +			return 0;
> +
> +		now = ns_to_ktime(local_clock());
> +	} while (ktime_us_delta(now, start) < timeout);
> +
> +	return -ETIMEDOUT;
> +}

local_clock() is not guaranteed to be in nanoseconds, why not use
ktime_get() instead?

ktime_us_delta() is a bit slow because of the 64-bit division,
you could multiply timeout by NSEC_PER_USEC instead and do a
straight comparison.


	ktime_t end = ktime_add_us(ktime_get(), timeout);
	do {
		...
	} while (ktime_before(ktime_get(), end);

> diff --git a/include/soc/tegra/bpmp-abi.h b/include/soc/tegra/bpmp-abi.h
> new file mode 100644
> index 000000000000..0aaef5960e29
> --- /dev/null
> +++ b/include/soc/tegra/bpmp-abi.h
> +#ifndef _ABI_BPMP_ABI_H_
> +#define _ABI_BPMP_ABI_H_
> +
> +#ifdef LK
> +#include <stdint.h>
> +#endif
> +
> +#ifndef __ABI_PACKED
> +#define __ABI_PACKED __attribute__((packed))
> +#endif
> +
> +#ifdef NO_GCC_EXTENSIONS
> +#define EMPTY char empty;
> +#define EMPTY_ARRAY 1
> +#else
> +#define EMPTY
> +#define EMPTY_ARRAY 0
> +#endif
> +
> +#ifndef __UNION_ANON
> +#define __UNION_ANON
> +#endif

Maybe keep these all out of the kernel?

> +
> +/**
> + * @ingroup MRQ_Format
> + * @brief header for an MRQ message
> + *
> + * Provides the MRQ number for the MRQ message: #mrq. The remainder of
> + * the MRQ message is a payload (immediately following the
> + * mrq_request) whose format depends on mrq.
> + *
> + * @todo document the flags
> + */

What's the deal with the odd documentation format?

> +struct mrq_request {
> +	/** @brief MRQ number of the request */
> +	uint32_t mrq;
> +	/** @brief flags for the request */
> +	uint32_t flags;
> +} __ABI_PACKED;

Marking the structure as packed may result in byte-wise access, depending
on compiler flags. Is that what you intended? The structure is fully
packed already, so you won't avoid any padding here.

> +/**
> + * @addtogroup Debugfs
> + * @{
> + *
> + * The BPMP firmware implements a pseudo-filesystem called
> + * debugfs. Any driver within the firmware may register with debugfs
> + * to expose an arbitrary set of "files" in the filesystem. When
> + * software on the CPU writes to a debugfs file, debugfs passes the
> + * written data to a callback provided by the driver. When software on
> + * the CPU reads a debugfs file, debugfs queries the driver for the
> + * data to return to the CPU. The intention of the debugfs filesystem
> + * is to provide information useful for debugging the system at
> + * runtime.
> + *
> + * @note The files exposed via debugfs are not part of the
> + * BPMP firmware's ABI. debugfs files may be added or removed in any
> + * given version of the firmware. Typically the semantics of a debugfs
> + * file are consistent from version to version but even that is not
> + * guaranteed.
> + *
> + * @}
> + */
> +/** @ingroup Debugfs */
> +enum mrq_debugfs_commands {
> +	CMD_DEBUGFS_READ = 1,
> +	CMD_DEBUGFS_WRITE = 2,
> +	CMD_DEBUGFS_DUMPDIR = 3,
> +	CMD_DEBUGFS_MAX
> +};
> +
> +/**
> + * @ingroup Debugfs
> + * @brief parameters for CMD_DEBUGFS_READ/WRITE command
> + */
> +struct cmd_debugfs_fileop_request {
> +	/** @brief physical address pointing at filename */
> +	uint32_t fnameaddr;
> +	/** @brief length in bytes of filename buffer */
> +	uint32_t fnamelen;
> +	/** @brief physical address pointing to data buffer */
> +	uint32_t dataaddr;
> +	/** @brief length in bytes of data buffer */
> +	uint32_t datalen;
> +} __ABI_PACKED;
>

If the ABI is version specific, maybe add the firmware version name
to the structure definition?

> +struct cmd_clk_set_rate_request {
> +	int32_t unused;
> +	int64_t rate;
> +} __ABI_PACKED;

This structure actually has a non-aligned struct member, but you
can write that as

struct cmd_clk_set_rate_request {
	int32_t unused;
	int64_t rate;
} __attribute__((packed, aligned(4)));

to still use a default four-byte alignment.

	Arnd
