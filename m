From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Mar 2013 10:54:41 +0100
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130212223511.GB31555@obsidianresearch.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1360686546-24277-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130212223511.GB31555@obsidianresearch.com>
Message-ID: <20130306105441.4d24033e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Tue, 12 Feb 2013 15:35:11 -0700, Jason Gunthorpe wrote:

> > +	pcie at 0,0 {
> > +		device_type = "pciex";
> > +		reg = <0x0800 0 0xd0040000 0 0x2000>;
> 
> It would be great to get this sorted as per my prior comments.. Maybe
> like this is easy?
> 
> pcie-controller {
>  compatible = "marvell,armada-370-xp-pcie";
> 
>  // Index by marvell,pcie-port ?
>  regs = <0xd0040000 0x00002000
>          0xd0080000 0x00002000>;
> 
>  ranges = <0x81000000 0 0  0xc0000000  0 0x00010000   /* downstream I/O */
>            0x82000000 0 0  0xc1000000  0 0x08000000>; /* non-prefetchable memory */
> 
>  pcie at 0,0 {
>       device_type = "pci";
>       reg = <0x0800 0 0 0>; // 00:01.0  (????)
>       marvell,pcie-port = <0>;
>  };
> }
> 
> It is abusive to map the device internal per-port registers through
> '0x00000800 0 0xd0040000' and 'reg' - that is not really the intent of
> the OF spec.

The Device Tree would really look odd. We have one register range for
each PCIe interface, but instead of nicely putting them inside the
pcie at X,Y subnodes, we have a global regs = <..> property at the
pcie-controller level? I can do that if you want, but it really sounds
like the standard PCI DT bindings are horrible. Those register ranges
are *per* PCIe interface, so any logical person would expect them
inside the pcie at X,Y node...

But ok, if that's the way things should be, so be it.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
