From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Mar 2011 19:52:57 -0000
Subject: Single-stepping ARMv7 with KDB...
In-Reply-To: <AANLkTikL0KUdY5Ggv1BRfRQiwxyd9B6ooMXT2rPoVAxA@mail.gmail.com>
References: <AANLkTimBAm-Eaordw-KSPnEycQYz2z4QM+Dc5nauLFxh@mail.gmail.com>	<766766263404232078@unknownmsgid>
	<AANLkTikL0KUdY5Ggv1BRfRQiwxyd9B6ooMXT2rPoVAxA@mail.gmail.com>
Message-ID: <002b01cbe8ca$be358f10$3aa0ad30$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrei,

> > x86 uses the hw_breakpoint framework for handling hardware breakpoints
> > in KGDB (see kgdb_correct_hw_break for how it converts breakinfo
> > structures into perf_events) so it might be possible to do something
> > similar for single-step on ARM if we allow the kernel to specify that
> > the breakpoint is to be a mismatch by poking the step_ctrl field in
> > the arch_hw_breakpoint struct.
> 
> ...in this case monitor mode will have to be turned on outside SVC,
> else it will immediately trigger a debug abort inside the code
> programming BRV/BRC for mismatch... I guess that's the point I wanted
> to bring up. I suppose it's only really useful for KDB, as with KGDB
> you can have a debugger take care of branches, and all you would need
> to ensure is to save/restore breakpoints across context switches (and
> reentrancy). I'll play with enabling 'ss' with KDB as soon as I get
> linux-next running on our platform...

At the moment monitor mode is enabled all of the time, so you might
want to add a thread flag when a thread is using hardware debugging
resources. You can check that on return to userspace and enable monitor
mode only then (I'm not sure about your ABT trick, need to check the
docs). There will still be places in the hardware breakpoint code where
we need monitor mode enabled so you'll need to bank any mismatch
breakpoints over these regions of code and disable monitor mode before
reinstalling them again.

Note that enabling monitor mode is pretty error prone and might not
even be possible on your CPU so the failure path needs to be graceful.

Will
