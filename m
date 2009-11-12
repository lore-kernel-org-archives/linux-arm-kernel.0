From: alex@digriz.org.uk (Alexander Clouter)
Date: Thu, 12 Nov 2009 15:42:49 +0000
Subject: [PATCH] [ARM] Kirkwood: Prevent kernel from crashing if PCIe
	bridge?is present
References: <200911121519.42786.dk-arm-linux@gmx.de>
Message-ID: <p0nts6-gt3.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
>
> [snipped]
> 
> static int __init openrd_base_pci_init(void)
> {
> +       u32 cpu_config_reg;
> +       void __iomem *base;
> +       base = ioremap(0xf1020100, 4);
>
Ewwwwwwww. :)

If you dig through arch/arm/mach-orion5x/include/mach/orion5x.h you 
should be able to work out that 0xf1020100 is probably best replaced 
with something like (ORION5X_BRIDGE_PHYS_BASE | 0x100), once you add
a matching ORION5X_BRIDGE_PHYS_BASE entry alongside the
ORION5X_BRIDGE_VIRT_BASE[1].  Well, *I* prefer that sort of thing. :)

> +       if (base)
> +       {
> +               cpu_config_reg = readl(base);
> +               cpu_config_reg &= ~(1 << 2);
> +               writel(cpu_config_reg, base);
> +       }
> +       iounmap(base);
> +
>        if (machine_is_openrd_base())
>                kirkwood_pcie_init();
> -
>        return 0;
>  }
> subsys_initcall(openrd_base_pci_init);
>
As was recently explained to me[2], that code is going to run on *all* 
kirkword platforms, not just the OpenRD.  I am guessing you want to 
shove your additional code into a seperate int returning __init function 
and call it from the machine_is_openrd_base() clause.

Also, if for some strange reason the ioremap() failed, you are going to 
call iounmap(NULL) so that should probably be moved up a line into the 
'if' clause?  However on this one I *think* I have been told in the past 
it cannot fail so you might be able to remove the 'if' clause 
altogether.

Cheers

[1] unsure if at that point can can just jump straight in and tinker with
	ORION5X_BRIDGE_VIRT_BASE?
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/002699.html

-- 
Alexander Clouter
.sigmonster says: Most people's favorite way to end a game is by winning.
