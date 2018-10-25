From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 24 Oct 2018 17:14:16 -0700
Subject: [PATCH 1/2] perf tools: Make find_vdso_map() more modular
In-Reply-To: <20181025000905.6095-2-f.fainelli@gmail.com>
References: <20181025000905.6095-1-f.fainelli@gmail.com>
 <20181025000905.6095-2-f.fainelli@gmail.com>
Message-ID: <86f8ae1e-b50b-559c-11a4-e0c5f311f92a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/18 5:09 PM, Florian Fainelli wrote:
> In preparation for checking that the vectors page on the ARM
> architecture, refactor the find_vdso_map() function to accept finding an
> arbitrary string and create a dedicated helper function for that under
> util/find-map.c and update find_vdso_map() to use it.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  tools/perf/util/find-map.c      | 31 +++++++++++++++++++++++++++++++
>  tools/perf/util/find-vdso-map.c | 30 +++---------------------------
>  2 files changed, 34 insertions(+), 27 deletions(-)
>  create mode 100644 tools/perf/util/find-map.c
> 
> diff --git a/tools/perf/util/find-map.c b/tools/perf/util/find-map.c
> new file mode 100644
> index 000000000000..42533fc21108
> --- /dev/null
> +++ b/tools/perf/util/find-map.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +static int find_map(void **start, void **end, const char *name)
> +{
> +	FILE *maps;
> +	char line[128];
> +	int found = 0;
> +
> +	maps = fopen("/proc/self/maps", "r");
> +	if (!maps) {
> +		fprintf(stderr, "vdso: cannot open maps\n");
> +		return -1;
> +	}
> +
> +	while (!found && fgets(line, sizeof(line), maps)) {
> +		int m = -1;
> +
> +		/* We care only about private r-x mappings. */
> +		if (2 != sscanf(line, "%p-%p r-xp %*x %*x:%*x %*u %n",
> +				start, end, &m))
> +			continue;
> +		if (m < 0)
> +			continue;
> +
> +		if (!strncmp(&line[m], name, sizeof(name) - 1))

Meh, this should be strlen() now, but I would like to hear comments
before submitting a v2 of this anyway. Thanks!
-- 
Florian
