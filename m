From: yehuday@marvell.com (Yehuda Yitschak)
Date: Thu, 28 Sep 2017 13:18:40 +0000
Subject: [EXT] [PATCH 1/2] arm64: dts: marvell: fix interrupt-map property
 for Armada CP110 master PCIe controller
In-Reply-To: <20170928145647.35f21186@windsurf.lan>
References: <20170928124550.11492-1-thomas.petazzoni@free-electrons.com>
 <20170928124550.11492-2-thomas.petazzoni@free-electrons.com>
 <2164f35d99974e1480790dac98be4a5d@IL-EXCH02.marvell.com>
 <20170928145647.35f21186@windsurf.lan>
Message-ID: <bfd1e045ba7d4e82a3d9f00c913a1d14@IL-EXCH02.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yes...but 

That zero you removed is the "parent unit address" according to the "interrupt-map" documentation 

	parent unit address  - The unit address in the domain of the interrupt parent. The number of 32-bit
			            cells required to specify this address is described by the #address-cells property of the node
			           pointed to by the interrupt-parent field.

Now,  the gic has #address-cells =  <0x1>
And the icu has  #address-cells = <0x0>

So when switching to ICU, the parent unit address was no longer needed and should have been removed 

Best Regards

Yehuda


> -----Original Message-----
> From: Thomas Petazzoni [mailto:thomas.petazzoni at free-electrons.com]
> Sent: Thursday, September 28, 2017 15:57
> To: Yehuda Yitschak
> Cc: Jason Cooper; Andrew Lunn; Sebastian Hesselbarth; Gregory Clement;
> Nadav Haklai; Hanna Hawa; Antoine Tenart; Miqu?l Raynal; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [EXT] [PATCH 1/2] arm64: dts: marvell: fix interrupt-map
> property for Armada CP110 master PCIe controller
> 
> Hello,
> 
> On Thu, 28 Sep 2017 12:52:07 +0000, Yehuda Yitschak wrote:
> 
> > The initial version referenced the GIC interrupt controller.
> > Maybe this issue was introduced during the switch to the ICU  ?
> 
> No, it was not introduced by the switch to the ICU. The switch to the ICU
> looked like this:
> 
> -                       interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 34
> IRQ_TYPE_LEVEL_HIGH>;
> -                       interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-map = <0 0 0 0 &cpm_icu 0 ICU_GRP_NSR 24
> IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupts = <ICU_GRP_NSR 24
> + IRQ_TYPE_LEVEL_HIGH>;
> 
> As you can see there was already a bogus "0" after &gic.
> 
> Best regards,
> 
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
