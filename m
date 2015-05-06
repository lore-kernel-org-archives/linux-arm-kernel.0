From: eric@anholt.net (Eric Anholt)
Date: Wed, 06 May 2015 11:51:33 -0700
Subject: BCM2836 (Raspberry Pi 2) port
In-Reply-To: <5540443C.8070604@wwwdotorg.org>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <5540443C.8070604@wwwdotorg.org>
Message-ID: <87a8xh1qve.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 04/21/2015 12:09 PM, Eric Anholt wrote:
>> This is my first submission of a Raspberry Pi 2 port.  It can be found
>> at https://github.com/anholt/linux/tree/bcm2836
>> 
>> I'm using the 2835 interrupt controller support, without adding the
>> checks for ARM local interrupts first.  That means no support for IPIs
>> (and thus no SMP), no PMU events, and no local timer (I'm using the
>> same 2835 peripheral one).
>> 
>> It supports a similar featureset to Pi 1 at this point.  Serial and SD
>> cards work.  Just one CPU supported.  USB (ethernet) works if you use
>> U-Boot, or my mailbox series
>> (https://github.com/anholt/linux/tree/bcm2836-mbox).
>
> Tested-by: Stephen Warren <swarren@wwwdotorg.org>
>
> I applied the patches on top of korg's linux-rpi.git for-rpi-next,
> resolved the io_map conflicts, and tested without U-Boot.
>
> I'll try to work out why it doesn't work with U-Boot. I can't
> immediately see anything in /proc/device-tree that indicates the RPi
> firmware is modifying the DT that's passed to the kernel to exclude any
> CPU1..3 spin tables, so either the kernel isn't hitting those purely by
> luck, or I'm guessing wrong re: the issue with U-Boot.

2836 SMP is now booting on my branch.  Big thanks to Andrea Merello for
doing most of the work on it.  Not-cleaned-up series is available at:

https://github.com/anholt/linux/tree/bcm2836-smp

There's a bunch of stuff in here I'm not sure about:

How do we like the way I'm inheriting 2835 stuff with the includes now?
(It's been a lot less merging work than my initial post had been, but
the /delete-node/ lines for 2386's changes are gross).

How do people feel about putting the 2386 local IRQ handling in the 2835
irqchip code?  Do we like the code sharing for GPU IRQs, or would we
rather have a separate driver?  Could we separate the 2836 local irqs
>From 2835, and have it just call into 2835 for GPU IRQ handling?

Where do people think the arch timer frequency initialization should go
(commit "ARM: BCM2835: Set up the local timer frequency on 2836.")?  On
2709 it's in init_time(), but I hear we've been trying to move away from
these hooks.

Is there a sensible way to share our mapping of the local regs between
the driver and platform bits that need to access them?  (see
arch/arm/mach-bcm/bcm2836_platsmp.c for what we're doing currently)

Is there anything we would want to merge before getting a full working
implementation ready to merge?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150506/f167457b/attachment-0001.sig>
