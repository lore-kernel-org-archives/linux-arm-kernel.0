From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 10 Feb 2014 21:58:20 +0000
Subject: [PATCHv2 2/2] arm: Get rid of meminfo
In-Reply-To: <1391558551-31395-3-git-send-email-lauraa@codeaurora.org>
References: <1391558551-31395-1-git-send-email-lauraa@codeaurora.org>
 <1391558551-31395-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <CACxGe6vyuZTuMx_posAyu335D3FnFRro24bHR-HNKzG2AuOwDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 5, 2014 at 12:02 AM, Laura Abbott <lauraa@codeaurora.org> wrote:
> memblock is now fully integrated into the kernel and is the prefered
> method for tracking memory. Rather than reinvent the wheel with
> meminfo, migrate to using memblock directly instead of meminfo as
> an intermediate.
>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index b0df976..b6de661 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -625,15 +625,8 @@ void __init dump_machine_table(void)
>
>  int __init arm_add_memory(u64 start, u64 size)
>  {
> -       struct membank *bank = &meminfo.bank[meminfo.nr_banks];
>         u64 aligned_start;

With the changes to this function, I think you can outright remove
early_init_dt_add_memory_arch() from arch/arm/kernel/devtree.c. The
default implementation (__weak) in drivers/of/fdt.c uses memblock
directly.

g.
