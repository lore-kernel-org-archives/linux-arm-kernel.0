From: ccross@google.com (Colin Cross)
Date: Sat, 19 Feb 2011 14:59:04 -0800
Subject: [PATCH] Fix hang on reboot with Tegra2
In-Reply-To: <1297959237-8277-1-git-send-email-sjg@chromium.org>
References: <1297959237-8277-1-git-send-email-sjg@chromium.org>
Message-ID: <AANLkTi=4SAu7+McLpvRVtQP+QmuUGiXX4=teP8XvL=i-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 8:13 AM, Simon Glass <sjg@chromium.org> wrote:
> This seems to be a regression in 2.6.37.

Thanks, I'll put this in linux-tegra-2.6.37 and a modified version in
for-next, where arch_reset is in common.c.

> We cannot use writel() here since the resulting wmb() calls l2x0_cache_sync()
> which uses a spinlock and L1 cache may be off at this point.

I'm going to change the readl to readl_relaxed as well.

> Change-Id: Ia23b317dee919055ff4abba1484735ea3165fd99

Upstream complains when they see these.

> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/041909.html
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> ?arch/arm/mach-tegra/include/mach/system.h | ? ?4 +++-
> ?1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/include/mach/system.h b/arch/arm/mach-tegra/include/mach/system.h
> index 84d5d46..f1c0a79 100644
> --- a/arch/arm/mach-tegra/include/mach/system.h
> +++ b/arch/arm/mach-tegra/include/mach/system.h
> @@ -33,7 +33,9 @@ static inline void arch_reset(char mode, const char *cmd)
> ? ? ? ?void __iomem *reset = IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x04);
> ? ? ? ?u32 reg = readl(reset);
> ? ? ? ?reg |= 0x04;
> - ? ? ? writel(reg, reset);
> +
> + ? ? ? /* use writel_related to avoid spinlock since L1 cache may be off */
> + ? ? ? writel_relaxed(reg, reset);
> ?}
>
> ?#endif
> --
> 1.7.3.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
