From: mikpe@it.uu.se (Mikael Pettersson)
Date: Sun, 19 Dec 2010 17:15:09 +0100
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches
In-Reply-To: <20101219144950.GH3047@n2100.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<19725.57447.256528.883703@pilspetsen.it.uu.se>
	<20101219105209.GN9937@n2100.arm.linux.org.uk>
	<19725.64412.395353.947407@pilspetsen.it.uu.se>
	<20101219125508.GG3047@n2100.arm.linux.org.uk>
	<19726.4420.289089.490319@pilspetsen.it.uu.se>
	<20101219144950.GH3047@n2100.arm.linux.org.uk>
Message-ID: <19726.12173.600912.202134@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes:
 > >  >  Does trr need to be written in
 > >  > ->set_mode (if so that's another bug in this code)?
 > > 
 > > trr{0,1} need not and should not be changed after iop_time_init().
 > 
 > It sounds like trr0 needs to be written in ->set_mode's
 > CLOCK_EVT_MODE_PERIODIC path then, because with my patch, we never set
 > this register.

Hmm, yes, your patch does cause that. I think it's better to keep the
write_trr0() in iop_init_time(), but move it ahead of the
clockevents_register_device() call; this avoids a needless reinitialization
of trr0 in ->set_mode's CLOCK_EVT_MODE_PERIODIC case. Writing to trr0 is safe,
it's only the early write to tmr0 that's dangerous.

My kernel survived that bug because I have CONFIG_NO_HZ=y so the clockevents
timer is always(?) reprogrammed into oneshot-mode, which doesn't use trr0.

 >  Or will trr0 be updated when we write tcr0 ?
 
No, only explicit write_trr0() calls can update trr0.
