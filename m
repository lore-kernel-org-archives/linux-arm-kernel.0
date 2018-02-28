From: palmer@sifive.com (Palmer Dabbelt)
Date: Wed, 28 Feb 2018 14:34:14 -0800 (PST)
Subject: [PATCH v7 02/13] drivers: base: cacheinfo: setup DT cache
 properties early
In-Reply-To: <20180228220619.6992-3-jeremy.linton@arm.com>
Message-ID: <mhng-a110cedb-912a-4701-b1b4-8546d12e861a@palmer-si-x1c4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Feb 2018 14:06:08 PST (-0800), jeremy.linton at arm.com wrote:
> The original intent in cacheinfo was that an architecture
> specific populate_cache_leaves() would probe the hardware
> and then cache_shared_cpu_map_setup() and
> cache_override_properties() would provide firmware help to
> extend/expand upon what was probed. Arm64 was really
> the only architecture that was working this way, and
> with the removal of most of the hardware probing logic it
> became clear that it was possible to simplify the logic a bit.
>
> This patch combines the walk of the DT nodes with the
> code updating the cache size/line_size and nr_sets.
> cache_override_properties() (which was DT specific) is
> then removed. The result is that cacheinfo.of_node is
> no longer used as a temporary place to hold DT references
> for future calls that update cache properties. That change
> helps to clarify its one remaining use (matching
> cacheinfo nodes that represent shared caches) which
> will be used by the ACPI/PPTT code in the following patches.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/riscv/kernel/cacheinfo.c |  1 -
>  drivers/base/cacheinfo.c      | 65 +++++++++++++++++++------------------------
>  2 files changed, 29 insertions(+), 37 deletions(-)
>
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 10ed2749e246..0bc86e5f8f3f 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -20,7 +20,6 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>  			 struct device_node *node,
>  			 enum cache_type type, unsigned int level)
>  {
> -	this_leaf->of_node = node;
>  	this_leaf->level = level;
>  	this_leaf->type = type;
>  	/* not a sector cache */
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 09ccef7ddc99..a872523e8951 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -71,7 +71,7 @@ static inline int get_cacheinfo_idx(enum cache_type type)
>  	return type;
>  }

This looks good as far as RISC-V is concerned, though that's such a trivial 
part of the changeset it's not worth that much :).  Thanks!
