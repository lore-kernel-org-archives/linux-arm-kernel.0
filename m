From: jolsa@redhat.com (Jiri Olsa)
Date: Wed, 12 Feb 2014 14:09:38 +0100
Subject: [PATCH] perf: ARM64: wire up perf_regs and unwind support
In-Reply-To: <1391451427-31221-1-git-send-email-jean.pihet@linaro.org>
References: <1391451427-31221-1-git-send-email-jean.pihet@linaro.org>
Message-ID: <20140212130938.GA7624@krava.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 07:17:07PM +0100, Jean Pihet wrote:
> This patch hooks in the perf_regs and libunwind code for ARM64.
> The tools/perf/arch/arm64 is created; it contains the arch specific
> code for DWARF unwinding.
> 
> Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
> Acked-by: Will Deacon <will.deacon@arm.com>

SNIP

> + */
> +const char *get_arch_regstr(unsigned int n)
> +{
> +	const struct pt_regs_dwarfnum *roff;
> +	for (roff = regdwarfnum_table; roff->name != NULL; roff++)
> +		if (roff->dwarfnum == n)
> +			return roff->name;
> +	return NULL;
> +}
> diff --git a/tools/perf/arch/arm64/util/unwind.c b/tools/perf/arch/arm64/util/unwind.c
> new file mode 100644
> index 0000000..8d37a4c
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/unwind.c
> @@ -0,0 +1,82 @@
> +
> +#include <errno.h>
> +#include <libunwind.h>
> +#include "perf_regs.h"
> +#include "../../util/unwind.h"
> +
> +int unwind__arch_reg_id(int regnum)


I think this ^^^ wouldn't compile over acme/perf/core, bacause of
the recent code changes for the libdw unwind:

1d86598 perf callchain: Rename unwind__arch_reg_id into libunwind__arch_reg_id

jirka
