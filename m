From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Oct 2017 14:35:19 +0100
Subject: [RFC 3/3] perf tool: arm-ccn: add a supplemental strerror function
In-Reply-To: <20171024030415.9baa5157e506892a757bf8c7@arm.com>
References: <20171024030415.9baa5157e506892a757bf8c7@arm.com>
Message-ID: <20171024133518.GA13445@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 03:04:15AM -0500, Kim Phillips wrote:
> Use the Arm CCN driver as an example of how to try to improve
> upon its existing dmesg error output, and duplicate error string
> generation logic in the perf tool.

[...]

> Comments?  Is this really that much better than the existing dmesg that
> the user is already being pointed to by the perf tool?

Having never used the CCN PMU, I can't speak to the usefulness of this
change, but I can say that I think this needs to be PMU-specific rather than
arch-specific. The CCN driver can, for example, be built for 32-bit ARM
systems but the directory structure here doesn't reflect that.

>  tools/perf/arch/arm64/util/Build   |  1 +
>  tools/perf/arch/arm64/util/evsel.c | 53 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 tools/perf/arch/arm64/util/evsel.c
> 
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index b1ab72d2a42e..8dee4aa31a68 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -1,4 +1,5 @@
>  libperf-y += header.o
> +libperf-y     += evsel.o
>  libperf-$(CONFIG_DWARF)     += dwarf-regs.o
>  libperf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
>  
> diff --git a/tools/perf/arch/arm64/util/evsel.c b/tools/perf/arch/arm64/util/evsel.c
> new file mode 100644
> index 000000000000..cb9ddd6523e3
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/evsel.c
> @@ -0,0 +1,53 @@
> +#include <string.h>
> +
> +#include <linux/perf_event.h>
> +#include <linux/err.h>
> +
> +#include "../../util/evsel.h"
> +
> +#include "evsel.h"
> +
> +static int ccn_strerror(struct perf_evsel *evsel,
> +			struct target *target __maybe_unused,
> +			int err, char *msg, size_t size)
> +{
> +	const char *evname = perf_evsel__name(evsel);
> +	struct perf_event_attr *attr = &evsel->attr;
> +
> +	switch (err) {
> +	case EOPNOTSUPP:
> +		if (attr->sample_period)
> +			return scnprintf(msg, size, "%s: Sampling not supported, try 'perf stat'\n", evname);

... and then the existing code prints:

	"PMU Hardware doesn't support sampling/overflow-interrupts."

so why do we need both?

> +		if (target__has_task(target))
> +			return scnprintf(msg, size, "%s: Can't provide per-task data!\n", evname);

Isn't this the case for all uncore PMUs? If so, could we predicate this
additionally on evsel->system_wide and print this in the shared error
handler?

> +		break;
> +	case EINVAL:
> +		if ((attr->sample_type & PERF_SAMPLE_BRANCH_STACK) ||
> +			attr->exclude_user ||
> +			attr->exclude_kernel || attr->exclude_hv ||
> +			attr->exclude_idle || attr->exclude_host ||
> +			attr->exclude_guest)
> +			return scnprintf(msg, size, "%s: Can't exclude execution levels!\n", evname);

A better way to do this might be to identify some common failure modes,
e.g. unable to support some of the exclude_* fields in perf_event_attr,
then have an optional per-PMU callback which returns a bool to say
whether or not the error is because of that.

Will
