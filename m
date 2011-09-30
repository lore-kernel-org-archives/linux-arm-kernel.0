From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Sep 2011 13:57:25 +0100
Subject: [RFC] Need help deciphering reboot modes!
Message-ID: <20110930125725.GG3895@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

As part of my kexec work, I've been looking at the machine_restart path on ARM
and, more specifically, the use of the reboot_mode character that gets passed
around and ultimately ignored.

It seems that the following mode characters are used:

0	-> Currently used by kexec as a dummy argument given that it is
	   ignored anyway.

'h'	-> The default assignment to reboot_mode and that used by
	   machine_restart. For some reason, reboot_mode can also be
	   overridden on the command line. I would guess that this means
	   "hard".

's'	-> A supported option by mioa701 (mach-pxa) and mach-s3c24xx. I
	   would guess that this means "soft".

'g'	-> A supported option by spitz and tosa (both mach-pxa). I can't
	   begin to imagine what it might stand for.

I would like to update this so that only 'h' and 's' are used, with the
following definitions:

- A hard reboot is made by poking something like a power controller and
  results in a complete platform reset. For this, we need to keep
  kernelspace mapped so that we can access the killer peripheral.

- A soft reboot is made by turning off the MMU and branching to some
  reset code (for example, the kexec reboot buffer). For this, we need
  to identity map as much memory as possible, including some of
  kernelspace.

Anyway, if anybody can enlighten me on the 'g' option, the reboot= parameter
and/or point out holes in my plan, please do! Failing that, I'll start
working on an RFC patch series next week.

Cheers,

Will
