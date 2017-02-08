From: der_steffi@gmx.de (Stephan Bauroth)
Date: Wed, 8 Feb 2017 15:09:29 +0100
Subject: imx6: enet: clock selection (ref/ptp)
Message-ID: <dc953fbd-647c-8fef-4a46-e80a2bcd7a52@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear linux-arm,

I recently stumbled upon a few minor things that took a lot of time. The 
meta-situation was, that I wanted to have a PHY attached via RMII to an 
IMX6D (very similar to Q). While the management of the PHY over MDIO 
worked fine and U-boot was able to transfer my kernel image via NFS, the 
kernel itself couldn't even ping my development PC.

A lot of research later, I was able to isolate the problem down to the 
reference clock of the RMII interface. U-Boot initialized it falsely 
with 125 MHz (for RMII, only 25 or 50 are OK) but then did not use it 
but relied on the external oscillator which was present. Sadly, Linux 
didn't. After first correcting U-Boot to set the clock to 50 MHz, which 
did not help (due to phase-async, I think), I tried to figure out why 
Linux switches to the internal PLL instead of keeping the external one. 
I finally found this one:

arch/arm/mach-imx/mach-imx6q.c:191::
     np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-fec");
     if (!np) {
         ...
     }

     ptp_clk = of_clk_get(np, 2);
     if (IS_ERR(ptp_clk)) {
         ...
     }

     enet_ref = clk_get_sys(NULL, "enet_ref");
     if (IS_ERR(enet_ref)) {
         ...
     }

     /*
      * If enet_ref from ANATOP/CCM is the PTP clock source, we need to
      * set bit IOMUXC_GPR1[21].  Or the PTP clock must be from pad
      * (external OSC), and we need to clear the bit.
      */
     clksel = clk_is_match(ptp_clk, enet_ref) ?
                 IMX6Q_GPR1_ENET_CLK_SEL_ANATOP :
                 IMX6Q_GPR1_ENET_CLK_SEL_PAD;
     gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
     if (!IS_ERR(gpr))
         regmap_update_bits(gpr, IOMUXC_GPR1,
                 IMX6Q_GPR1_ENET_CLK_SEL_MASK,
                 clksel);

I think there are multiple small issues here:
In my case, I want enet_ref to be the external clock. This is controlled 
by IOMUXC_GPR1[21]. The code assumes enet_ref to be internal (does not 
look into the DT).
ptp_clk is not found by name, but by index. While this works for all DTs 
I saw, it's clearly not a good style?
Finally, IOMUXCGPR1[21] is only set to ..._PAD when the two clocks from 
above differ.

My current workaround is this:
     ptp_clk = of_clk_get_by_name(np, "ptp");
     if (IS_ERR(ptp_clk)) {
         ...
     }

     enet_ref = of_clk_get_by_name(np, "enet_ref");
     if (IS_ERR(enet_ref)) {
         ...
     }

Of course, I then have to supply both clocks in the DT. I am clear 
that's not a feasible solution :)
I would like to clean that a little bit but do not have a good solution 
in mind right now. Ideas/corrections/thoughts welcome.

thanks for all work so far and regards,
Stephan
