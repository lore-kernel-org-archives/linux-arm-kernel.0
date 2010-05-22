From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 22 May 2010 11:36:27 +0200
Subject: Initrd and 2.6.33 curious behaviour
In-Reply-To: <20100521204343.GA18032@n2100.arm.linux.org.uk> (Russell King's
	message of "Fri\, 21 May 2010 21\:43\:43 +0100")
References: <874oi157c6.fsf@free.fr>
	<20100521204343.GA18032@n2100.arm.linux.org.uk>
Message-ID: <87r5l446sk.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Fri, May 21, 2010 at 10:27:05PM +0200, Robert Jarzmik wrote:
>> I pulled the 2.6.33 kernel and tried my mainboard with it (mioa701). My
>> kernel boots fine, but initrd load always fails.
>
> Please post all the kernel messages.

If only I could ...
I have no serial console, only the screen, and until initrd is loaded, no
network connection. The mioa701 is a smartphone, with no keyboard, and only
bluetooth and USB as a communication mean.

The only thing I can see is the console output on the framebuffer, which is damn
small.

I was thinking that if at least 1 person could load the initrd, then I would
have no other choice but investigate. But if all people have the same problem,
there would be someone with a development board who will have a full console
output and find the issue easier.

>> After digging a bit in arch/arm/mm/init.c, I find that :
>>  - phys_initrd_start = 0xa0508000
>>  - phys_initrd_size = 3 759 480
>>  - initrd_start = 0 and initrd_end = 0
>
> It's unclear where you're checking this.  The virtual pointers are only
> setup if we're satisfied that the phys_* are within RAM, and we can
> exclusively reserve the region.
I added printk in do_mounts_rd.c, in the first lines of rd_load_image().
I had to remove the "static" statement from phys_initrd_* declaration in init.c,
and added extern declarations to reach the phys_initrd_* variables.

> If we can't reserve the region, that means something's overwritten it
> during kernel boot and it's become unusable.
When you say "overwritten", what is the criteria ? (ie. is it at least one byte
is non-zero, checksum failed, ...).

Or alternatively, is there a clever way of storing some data relative to
reserve_bootmem_node() or __reserve() to be printed at the tail of kernel log
(ie. in do_mounts_rd()) which would help me investigate ?

Cheers.

--
Robert
