From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Sep 2011 20:18:48 +0100
Subject: [RFC] Need help deciphering reboot modes!
In-Reply-To: <20110930125725.GG3895@e102144-lin.cambridge.arm.com>
References: <20110930125725.GG3895@e102144-lin.cambridge.arm.com>
Message-ID: <20110930191847.GA11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 01:57:25PM +0100, Will Deacon wrote:
> As part of my kexec work, I've been looking at the machine_restart path
> on ARM and, more specifically, the use of the reboot_mode character that
> gets passed around and ultimately ignored.

It gets ignored because platform maintainers are a lazy bunch of people
and don't want to write any more code than they absolutely have to.

Overall, it is meant as a hint to the platform code about what reboot
method to use.

> It seems that the following mode characters are used:
> 
> 0	-> Currently used by kexec as a dummy argument given that it is
> 	   ignored anyway.

No idea what that means, afaik it's never been used.

> 'h'	-> The default assignment to reboot_mode and that used by
> 	   machine_restart. For some reason, reboot_mode can also be
> 	   overridden on the command line. I would guess that this means
> 	   "hard".

It does mean 'hard' and it tells platforms which have the option (the
early ones do!) to use some hardware method to provoke the machine into
rebooting.

> 's'	-> A supported option by mioa701 (mach-pxa) and mach-s3c24xx. I
> 	   would guess that this means "soft".

This means to reboot by vectoring through the reset vector - so it is
'soft'.

> 'g'	-> A supported option by spitz and tosa (both mach-pxa). I can't
> 	   begin to imagine what it might stand for.

'gpio', using a gpio signal to cause the reboot rather than setting up
a watchdog or something to cause it.

Note that as I say above, it is only a hint - if you pass 's' for soft,
a platform can still elect to do a hard reboot if it knows that soft
reboots just don't work on the platform.
