From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 26 May 2016 09:22:31 -0700
Subject: [PATCH 3/3] arm64/numa: fix type info
In-Reply-To: <1464230639-9852-3-git-send-email-thunder.leizhen@huawei.com>
References: <1464230639-9852-1-git-send-email-thunder.leizhen@huawei.com>
 <1464230639-9852-3-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <CAFpQJXWih2V9Ki-vkL+cDni=VoWL0nA-fx5B5XtfNxFsoUso-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 7:43 PM, Zhen Lei <thunder.leizhen@huawei.com> wrote:
> numa_init(of_numa_init) may returned error because of numa configuration
> error. So "No NUMA configuration found" is inaccurate. In fact, specific
> configuration error information can be immediately printed by the
> testing branch. So "No NUMA..." only needs to be printed when numa_off.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/mm/numa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index 98dc104..9937cc1 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -362,7 +362,8 @@ static int __init dummy_numa_init(void)
>         int ret;
>         struct memblock_region *mblk;
>
> -       pr_info("%s\n", "No NUMA configuration found");
> +       if (numa_off)

IIRC, it should be
if (!numa_off)
we want to print this message when we failed to find proper numa configuration.
when numa_off is set, we will not look for any numa configuration.

> +               pr_info("%s\n", "No NUMA configuration found");
>         pr_info("NUMA: Faking a node at [mem %#018Lx-%#018Lx]\n",
>                0LLU, PFN_PHYS(max_pfn) - 1);
>
> --
> 2.5.0

ganapat
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
