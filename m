From: shaohui.xie@nxp.com (Shaohui Xie)
Date: Thu, 18 Aug 2016 10:27:36 +0000
Subject: [PATCH 1/5] arm64: dts: add QorIQ LS1046A SoC support
In-Reply-To: <1984740.gmAYAJ1bIT@wuerfel>
References: <1467972944-12293-1-git-send-email-shh.xie@gmail.com>
 <1467972944-12293-2-git-send-email-shh.xie@gmail.com>
 <1984740.gmAYAJ1bIT@wuerfel>
Message-ID: <DB5PR0401MB21834BD67F0EA86B3A22E9D6E8150@DB5PR0401MB2183.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

Thank you for reviewing!

I'm seriously Sorry for the late response! I was on business travel on a project and had been very busy for a  long time.

Please see inline.

Regards,
Shaohui
> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Friday, July 08, 2016 8:00 PM
> To: shh.xie at gmail.com
> Cc: devicetree at vger.kernel.org; robh+dt at kernel.org; mark.rutland at arm.com;
> pawel.moll at arm.com; ijc+devicetree at hellion.org.uk; galak at codeaurora.org;
> linux-arm-kernel at lists.infradead.org; catalin.marinas at arm.com;
> will.deacon at arm.com; Mingkai Hu <mingkai.hu@nxp.com>; Mihai Emilian Bantea
> <mihai.bantea@nxp.com>; Qianyu Gong <qianyu.gong@nxp.com>; Minghuan Lian
> <minghuan.lian@nxp.com>; Zhiqiang Hou <zhiqiang.hou@nxp.com>; Shaohui Xie
> <shaohui.xie@nxp.com>
> Subject: Re: [PATCH 1/5] arm64: dts: add QorIQ LS1046A SoC support
> 
> On Friday, July 8, 2016 6:15:40 PM CEST shh.xie at gmail.com wrote:
> > +
> > +	memory at 80000000 {
> > +		device_type = "memory";
> > +		reg = <0x0 0x80000000 0 0x80000000>;
> > +		      /* DRAM space 1, size: 2GiB DRAM */
> > +	};
> 
> The memory size is usually in the .dts file, unless this is on-chip eDRAM.
[S.H] The memory size will be fixup by U-boot, if it's not proper to have it in .dtsti,
How about remove it?

> > +		clockgen: clocking at 1ee1000 {
> > +			compatible = "fsl,ls1046a-clockgen";
> 
> > +		scfg: scfg at 1570000 {
> > +			compatible = "fsl,ls1046a-scfg", "syscon";
> 
> > +		dcfg: dcfg at 1ee0000 {
> > +			compatible = "fsl,ls1046a-dcfg", "syscon";
> 
> None of the fsl,ls1046a-* devices seem to have any binding documentation.
[S.H] Will update binding for fsl,ls1046-* devices in next version.

> 
> > +		wdog0: wdog at 2ad0000 {
> 
> watchdog at 2ad0000
[S.H] Will fix it.

> 
> > +		usb0: usb3 at 2f00000 {
> 
> usb at 2f00000
[S.H] Will fix it.

> 
> > +		pcie at 3400000 {
> > +			compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
> > +			reg = <0x00 0x03400000 0x0 0x00100000   /* controller
> registers */
> > +			       0x40 0x00000000 0x0 0x00002000>; /* configuration
> space */
> > +			reg-names = "regs", "config";
> > +			interrupts = <0 118 0x4>, /* controller interrupt */
> > +				     <0 117 0x4>; /* PME interrupt */
> > +			interrupt-names = "intr", "pme";
> > +			#address-cells = <3>;
> > +			#size-cells = <2>;
> > +			device_type = "pci";
> > +			num-lanes = <4>;
> > +			bus-range = <0x0 0xff>;
> > +			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000
> 0x0 0x00010000   /* downstream I/O */
> > +				  0x82000000 0x0 0x40000000 0x40 0x40000000
> 0x0 0x40000000>; /*
> > +non-prefetchable memory */
> 
> No prefetchable memory area?
> 
> > +			msi-parent = <&msi>;
> 
> You seem to have a gic-400, could you use that as the MSI sink instead?
> 
> > +			#interrupt-cells = <1>;
> > +			interrupt-map-mask = <0 0 0 7>;
> > +			interrupt-map = <0000 0 0 1 &gic 0 110 0x4>,
> > +					<0000 0 0 2 &gic 0 110 0x4>,
> > +					<0000 0 0 3 &gic 0 110 0x4>,
> > +					<0000 0 0 4 &gic 0 110 0x4>;
> > +		};
> >
> 
> If the four interrupts are all the same, why do you have separate entries?
[S.H] We are working on refining the MSI driver and the MSI node will also be changed, 
so the MSI and PCIe node will be added together with the MSI driver updates.
In the next version, I will drop the MSI node and PCIe node.

Thank you!
