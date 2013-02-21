From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 21 Feb 2013 11:27:24 -0700
Subject: [U-Boot] [RFC] Kbuild support for ARM FIT images
In-Reply-To: <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com>
 <20130221103705.GB17852@n2100.arm.linux.org.uk>
 <51261F38.2030902@ti.com>
 <20130221134656.GC17852@n2100.arm.linux.org.uk>
 <51262A7A.8040103@ti.com>
 <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
Message-ID: <20130221182724.GA14329@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 12:25:21PM -0500, Nicolas Pitre wrote:

> So let's stop kidding ourselves and be coherent please: either we move 
> device specifics away from the kernel, or we keep them together.  In 
> other words, the DT should ideally come preinstalled with the bootloader 
> on a given board/device for distros to not even have to care about it, 
> or we put that data back inside the kernel and dispense ourselves from 
> all the added DT overhead entirely.  But an hybrid mixed solution like 
> FIT is IMHO the worst of both worlds and sending a wrong message.

Just to thread jack a bit here..

We've been using DT on production embedded stuff sice about 2.6.20ish
on PPC and now ARM. We treat the dtb as a kernel version specific
file, much like an initrd and ensure that the kernel only ever boots
with its proper dtb. This is based on experience that the dtbs change
depending on the state of the drivers in the kernel, what gets
mainlined and when, etc.

Embedding this stuff into the bootloader is *not* desirable for my
embedded scenarios. We don't use FIT (or uboot) but we do the same
thing: a single image is constructed with the proper dtb, kernel and
initrd, and that is what the bootloader boots.

Why? This is an embedded appliance product. We need to be able to
deliver firmware upgrades that *work*. We can't brick the board
because the bootloader and kernel get out of sync. The boot loader has
to be *simple*, it has to boot every past, present and future kernel
or we start taking risks that a firmware flash will end up bricking
it.

People making dev boards and distros for them certainly have different
requirements, but we've decided that the single image approach is the
best for appliance style products.

Jason
