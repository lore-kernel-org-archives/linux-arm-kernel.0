From: Ulrich.Weigand@de.ibm.com (Ulrich Weigand)
Date: Fri, 2 Sep 2011 19:40:34 +0200
Subject: try_to_freeze() called with IRQs disabled on ARM
In-Reply-To: <20110902172259.GA6619@n2100.arm.linux.org.uk>
References: <20110823220056.GK3895@n2100.arm.linux.org.uk>
	<20110825130907.GO3286@htj.dyndns.org>
	<20110825145558.GF8883@n2100.arm.linux.org.uk>
	<201108261644.26329.arnd@arndb.de>
	<OF2C5ADB6A.65B1BE36-ONC12578FE.00493A67-C12578FE.004B3315@de.ibm.com>
	<20110901140000.GF29729@n2100.arm.linux.org.uk>
	<OF69A57AB0.CF22689A-ONC12578FF.004EDD71-C12578FF.005142FF@de.ibm.com>
	<20110902172259.GA6619@n2100.arm.linux.org.uk>
Message-ID: <OFA88E54BC.55310B1A-ONC12578FF.00607E64-C12578FF.00611957@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> wrote on 09/02/2011
07:22:59 PM:
> On Fri, Sep 02, 2011 at 04:47:35PM +0200, Ulrich Weigand wrote:
> > Assume the scenario you initally describe, where a first signal is
> > ignored and leads to system call restart.  With your latest patch,
> > you call into syscall_restart which sets everything up to restart
> > the call (with interrupts disabled).
>
> I don't think SIG_IGN signals even set the TIF work flag, so they
> never even cause a call into do_signal().  Therefore, as far as
> syscalls go, attempting to send a process (eg) a SIGINT which its
> handler is set to SIG_IGN results in the process not even being
> notified about the attempt - we won't even wake up while the
> syscall is sleeping.

I don't see why SIG_IGN signals shouldn't set the TIF work flag;
the decision whether to ignore a signal is only made once we've
got to get_signal_to_deliver.  In any case, whether or not the
signal is SIG_IGN doesn't matter for the example at all; I'm
simply talking about the case whether the first signal we get
leads to system call restart, exactly the same as in the original
example you initially described here:
http://lists.arm.linux.org.uk/lurker/message/20110823.154329.a3e65f95.en.html

> > To really fix this case would probably require some way for the
> > debugger to save and restore the restore_block saved state.  This
> > is not quite trivial, since it would expose that state to user space,
> > effectively creating a new ABI (and probably requiring sanity checks
> > to ensure a valid state is restored).  This probably cannot be fixed
> > by one architecture for itself, but would need support from common
> > kernel code.
>
> Such state would have to be crytographically signed or kept entirely
> within the kernel, as it would otherwise mean that you could redirect
> the kernel PC to anywhere...

Agreed, that's why the state would need to be verified (in the case of
the function pointer, we probably would not want to export the kernel
code address to user space in any case, but identify which of the
possible target functions is to be called in some other manner).

Bye,
Ulrich
