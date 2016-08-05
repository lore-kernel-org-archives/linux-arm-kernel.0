From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 5 Aug 2016 11:00:18 +0100
Subject: [PATCH v2 1/2] soc: qcom: provide mechanism for drivers to
 access L2 registers
In-Reply-To: <1470345071-9455-2-git-send-email-nleeder@codeaurora.org>
References: <1470345071-9455-1-git-send-email-nleeder@codeaurora.org>
 <1470345071-9455-2-git-send-email-nleeder@codeaurora.org>
Message-ID: <20160805100018.GA25152@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 05:11:10PM -0400, Neil Leeder wrote:
> L2 registers are accessed using a select register and data
> register pair. To prevent multiple concurrent writes to the
> select register by independent drivers, the write to the
> select register and the associated access of the data register
> are protected with a lock. All drivers accessing the L2
> registers use the set and get functions provided by
> l2-accessors to ensure correct reads and writes to L2 registers.

As of this series, this is only used by the PMU driver. Which other
drivers do you plan to use this for?

If there's nothing else planned at the moment, it would be nicer to fold
these into the PMU driver.

[...]

> +config QCOM_L2_ACCESSORS
> +	bool "Qualcomm Technologies L2-cache accessors"
> +	depends on ARCH_QCOM && ARM64
> +	help
> +	  Say y here to enable support for the Qualcomm Technologies
> +	  L2 accessors.
> +	  Provides support for accessing registers in the L2 cache
> +	  for Qualcomm Technologies chips.

Which chips have this?

Have drivers select this as necessary. There's no reason for this to be
used-selectable given this is trivial common infrastructure.

[...]

> +#include <linux/spinlock.h>
> +#include <linux/export.h>
> +#include <linux/soc/qcom/l2-accessors.h>
> +#include <asm/cputype.h>
> +#include <asm/sysreg.h>

Nit: please sort these alphabetically.

[...]

> +EXPORT_SYMBOL(set_l2_indirect_reg);

The PMU driver isn't a module, so this doesn't need to be exported.
Until there's a modular user, please get rid of EXPORT_SYMBOL.

> +EXPORT_SYMBOL(get_l2_indirect_reg);

Likewise.

Thanks,
Mark.
