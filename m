From: marex@denx.de (Marek Vasut)
Date: Fri, 11 Oct 2013 04:13:02 +0200
Subject: [PATCH v7 0/2] Add PCIe support for i.MX6q
In-Reply-To: <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
 <201310101939.44295.marex@denx.de>
 <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com>
Message-ID: <201310110413.02354.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

> On Thu, Oct 10, 2013 at 11:39 AM, Marek Vasut <marex@denx.de> wrote:
> > Hi Bjorn,
> > 
> >> [+cc Yinghai]
> >> 
> >> On Thu, Oct 10, 2013 at 9:58 AM, Marek Vasut <marex@denx.de> wrote:
> >> >> On Thu, Oct 10, 2013 at 4:25 AM, Marek Vasut <marex@denx.de> wrote:
> >> > I tried you suggestion, this is what I got now (and with V7 of the
> >> > patches):
> >> > 
> >> > Note that my topology is: rootport->2_port_switch->ethernet_chip , the
> >> > other port of the switch is not used .
> >> > 
> >> > imx6q-pcie 1ffc000.pcie: phy link never came up

After discussing with Tim a little, looks like a clock bit was missing. The 
above line was the cause of all the issues. Now I can probe the bus, but I still 
need more patches:

This dirty patch here limits the PCIe operation to GEN1 only. It's based on this 
Freescale patch [1]. Without this change, the PCIe switch is not detected. Any 
idea why? (I also had to increase the PHY startup delay to get GEN1 going).

[1] https://www.osadl.org/monitoring/patches/r8s7/1342-ENGR00180230-MX6-PCIE-
enlarge-the-eye-diagram-and-fo.patch

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 32b30ca..df2838b 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -330,13 +330,16 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 
        dw_pcie_setup_rc(pp);
 
+// Enable GEN1
+writel(((readl(pp->dbi_base + 0x7c) & 0xfffffff0) | 0x1), pp->dbi_base + 0x7c);
+
        regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
                        IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
 
        while (!dw_pcie_link_up(pp)) {
                usleep_range(100, 1000);
                count++;
-               if (count >= 10) {
+               if (count >= 200) {
                        dev_err(pp->dev, "phy link never came up\n");
                        dev_dbg(pp->dev,
                                "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",

Best regards,
Marek Vasut
