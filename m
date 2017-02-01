From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Wed, 1 Feb 2017 15:57:26 +0000
Subject: [RFC] ARM: l2c:  Adding L310_AUX_CTRL_FULL_LINE_ZERO broke my system
Message-ID: <SG2PR06MB11657BAF8CFC0BCA9D07D0648A4D0@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit 

8ef418c7178f "ARM: l2c: trial at enabling some Cortex-A9 optimisations"

from linux-3.16, my Renesas RZ/A1 (R7s72100) has never been able to use
its PL310 r3p2. It enables it fine, but then crashes later on in boot
because of corrupted memory.


It basically boils down to these lines in the commit:

+		if (!(aux & L310_AUX_CTRL_FULL_LINE_ZERO) && !outer_cache.write_sec) {
+			aux |= L310_AUX_CTRL_FULL_LINE_ZERO;
+			pr_info("L2C-310 full line of zeros enabled for Cortex-A9\n");
+		}


As reference, going into this line I have the following variable values:

  acr = 0x00000000
  aux = 0x42020000
  aux_cur = 0x00000000
  outer_cache.write_sec = (null)

Also as reference from cache-l2x0.h:

#define L310_AUX_CTRL_FULL_LINE_ZERO            BIT(0)  /* R2P0+ */



According to the PL310 documentation:

Full line of zero write
 
To enable this feature, perform the following steps:
1. enable Full line of zero feature in the L2C-310
2. turn on L2C-310
3. enable Full line of zero feature in A9.


So I get that if I want to use this feature, I first need to get it
enabled in the L2C-310, then later on enabled it in the CA9. That
seems to be done by l2c310_starting_cpu() in today's kernel:

	if (aux & L310_AUX_CTRL_FULL_LINE_ZERO)
		cpuhp_setup_state(CPUHP_AP_ARM_L2X0_STARTING,
				  "arm/l2x0:starting", l2c310_starting_cpu,
				  l2c310_dying_cpu);


However, in the code snippet from the patch, the "!" in the if statement
is saying:

  "if you didn't want this feature, then we are turning it on"


Of course changing this line to the following works fine because zero fill
will not get enabled.

+		if (aux & L310_AUX_CTRL_FULL_LINE_ZERO && !outer_cache.write_sec) {
+			aux |= L310_AUX_CTRL_FULL_LINE_ZERO;
+			pr_info("L2C-310 full line of zeros enabled for Cortex-A9\n");
+		}

So here's my questions:

(1) I see that the PL310 is enabled on multiple platforms, so how as this not
broken any systems since it was introduced in 2014? What am I missing?

I see that only 2 platforms explicitly set this aux bit (both have CA9):
  mach-tegra/tegra.c:	.l2c_aux_val	= 0x3c400001,
  mach-exynos/exynos.c:	.l2c_aux_val	= 0x3c400001,



(2) Bits 1 and 2 of the Auxiliary Control Register are "L1 Prefetch enable"
and " L2 Prefetch hint enable". So if I want those enabled, it looks like
I have to enable full-line-zero, correct?

It seems the issue on my SoC is that when I enable FULL_LINE_ZERO in the CA9,
it doesn't seem to work very well.
As in, this simple change will also allow me to boot:

 static int l2c310_starting_cpu(unsigned int cpu)
 {
-	set_auxcr(get_auxcr() | BIT(3) | BIT(2) | BIT(1));
+	set_auxcr(get_auxcr() | BIT(2) | BIT(1));
 	return 0;
 }


So, before I go firing off patches that will effect a bunch of systems, I
would like to understand if there is some logic here that I'm not seeing.


Thank you,
Chris
