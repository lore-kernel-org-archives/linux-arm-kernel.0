From: dustinb@codeaurora.org (Dustin Brown)
Date: Wed, 14 Jun 2017 09:51:22 -0700
Subject: [PATCH 2/2] arm64: Export save_stack_trace_tsk()
In-Reply-To: <20170614100636.GA16190@arm.com>
References: <20170613085029.GA5374@arm.com>
 <20170613173308.6653-1-dustinb@codeaurora.org>
 <20170613173308.6653-2-dustinb@codeaurora.org>
 <20170613174406.GH9184@arm.com> <20170613181603.GE4902@n2100.armlinux.org.uk>
 <20170614100636.GA16190@arm.com>
Message-ID: <000101d2e52e$743d0ca0$5cb725e0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

I sent out updated patches yesterday with better descriptions, but I am not
sure I got the threads associated correctly.

We have a dynamically loaded kernel driver with a worker thread which
processes a queue. From time to time, defects get introduced that cause this
thread to hang for long periods of time, or deadlock. To catch these
quickly, we introduced a watchdog timer that does a bug-on when individual
work items take longer than some threshold. This works great when the worker
thread is on the CPU at the point of timeout, but in cases where it went to
sleep on a mutex or a kmalloc, we want to dump the worker thread's stack
trace specifically.

This is code that is expected to live for years, and is not a one-off
debugging instance.

Thanks,

-Dustin

-----Original Message-----
From: Will Deacon [mailto:will.deacon at arm.com] 
Sent: Wednesday, June 14, 2017 3:07 AM
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Dustin Brown <dustinb@codeaurora.org>; catalin.marinas at arm.com;
linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: Export save_stack_trace_tsk()

On Tue, Jun 13, 2017 at 07:16:03PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 13, 2017 at 06:44:06PM +0100, Will Deacon wrote:
> > On Tue, Jun 13, 2017 at 10:33:08AM -0700, Dustin Brown wrote:
> > > To aid in debugging driver modules, export save_stack_trace_tsk() 
> > > for the ARM64 architecture.
> > > ---
> > >  arch/arm64/kernel/stacktrace.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > Please can you repost with your Signed-off-by line added to the 
> > patch? I can't merge anything from you without that.
> 
> I think it would also be a good thing to have a little more 
> information about how this is being used in driver modules.

That would certainly help to motivate the change; I was just going by the
fact that most other architectures export this symbol and therefore it is
assumedly useful to somebody.

> If it's for ad-hoc debugging, then I see no reason for it to be merged 
> into mainline kernels just for the utility of people adding code to 
> drivers to perform that debug - they might as well temporarily add the 
> export at the same time IMHO.

A quick look at the Debian archive suggests that it's used by "systemtap"
(although this seems to be part of an autoconf helper) and "kpatch".

Dustin -- do you have another use-case behind this?

Will
