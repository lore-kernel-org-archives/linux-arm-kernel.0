From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 5 May 2014 15:28:26 +0200
Subject: [PATCH] ARM: fix v7-M signal return
In-Reply-To: <20140504153618.GA3795@debian>
References: <1398103664-23078-1-git-send-email-rabin@rab.in>
 <20140428082757.GD28564@pengutronix.de>
 <20140503173903.GA16300@debian>
 <20140503184512.GO28564@pengutronix.de>
 <20140504153618.GA3795@debian>
Message-ID: <20140505132826.GQ28564@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rabin,

On Sun, May 04, 2014 at 05:36:18PM +0200, Rabin Vincent wrote:
> On Sat, May 03, 2014 at 08:45:12PM +0200, Uwe Kleine-K?nig wrote:
> > On Sat, May 03, 2014 at 07:39:03PM +0200, Rabin Vincent wrote:
> > > I'm running this on QEMU.  Here is an old qemu-devel thread on this
> > > topic if you are interested:
> > > http://lists.gnu.org/archive/html/qemu-devel/2012-03/msg00158.html
> > I'm interested in your setup and (if applicable) additional kernel
> > patches.
> 
> No kernel patches are needed other than the ones I already posted.  My
> QEMU patches for EFM32 support are needed.  I put together a small
> README here: https://github.com/rabinv/qemu-efm32-tools
> 
> > > +	@ ensure bit 0 is cleared in the PC
> > Maybe add: , otherwise behaviour is unpredictable
> > 
> > > +	bic	r4, r4, #1
> > I just notice that the coding style is inconsitent here, the
> > instructions above don't repeat the dest register. Can you please make
> > this "bic r4, #1", too?
> > 
> > With these two changes you can have my ack.
> 
> v3 below.
> 
> > What happens on qemu without this fix? If it crashes I'd suggest to get
> > this patch into 3.15 with a stable annotation. If not I think 3.16-rc1
> > is enough.
> 
> User space processes crash because qemu's emulation of the CPU does not
> discard the zero bit.
> 
> 8<--------------------
> From 577b0c0e15057f58f86996da7f363c8a608c389f Mon Sep 17 00:00:00 2001
> From: Rabin Vincent <rabin@rab.in>
> Date: Sat, 3 May 2014 19:27:09 +0200
> Subject: [PATCHv3] ARM: fix v7-M signal return
> 
> According to the ARM ARM, the behaviour is UNDPREDICTABLE if the PC read
s/UNDPR/UNPR/

> from the exception return stack is not half word aligned.  See the
> pseudo code for ExceptionReturn() and PopStack().
> 
> The signal handler's address has the bit 0 set, and setup_return()
> directly writes this to regs->ARM_pc.  Mask out bit 0 before the
> exception return to get predictable behaviour.

Actual machines seem to behave just fine (i.e. discard this bit) but
qemu's emulation doesn't and makes processes crash.

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Fixes: 19c4d593f0b4 ("ARM: ARMv7-M: Add support for exception handling")
Cc: stable at kernel.org

----
Can you please put this in Russell's patch tracker.

Maybe pc in the saved struct regs should get bit 0 set during exception
entry for consistency?! (That would be a separate patch of course.)

Thanks
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
