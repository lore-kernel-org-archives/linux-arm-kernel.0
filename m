From: holgerschurig@gmail.com (Holger Schurig)
Date: Mon, 2 Jun 2014 15:15:21 +0200
Subject: iMX6Q FEC: transmit queue 0 timed out
In-Reply-To: <20140602124242.GB933@n2100.arm.linux.org.uk>
References: <CAOpc7mF4naY8xuBDFNpHuQPsrULVriKj-ZcpEwpPwtA8UT1Wpw@mail.gmail.com>
 <20140602124242.GB933@n2100.arm.linux.org.uk>
Message-ID: <CAOpc7mFbJQNeBmOG0C-Qn856MmhtUkTq=QeDPC-EWXryi6sFGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Transmit clocking and pinmux?  Do you mean ENET_TX_EN?  Yep, that's
set. Somehow barebox can send, it's just Linux that doesn't want to do
it. Note that ENET_TX_CLK is not muxed, as it is for MII, not for
RMII.

In case I confuse what you meant, here are excerpts from my DTS:

&fec {
   pinctrl-names = "default";
   pinctrl-0 = <&pinctrl_fec>;
   phy-mode = "rmii";
   phy-reset-gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
   status = "okay";
};

...

pinctrl_fec: fecgrp {
   fsl,pins = <
      MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0 0x1b030
      MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1 0x1b030
      MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN   0x1b030
      MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0 0x1b030
      MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1 0x1b030
      MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER   0x1b030
      MX6QDL_PAD_ENET_MDIO__ENET_MDIO     0x0B850
      MX6QDL_PAD_ENET_MDC__ENET_MDC       0x1b030
      MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN  0x1b030
      MX6QDL_PAD_GPIO_16__ENET_REF_CLK    0x1b030
      >;
};


Or did you mean the clocks internal to the CPU?  So far I didn't
really care for them, because I thought that the clocking framework in
conjunction with the device tree takes care of that. Hmm, in the
refernce manual, chapter 23.3 they talk about mac0_txmem_clk, which
isn't in that list. If I read the manual correct, this is enabled by
enet_clk_enable, so let's look into CCGR1:

/ # devmem 0x20C406c
0xF0FCFC00
                                      ...
Hmm, the first 'C' from the right contains bits 10-11 (CCM_CCGR1.CG5)
and they are both set, so enet_clk_enable is also on.
