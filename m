From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 9 Oct 2018 11:38:33 +0100
Subject: [PATCH] kasan: avoid out-of-bounds in unwind_frame
In-Reply-To: <1539079863-19645-1-git-send-email-chunhui.li@mediatek.com>
References: <1539079863-19645-1-git-send-email-chunhui.li@mediatek.com>
Message-ID: <20181009103833.sk2jyhl77f5fb64r@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2018 at 06:11:03PM +0800, Chunhui Li wrote:
> From: "chunhui.li" <chunhui.li@mediatek.com>
> 
>    kasan detect unwind_frame out-of-bounds error when one task
> dump another, log as below
> BUG: KASAN: out-of-bounds in unwind_frame+0x140/0x20c Read of
> size 8 at addr ffffffea1e2378e0 by task AnrMonitorThrea/1111
> avoid kasan out-of-bounds error by disable kasan for stacktrace.c

This doesn't look right. Since unwind_frame uses READ_ONCE_NOCHECK(),
we should never perform an access that KASAN complains about.

I don't think that we should completely disable instrumentation of
stacktrace.c.

Can you please figure out precisely which line KASAN is complaining
about? i.e. use scripts/faddr2line.

Thanks,
Mark.

> 
> Signed-off-by: chunhui.li <chunhui.li@mediatek.com>
> ---
>  arch/arm64/kernel/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 95ac737..606d0e2 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -57,6 +57,8 @@ arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
>  arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
>  arm64-obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
>  
> +KASAN_SANITIZE_stacktrace.o := n
> +
>  obj-y					+= $(arm64-obj-y) vdso/ probes/
>  obj-m					+= $(arm64-obj-m)
>  head-y					:= head.o
> -- 
> 1.9.1
> 
