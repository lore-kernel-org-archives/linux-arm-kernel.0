From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 19 Feb 2016 12:57:43 -0500 (EST)
Subject: [PATCH 4/9] ARM: add CONFIG_PHYS_OFFSET default values
In-Reply-To: <20160219164344.GY19428@n2100.arm.linux.org.uk>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <3974581.yknKb3tq7o@wuerfel>
 <HK2PR06MB056137892B6F968A8A1008C58AA00@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <14272873.q312Ii8Axy@wuerfel> <20160219164344.GY19428@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.20.1602191239020.13632@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Feb 2016, Russell King - ARM Linux wrote:

> ARM_PATCH_PHYS_VIRT exists to support an init-time decided phys offset,
> and it supports this by modifying each location that the phys offset
> is used.  It determines this by looking at the location that the early
> init code is executing, and masking the PC with a value that has been
> carefully crafted to fit 99% of the existing platforms.
> 
> One of the side effects of ARM_PATCH_PHYS_VIRT is that we hide the
> translation from the compiler, so the compiler is unable to optimise
> things like virt_to_phys(phys_to_virt(x)) to just 'x' (and yes, such
> things do happen.)
> 
> PHYS_OFFSET exists to cater for the case where ARM_PATCH_PHYS_VIRT is
> disabled, because either ARM_PATCH_PHYS_VIRT does not work for the
> platform, or the platform has special requirements and/or requires
> better performance.  It switches back to the pre-ARM_PATCH_PHYS_VIRT
> situation where the PHYS_OFFSET is a compile time constant.
> 
> Obviously, making PHYS_OFFSET a runtime variable is basically what
> ARM_PATCH_PHYS_VIRT is doing.  That does not help these cases though,
> because the problem cases are not whether it's a runtime variable or
> not, it's how to arrive at the value for it in the first place.

I think what Chris was suggesting is to have the same functionality as 
PATCH_PHYS_VIRT i.e. determining phys offset at run time while being 
XIP.  In theory that could mean that the kernel binary becomes 
independent of the physical location in flash where it executes from.

Arriving at the value for phys offset could be done based on sp instead 
of pc.  That's assuming the bootloader did not clobber sp before calling 
into the kernel.

But this is rather fragile. And normally if you are interested in XIP, 
you certainly have a highly customized kernel config already anyway. And 
having a build-time constant PHYS_OFFSET is of course what performs 
best.


Nicolas
