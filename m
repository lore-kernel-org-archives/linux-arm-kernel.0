From: david.jander@protonic.nl (David Jander)
Date: Thu, 22 Jul 2010 14:10:09 +0200
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <AANLkTinQS3vkua2dW0iPpXKDJizVIIKgqcBol2FhuRW_@mail.gmail.com>
References: <201007211029.29529.david.jander@protonic.nl>
	<20100722072034.GA6802@n2100.arm.linux.org.uk>
	<AANLkTinQS3vkua2dW0iPpXKDJizVIIKgqcBol2FhuRW_@mail.gmail.com>
Message-ID: <201007221410.10087.david.jander@protonic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all,

Thanks for all the reactions.

On Thursday 22 July 2010 10:16:17 am Magnus Damm wrote: 
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Jul 22, 2010 at 11:32:53AM +0900, Simon Horman wrote:
> >> Would it be feasible to  use Linux + kexec as the boot loader as
> >> a long term solution to fixing boot loaders by eliminating them?
> >
> > So what you're proposing is that a broken boot loader should boot a
> > version of Linux to fix the pin MUX, which then kexecs a kernel which
> > doesn't have that code?
> 
> I think Simon was proposing to remove the broken boot loader.

IMO, if a bootloader is broken (in any way), it needs replacing. Be it with 
another bootloader or directly with the kernel.
I am working on i.MX51 right now, and that chip has it's own tiny bootloader 
in ROM, which is able to load an image from SPI-NOR, SDHC, NAND, and some 
other places, as well as initialize the DRAM controller with settings 
contained at the beginning of the boot image. In theory it could just as well 
boot a linux kernel directly. There is no real need for RedBoot, u-boot or 
whatever other bootloader. In that case, all hardware setup code needs to be 
done in the boot-code of the kernel.

> > What's the point of that - when the first kernel will be able to run
> > the system?
> 
> If you boot straight into a Linux kernel (CONFIG_ZBOOT_ROM on ARM ?)
> and use that to boot your real system, then at least you only need one
> copy of pinmux setup code. If it gets executed once or twice is a
> matter of system configuration IMO.

That sounds a lot "saner" to me than having two asynchronous and different 
copies of setup-code, which could be a potential nightmare, besides not being 
really maintainable.

> That aside, not trusting the boot loader is probably a good idea. =)

Why? If there's a boot-loader, it should know the correct hardware setup much 
better than any other piece of software.
Its fundamental role _IS_ basic hardware setup!

If bootloaders are broken, and delivered with the hardware, you should either 
complain to the hardware manufacturer or fix the bootloader yourself if 
possible... but not work around it.

Most of the time, if there are minor hardware changes, the linux kernel 
shouldn't be involved if it is not necessary. The BIOS/Bootloader should 
implement the necessary setup changes (if any). That way you don't need 
different kernels for different hardware revisions.

The rationale is simple: The bootloader is bound to and unique to the specific 
board configuration and -revision, whereas the kernel shoudn't change for a 
given platform. Ideally one whould compile one kernel for a generic type of 
i.MX51 machine, and that kernel should just work on all of them, that are 
generic enough. An example of how to accomplish this is Open-Firmware device-
tree support on the PowerPC architecture.

Right now you need different BSPs for all different i.MX51 boards (you can 
compile them all in at once, ok), and potentially also for different revisions 
of the same board.

The discussion sparked unintentionally by this thread is quite interesting, 
and it seems that there are (as always) more than one possible solution 
(kexec, etc). May I suggest Open-Firmrea device-trees and fixed bootloaders as 
another one?

@Russell: I know, I am being optimistic and arrogant here, my excuses if that 
offends you, but I simply can't believe the general state of bootloaders and 
hardware platforms for ARM is so terribly broken, that it can't be fixed in 
"the right way".

As for my own part of responsibility, I am designing a new ARM-based board 
right now (actually working on a prototype already), and I am determined to 
deliver a bootloader that does all hardware setup correctly, and the linux BSP 
I am writing will have no pad-setup code whatsoever. That's a promise!

Best regards,

-- 
David Jander
Protonic Holland.
