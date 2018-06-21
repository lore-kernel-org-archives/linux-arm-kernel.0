From: MNARANI@xilinx.com (Manish Narani)
Date: Thu, 21 Jun 2018 12:41:37 +0000
Subject: [RFC PATCH 2/3] dt: bindings: Add SD tap value properties details
In-Reply-To: <20180607124743.fqo7f7nxonn2k3b5@lakrids.cambridge.arm.com>
References: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
 <1528373500-24663-2-git-send-email-manish.narani@xilinx.com>
 <20180607124743.fqo7f7nxonn2k3b5@lakrids.cambridge.arm.com>
Message-ID: <SN6PR02MB49591B89BEB8DB28710023ABC1760@SN6PR02MB4959.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Thursday, June 7, 2018 6:18 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: robh+dt at kernel.org; catalin.marinas at arm.com; will.deacon at arm.com;
> mdf at kernel.org; stefan.krsmanovic at aggios.com; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
> mmc at vger.kernel.org; devicetree at vger.kernel.org; adrian.hunter at intel.com;
> michal.simek at xilinx.com; ulf.hansson at linaro.org
> Subject: Re: [RFC PATCH 2/3] dt: bindings: Add SD tap value properties details
> 
> On Thu, Jun 07, 2018 at 05:41:39PM +0530, Manish Narani wrote:
> > This patch adds details of SD tap value properties in device tree.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  .../devicetree/bindings/mmc/arasan,sdhci.txt       | 26
> ++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > index 60481bf..0e08877 100644
> > --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > @@ -15,6 +15,8 @@ Required Properties:
> >      - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
> >      - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
> >        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> > +    - "xlnx,zynqmp-8.9a": Xilinx ZynqMP Arasan SDHCI 8.9a PHY
> > +      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> >    - reg: From mmc bindings: Register location and length.
> >    - clocks: From clock bindings: Handles to clock inputs.
> >    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> > @@ -26,6 +28,30 @@ Required Properties for "arasan,sdhci-5.1":
> >    - phys: From PHY bindings: Phandle for the Generic PHY for arasan.
> >    - phy-names:  MUST be "phy_arasan".
> >
> > +Required Properties for "xlnx,zynqmp-8.9a":
> > +  - xlnx,mio_bank: The value will be 0/1/2 depending on MIO bank selection.
> 
> For all of these properties, please s/_/-/, folowing the usual property name
> conventions.
I will correct this in the next version.
> 
> It's not clear to me why you need this property. The code in patch 3 only seems
> to use this to determine which properties to read, choosing between <prop>_b0
> or <prop>_b2. I don't see why you dont have the base <prop> alone...
The property 'xlnx,mio_bank' will be different for various ZynqMP varients. So different ZynqMP dts files may have different values for 'xlnx,mio_bank'. That's why I am maintaining _b0 and _b2 as different values
> 
> Is this a HW detail, or configuration that you prefer?
These are SD tap values which are generally used for configuring taps in SD. Keeping it in device tree makes it User Configurable without changing the driver code.
> 
> > +  - xlnx,device_id: Unique Id of the device, value will be 0/1.
> 
> What's this used for?
This used to identify the controller ID between two SD controllers present on ZynqMP.
> 
> > +  - xlnx,itap_delay_sd_hsd: Input Tap Delay for SD HS.
> 
> What unit at hese delays in?
The tap values don't have specific units. They are generally a fraction of the clock cycle.
For the SD frequency of -
200 MHz: 30 Input taps are available
100 MHz: 60 Input taps are available
50 MHz: 120 Input taps are available
200 MHz: 8 Output taps are available
100 MHz: 15 Output taps are available
50 MHz: 30 Output taps are available

Thanks,
Manish
> 
> Please follow the conventions in
> Documentation/devicetree/bindings/property-units.txt.
> 
> > +  - xlnx,itap_delay_sdr25: Input Tap Delay for SDR25.
> > +  - xlnx,itap_delay_sdr50: Input Tap Delay for SDR50.
> > +  - xlnx,itap_delay_sdr104_b0: Input Tap Delay for SDR104.
> > +  - xlnx,itap_delay_sdr104_b2: Input Tap Delay for SDR104.
> 
> As above, Given you have to specify the bank, I don't see why you need multiple
> properties.
> 
> Thanks,
> Mark.
> 
> > +  - xlnx,itap_delay_sd_ddr50: Input Tap Delay for SD DDR50.
> > +  - xlnx,itap_delay_mmc_hsd: Input Tap Delay for MMC HS.
> > +  - xlnx,itap_delay_mmc_ddr50: Input Tap Delay for MMC DDR50.
> > +  - xlnx,itap_delay_mmc_hs200_b0: Input Tap Delay for MMC HS200.
> > +  - xlnx,itap_delay_mmc_hs200_b2: Input Tap Delay for MMC HS200.
> > +  - xlnx,otap_delay_sd_hsd: Output Tap Delay for SD HS.
> > +  - xlnx,otap_delay_sdr25: Output Tap Delay for SDR25.
> > +  - xlnx,otap_delay_sdr50: Output Tap Delay for SDR50.
> > +  - xlnx,otap_delay_sdr104_b0: Output Tap Delay for SDR104.
> > +  - xlnx,otap_delay_sdr104_b2: Output Tap Delay for SDR104.
> > +  - xlnx,otap_delay_sd_ddr50: Output Tap Delay for DDR50.
> > +  - xlnx,otap_delay_mmc_hsd: Output Tap Delay for MMC HS.
> > +  - xlnx,otap_delay_mmc_ddr50: Output Tap Delay for MMC DDR50.
> > +  - xlnx,otap_delay_mmc_hs200_b0: Output Tap Delay for MMC HS200.
> > +  - xlnx,otap_delay_mmc_hs200_b2: Output Tap Delay for MMC HS200.
> > +
> >  Optional Properties:
> >    - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/syscon.txt)
> >      used to access core corecfg registers.  Offsets of registers in
> > this
> > --
> > 2.7.4
