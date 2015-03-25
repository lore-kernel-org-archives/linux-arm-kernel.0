From: sr@denx.de (Stefan Roese)
Date: Wed, 25 Mar 2015 10:29:58 +0100
Subject: imx6: PCIe imx6_pcie_assert_core_reset() hangs after watchdog reset
Message-ID: <55128016.3030903@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I'm currently facing a problem in the imx6 PCIe driver. The
problem happens, after the Linux imx6 internal watchdog has timed-out
and issues a reset (this is intended, as I'm testing this wdog right
now). But the next Linux boot hangs in imx6_pcie_assert_core_reset()
while accessing a register from the PCIe port logic memory:

		val = readl(pp->dbi_base + PCIE_PL_PFLR);

The watchdog will issue a new reset once it times out again. But
Linux will hang here the next time as well. Only a power-cycle
helps. For a test purpose, I've removed the following part from
this function:

	if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
	    (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
		...
	}

Without it, Linux boots up fine. And PCIe also seems to be fully
functional.

I have to admit that I have no real insight in the imx6 / DW PCIe
driver. So I'm checking with you experts, if you have any ideas why
this could be the case? And how this could be solved.

BTW: This happens with v3.19 and v4.0-rc5 on a i.MX6Solo based board
(TQMa6S SoM). With no PCIe support enabled in the bootloader (U-Boot).

Thanks,
Stefan
