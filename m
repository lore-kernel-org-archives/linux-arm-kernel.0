From: Thomas.Betker@rohde-schwarz.com (Thomas.Betker at rohde-schwarz.com)
Date: Fri, 24 Jun 2016 09:58:36 +0200
Subject: ARM: i.MX6: KSZ9031 fixup questions
Message-ID: <OFA5811F46.A3BB50D2-ONC1257FDC.0028F664-C1257FDC.002BD17F@rohde-schwarz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sascha,

I am trying to understand the ksz9031rn_phy_fixup() function in 
arch/arm/mach-imx/mach-imx6q.c. My background is that we have a custom 
board with i.MX6Q and KSZ9031RNX (RGMII).

The basic idea seems to be that i.MX6Q has to set up the KSZ9031 pad skews 
because ENET does not have an integrated TX clock delay (TsetupT), and you 
don't want a trace delay on the PCB; i.e., all the RGMII signal lines are 
about the same length.

Your register settings add up to the following deltas:
* TDn to TXC: 0.96 + 0.00 = 0.96 ns
* TX_CTL to TXC: 0.96 + 0.42 = 1.38 ns
* RDn, RX_CTL to RXC: 0.96 + 0.42 = 1.38 ns

(a) Why is there a delay betweem TX_CTL and TDn? I would assume that they 
should be in sync, same as RDn and RX_CTL. Is this something specific to 
your boards?

(b) On the TX side, i.MX6Q has TskewT = -0.1...0.9 ns (according to the 
i.MX6Q data sheet), so the total data-to-clock delay at the PHY is 
0.86...1.86 ns. This may violate the RGMII spec, which requires 1...2.6 ns 
(1.8 ns typ). Is there a reason for this?

Using a TXDn-to-TXC skew of 1.38 ns would result in a total of 1.28..2.28 
ns, which is even nicely centered at 1.78 ns.

(c) On the RX side, KSZ9031 adds an integrated clock delay of 1.2 ns, so 
the total data-to-clock delay is 2.58 ns. This is just barely within the 
requirements from the i.MX6Q data sheet (1...2.6 ns, same as RGMII). Is 
there a reason for this?

My guess is that the settings were copied from KSZ9021, which does not 
have an integrated RX clock delay. Actually, we don't need any additional 
skew with KSZ9031 -- 1.2 ns is fine. If at all, I would use just 0.6 ns, 
to get a total of 1.8 ns.

Note that the current settings do work, since both sides are fairly 
tolerant; all that is needed is TXDn-to-TXC skew >= 0.06 ns, RXDn-to-RXC 
skew >= -1.14 ns (I ran some tests). Still, I would like to understand 
where the settings came from. Is there something I have overlooked?

Best regards,
Thomas Betker
