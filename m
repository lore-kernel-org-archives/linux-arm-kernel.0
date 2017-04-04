From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 4 Apr 2017 13:25:18 +0100
Subject: [PATCH 2/3] perf tools arm64: implement function get_cpuid_str
In-Reply-To: <1491291403-29893-3-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1491291403-29893-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1491291403-29893-3-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <20170404122518.GA8551@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 01:06:42PM +0530, Ganapatrao Kulkarni wrote:
> function get_cpuid_str returns midr_el1 value from first
> online cpu available.

This isn't globally the same (e.g. in big.LITTLE systems).

It would be far better to have the function take a PMU, and look at the
first CPU in that PMU's mask.

Thanks,
Mark.

> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  tools/perf/arch/arm64/util/Build    |  1 +
>  tools/perf/arch/arm64/util/header.c | 51 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>  create mode 100644 tools/perf/arch/arm64/util/header.c
> 
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index cef6fb3..b1ab72d 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -1,3 +1,4 @@
> +libperf-y += header.o
>  libperf-$(CONFIG_DWARF)     += dwarf-regs.o
>  libperf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
>  
> diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
> new file mode 100644
> index 0000000..c0468fe
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/header.c
> @@ -0,0 +1,51 @@
> +#include <fnmatch.h>
> +#include <dirent.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <linux/stringify.h>
> +#include "header.h"
> +#include "util.h"
> +
> +#define LINUX_SYS_CPU_DIRECTORY "/sys/devices/system/cpu/"
> +#define MIDR "/regs/identification/midr_el1"
> +
> +char *get_cpuid_str(void)
> +{
> +	char *buf = malloc(128);
> +	FILE *file;
> +	char *ret = NULL;
> +	int cpu , nr_cpu;
> +	char sys_file[256];
> +
> +	sprintf(sys_file, LINUX_SYS_CPU_DIRECTORY"kernel_max");
> +
> +	file = fopen(sys_file, "r");
> +	if (!file)
> +		return ret;
> +
> +	if (fscanf(file, "%d", &nr_cpu) != 1)
> +		return ret;
> +
> +	/* kernel_max returns nr_cpu -1 */
> +	nr_cpu++;
> +
> +	/*iterate till you read midr of first online cpu */
> +	for(cpu = 0; cpu < nr_cpu; cpu++)
> +	{
> +		sprintf(sys_file, LINUX_SYS_CPU_DIRECTORY"cpu%d"MIDR, cpu);
> +		file = fopen(sys_file, "r");
> +		if (file) {
> +			ret = fgets(buf, 128, file);
> +			if (ret) {
> +				buf[strlen(buf)-1] ='\0';
> +				fclose(file);
> +				return buf;
> +			}
> +			fclose(file);
> +		}
> +	}
> +	free(buf);
> +	return ret;
> +}
> -- 
> 1.8.1.4
> 
