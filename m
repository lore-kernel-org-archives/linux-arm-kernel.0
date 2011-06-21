From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Jun 2011 15:35:58 +0100
Subject: [RFC PATCH v5] ARM hibernation / suspend-to-disk (fwd)
In-Reply-To: <alpine.DEB.2.00.1106201251340.11405@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106131303290.25153@localhost6.localdomain6>
	<20110613122601.GC12325@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106131400090.25153@localhost6.localdomain6>
	<20110613164452.GE13643@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106151349520.11405@localhost6.localdomain6>
	<20110616213128.GC32629@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106201251340.11405@localhost6.localdomain6>
Message-ID: <20110621143558.GG23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 01:32:47PM +0100, Frank Hofmann wrote:
> I've only tested on s3c64xx (for s2ram and s2disk) and omap3 (s2disk only 
> due to the omap code not having been "genericized" yet), the changes are  
> ok there.
> The remainder apply and compile ok.
>
> If that's sufficient, then:
> Acked-by: Frank Hofmann <frank.hofmann@tomtom.com>

I've added that to the core stuff and s3c64xx.

> You're right there's some risk that the ability to return an error here 
> is misinterpreted as an invitation to use error returns for indicating 
> state machine conditions.

Well, an error return undoes (and probably corrupts) the state which
cpu_suspend saved, so it wouldn't be useful for state machine stuff -
I wonder whether we should poison the saved pointers just to reinforce
this point.

> What I'm wondering about is the usecase for having an error return  
> opportunity in this case (beyond reporting it as such). Isn't it rather 
> so that most finishers would succeed and at best do a "BUG_ON()" at 
> failure, because system state then isn't such to make it trivially 
> recoverable ?

For s2ram, there's no reason at this point to fail.  The only thing left
to do at this point is to do whatever is required to cause the system to
enter the low power mode.

In the case where you need to place the SDRAM into self refresh mode
manually, the timing of stuff after self refresh mode has been entered
to the point where power is cut to the CPU is normally well defined,
and if for whatever reason power doesn't get cut, there's very little
which can be done to re-awake the system (you'd have to ensure that
the code to do that was already in the I-cache and whatever data was
required was already in registers.)

And as I mentioned, if you timeout waiting for the system to power off,
and you've done everything you should have done, are you sure that the
system won't power off on you unexpectedly if you return with an error,
which would then mean you have corrupted state saved (and possibly
corrupted filesystems.)

So, I don't think S2RAM would have any practical use for an error return
path.  It's more for hibernation.

> For hibernation, the ability to force the entire down/up transition 
> before writing the snapshot image out is actually very beneficial, for  
> reliability - one knows that the device/cpu side of suspend/resume has  
> already worked when the snapshot is being written, without having to wait 
> for reboot/image load/resume to test that.

It's not a test of the suspend/resume path though - device state is very
different between suspending in some way followed by an immediate resume
without resetting, and a real suspend, power off, resume cycle.

The former doesn't really test the resume paths - a register which has
been forgotten won't be found by any other way than cutting the power,
and you'll only ever find that on a proper resume-from-power-off.

> I'm not opposed to this addition as such, but I'm curious:
> * If an error occurs, how can the caller of cpu_suspend recover from it ?

If an error occurs from cpu_suspend(), then the caller needs to undo any
modification to state which it did while saving, and return an error.

> * What's the state the system is in after an error in this codepath ?

We can arrange for another callback into CPU specific code to sort out
anything they've done - iow, an error return from cpu_suspend should
ensure that we have the same state present as we had at the point it
was called.  We currently do not need that as cpu_suspend() just saves
state without modifying anything, but if we ended up with a CPU which
required stuff to be modified, we'd have to undo those modifications
before returning an error.

> * What subsystems / users would do anything else with it than BUG_ON() ?

The error code from the platform_suspend_ops ->enter method is already
dealt with - by going through the resume steps before returning the
error code.  Whether hibernate has similar functionality I don't know.

What I do think is that if hibernate needs to return an error code, we'd
better do that without doing things like taking the MMU down to run the
resume paths in order to do that.  If we have some error to propagate,
we want to propagate it back as easily as possible.
