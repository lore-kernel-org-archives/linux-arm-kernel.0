From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Oct 2011 10:43:38 +0100
Subject: [RFC] Need help deciphering reboot modes!
In-Reply-To: <20110930191847.GA11710@n2100.arm.linux.org.uk>
References: <20110930125725.GG3895@e102144-lin.cambridge.arm.com>
	<20110930191847.GA11710@n2100.arm.linux.org.uk>
Message-ID: <20111003094338.GA3827@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Thanks for getting back to me.

On Fri, Sep 30, 2011 at 08:18:48PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 30, 2011 at 01:57:25PM +0100, Will Deacon wrote:
> > As part of my kexec work, I've been looking at the machine_restart path
> > on ARM and, more specifically, the use of the reboot_mode character that
> > gets passed around and ultimately ignored.
> 
> It gets ignored because platform maintainers are a lazy bunch of people
> and don't want to write any more code than they absolutely have to.
> 
> Overall, it is meant as a hint to the platform code about what reboot
> method to use.

Right, ok.

> > It seems that the following mode characters are used:
> > 
> > 0	-> Currently used by kexec as a dummy argument given that it is
> > 	   ignored anyway.
> 
> No idea what that means, afaik it's never been used.

I think it's just a lazy kexec implementation. Passing 's' would make more
sense.

> > 'h'	-> The default assignment to reboot_mode and that used by
> > 	   machine_restart. For some reason, reboot_mode can also be
> > 	   overridden on the command line. I would guess that this means
> > 	   "hard".
> 
> It does mean 'hard' and it tells platforms which have the option (the
> early ones do!) to use some hardware method to provoke the machine into
> rebooting.

So in terms of setup_mm_for_reboot (which takes the reboot mode as a
parameter), the 'h' mode should ensure that we don't remap kernelspace
as 1:1 because we need to poke hardware (alternatively we could poke the
hardware using its physical address).

> > 's'	-> A supported option by mioa701 (mach-pxa) and mach-s3c24xx. I
> > 	   would guess that this means "soft".
> 
> This means to reboot by vectoring through the reset vector - so it is
> 'soft'.

And in this case we want to identity map as much as possible so the MMU-off
path works properly.

> > 'g'	-> A supported option by spitz and tosa (both mach-pxa). I can't
> > 	   begin to imagine what it might stand for.
> 
> 'gpio', using a gpio signal to cause the reboot rather than setting up
> a watchdog or something to cause it.

Can we get rid of this option in favour of 'h'? I'm not sure I see the
distinction and I think the platform can handle it itself. I posted a patch
here but I'm unable to test it:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-September/067560.html

> Note that as I say above, it is only a hint - if you pass 's' for soft,
> a platform can still elect to do a hard reboot if it knows that soft
> reboots just don't work on the platform.

Hmm, this could be problematic with the memory mapping bits I mentioned
above. Going from 's' -> 'h' will only work if physical addresses are used
to access the hardware and going from 'h' -> 's' will only work if the
physical address of the reset code is less than PAGE_OFFSET. We could
introduce a new flag for setup_mm_for_reboot, but that feels slightly
redundant given that we already have the mode option.

What do you reckon?

Cheers,

Will
