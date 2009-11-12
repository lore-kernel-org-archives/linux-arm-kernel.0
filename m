From: alex@digriz.org.uk (Alexander Clouter)
Date: Thu, 12 Nov 2009 18:52:51 +0000
Subject: [PATCH] [ARM] Kirkwood: Prevent kernel from crashing if
	PCIe?bridge?is present
References: <200911121519.42786.dk-arm-linux@gmx.de>
	<p0nts6-gt3.ln1@chipmunk.wormnet.eu>
	<200911121802.10323.dk-arm-linux@gmx.de>
Message-ID: <352us6-035.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:
> 
> If we go on thinking about that - I would prefer place the code - 
> without the magick key ;) - in kirkwood_pcie_init()?
>
> It will affect later or sooner more kirkwood boards if people switch 
> form marvell stock u-boot to mainline u-boot.
>
> What do you think about that?
>
No idea, I could try it on both my SheevaPlug and OpenRD-Client, but 
as they are 'in production' and 200 miles away from where I am...I am 
slightly hesitate to update u-boot and test a kernel :)

> to [2]: Hm, is this really right? Why is there a function called 
> openrd_base_pci_init() which is inside a file called 
> openrd_base-setup.c and this function is called on a sheevaplug?
> 
> I couldn't believe that (but to be honest I don't know it!).
> The 2 board do still have different machnumbers, right?
> I've expected that these machnumbers are to determine
> which board / hardware the kernel / u-boot is running.
> Isn't this the case?
>
My understanding is that the subsys_initcall() primes a particular 
function to be called at a particular point when the kernel fires up.  
As this code is *always* run regardless of machine ID[1] then you can 
run into problems as that code will be run on SheevaPlugs too.

include/linux/init.h might explain things better than I have.  It means 
the PCI init code is called *after* all the architecture/platform stuff 
is done, but before device drivers and filesystem support is enabled.

Cheers
 
[1] look at the MACHINE_START function, the entry points do not hook 
	anywhere into the PCI init code, that is called 'out-of-bound'

-- 
Alexander Clouter
.sigmonster says: Every time I lose weight, it finds me again!
