From: santosh.shilimkar@ti.com (Santosh)
Date: Sun, 04 Sep 2011 15:43:45 +0530
Subject: [PATCH] ARM: l2x0: make sure I&D are not locked down on init
In-Reply-To: <1315126872-3290-1-git-send-email-linus.walleij@stericsson.com>
References: <1315126872-3290-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4E634F59.1010207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 04 September 2011 02:31 PM, Linus Walleij wrote:
> From: Linus Walleij<linus.walleij@linaro.org>
>
> Fighting unfixed U-Boots and other beasts that may the cache in
> a locked-down state when starting the kernel, we make sure to
> disable all cache lock-down when initializing the l2x0 so we
> are in a known state.
>
> Cc: Srinidhi Kasagar<srinidhi.kasagar@stericsson.com>
> Cc: Rabin Vincent<rabin.vincent@stericsson.com>
> Cc: Adrian Bunk<adrian.bunk@movial.com>
> Cc: Rob Herring<robherring2@gmail.com>
> Cc: Catalin Marinas<catalin.marinas@arm.com>
> Cc: Will Deacon<will.deacon@arm.com>
> Reported-by: Jan Rinze<janrinze@gmail.com>
> Tested-by: Robert Marklund<robert.marklund@stericsson.com>
> Signed-off-by: Linus Walleij<linus.walleij@linaro.org>
> ---
>   arch/arm/mm/cache-l2x0.c |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 44c0867..b03c835 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -338,6 +338,10 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
>   		writel_relaxed(1, l2x0_base + L2X0_CTRL);
>   	}
>
> +	/* Make sure that I&D is not locked down when starting */
> +	writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D);
> +	writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I);
> +

Few points on this patch Linus W.
1. You should do above before enabling the L2X0, so
you need to move this up.

2. You are taking care of only one master. i.e CPU0.
You need to do that for CPU1 and if there are more
than two CPU's, then for them too.

3. Even after taking care of 1 and 2, the arch,
which enable L2X0 controller using secure API,s
would have already enabled L2X0, so they need to
do the above in arch code to be effective and
correct. That should be fine though.

At least for you intended change below change should
do. It's taking care of only two CPUs though.

Regards
Santosh

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h 
b/arch/arm/include/asm/hardware/cache-l2x0.h
index 16bd480..e04e947 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -45,8 +45,10 @@
  #define L2X0_CLEAN_INV_LINE_PA		0x7F0
  #define L2X0_CLEAN_INV_LINE_IDX		0x7F8
  #define L2X0_CLEAN_INV_WAY		0x7FC
-#define L2X0_LOCKDOWN_WAY_D		0x900
-#define L2X0_LOCKDOWN_WAY_I		0x904
+#define L2X0_LOCKDOWN_WAY_D0		0x900
+#define L2X0_LOCKDOWN_WAY_D1		0x908
+#define L2X0_LOCKDOWN_WAY_I0		0x904
+#define L2X0_LOCKDOWN_WAY_I1		0x90C
  #define L2X0_TEST_OPERATION		0xF00
  #define L2X0_LINE_DATA			0xF10
  #define L2X0_LINE_TAG			0xF30
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 44c0867..f95b269 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -322,6 +322,12 @@ void __init l2x0_init(void __iomem *base, __u32 
aux_val, __u32 aux_mask)
  	way_size = 1 << (way_size + 3);
  	l2x0_size = ways * way_size * SZ_1K;

+	/* Clear the I and D lock-down way registers */
+	writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D0);
+	writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D1);
+	writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I0);
+	writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I1);
+
  	/*
  	 * Check if l2x0 controller is already enabled.
  	 * If you are booting from non-secure mode
