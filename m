From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Mar 2014 14:03:09 +0000
Subject: [PATCH] ARM: ux500: remove pointless cache setup args
In-Reply-To: <1395410113-19965-1-git-send-email-linus.walleij@linaro.org>
References: <1395410113-19965-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140321140308.GJ7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 02:55:13PM +0100, Linus Walleij wrote:
> This removes the setup of the l2x0 lines that are essentially
> just noops bouncing on the hardware as the cache registers are
> protected in the secure world and there is no point in writing
> them. Put in (0, ~0) to the l2x0_of_init() function as
> suggested by Russell and cut the complex code out.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Russell: I don't know how this fits with other changes hitting
> the l2x0 code, this file is pretty much stand-alone and
> orthogonal to any other stuff hitting the Ux500 code, so I
> can put it in your patch tracker if you want to take it or
> some version of it into your tree.

I already have something which does a similar modification.  Here's
the existing commits in order (copy'n'pasted with gpm so whitespace
damaged):

Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sun Mar 16 19:15:21 2014 +0000

    ARM: l2c: ux500: implement dummy write_sec method

    ux500 can't write to any of the secure registers on the L2C controllers,
    so provide a dummy handler which ignores all writes.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.cindex 264f894c0e3d..5cc7e3625d8c 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -35,6 +35,14 @@ static int __init ux500_l2x0_unlock(void)
        return 0;
 }

+static void ux500_l2c310_write_sec(unsigned long val, unsigned reg)
+{
+       /*
+        * We can't write to secure registers as we are in non-secure
+        * mode, until we have some SMI service available.
+        */
+}
+
 static int __init ux500_l2x0_init(void)
 {
        u32 aux_val = 0x3e000000;
@@ -56,21 +64,14 @@ static int __init ux500_l2x0_init(void)
                /* 64KB way size */
                aux_val |= (0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);

+       outer_cache.write_sec = ux500_l2c310_write_sec;
+
        /* 64KB way size, 8 way associativity, force WA */
        if (of_have_populated_dt())
                l2x0_of_init(aux_val, 0xc0000fff);
        else
                l2x0_init(l2x0_base, aux_val, 0xc0000fff);

-       /*
-        * We can't disable l2 as we are in non secure mode, currently
-        * this seems be called only during kexec path. So let's
-        * override outer.disable with nasty assignment until we have
-        * some SMI service available.
-        */
-       outer_cache.disable = NULL;
-       outer_cache.set_debug = NULL;
-
        return 0;
 }

Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Sun Mar 16 20:52:25 2014 +0000

    ARM: l2c: fix register naming

    We have a mixture of different devices with different register layouts,
    but we group all the bits together in an opaque mess.  Split them out
    into those which are L2C-310 specific and ones which refer to earlier
    devices.  Provide full auxiliary control register definitions.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.cindex 5cc7e3625d8c..067c37a054fb 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -59,10 +59,10 @@ static int __init ux500_l2x0_init(void)
        /* DBx540's L2 has 128KB way size */
        if (cpu_is_ux540_family())
                /* 128KB way size */
-               aux_val |= (0x4 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
+               aux_val |= L2C_AUX_CTRL_WAY_SIZE(4);
        else
                /* 64KB way size */
-               aux_val |= (0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT);
+               aux_val |= L2C_AUX_CTRL_WAY_SIZE(3);

        outer_cache.write_sec = ux500_l2c310_write_sec;

Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Wed Mar 19 01:22:05 2014 +0000

    ARM: l2c: ux500: remove associativity and way size from aux_ctrl

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.cindex 067c37a054fb..5b891d051054 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -45,8 +45,6 @@ static void ux500_l2c310_write_sec(unsigned long val, unsigned
 static int __init ux500_l2x0_init(void)
 {
-       u32 aux_val = 0x3e000000;
-
        if (cpu_is_u8500_family() || cpu_is_ux540_family())
                l2x0_base = __io_address(U8500_L2CC_BASE);
        else
@@ -56,21 +54,12 @@ static int __init ux500_l2x0_init(void)
        /* Unlock before init */
        ux500_l2x0_unlock();
-       /* DBx540's L2 has 128KB way size */
-       if (cpu_is_ux540_family())
-               /* 128KB way size */
-               aux_val |= L2C_AUX_CTRL_WAY_SIZE(4);
-       else
-               /* 64KB way size */
-               aux_val |= L2C_AUX_CTRL_WAY_SIZE(3);
-
        outer_cache.write_sec = ux500_l2c310_write_sec;

-       /* 64KB way size, 8 way associativity, force WA */
        if (of_have_populated_dt())
-               l2x0_of_init(aux_val, 0xc0000fff);
+               l2x0_of_init(0x3e000000, 0xc00f0fff);
        else
-               l2x0_init(l2x0_base, aux_val, 0xc0000fff);
+               l2x0_init(l2x0_base, 0x3e000000, 0xc00f0fff);

        return 0;
 }

Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Wed Mar 19 12:47:58 2014 +0000

    ARM: l2c: ux500: don't try to change the L2 cache auxiliary control register
    ux500 can't change the auxiliary control register, so there's no point
    passing values to try and modify it to the l2x0 init functions.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.cindex 5b891d051054..842ebedbdd1c 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -57,9 +57,9 @@ static int __init ux500_l2x0_init(void)
        outer_cache.write_sec = ux500_l2c310_write_sec;

        if (of_have_populated_dt())
-               l2x0_of_init(0x3e000000, 0xc00f0fff);
+               l2x0_of_init(0, ~0);
        else
-               l2x0_init(l2x0_base, 0x3e000000, 0xc00f0fff);
+               l2x0_init(l2x0_base, 0, ~0);

        return 0;
 }

So the only difference between what you've ended up with is that I've
kept the l2x0_base stuff around and the legacy init.  If you want the
legacy init to be killed, I'd be more than happy to add another patch
on top of my existing series to do that.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
