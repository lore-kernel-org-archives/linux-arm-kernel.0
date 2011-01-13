From: andreiw@motorola.com (Andrei Warkentin)
Date: Thu, 13 Jan 2011 04:19:40 -0600
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
In-Reply-To: <20101224173824.GI20587@n2100.arm.linux.org.uk>
References: <20101216232849.GY9937@n2100.arm.linux.org.uk>
	<AANLkTimxY0ufwR-nUT_Hx=NkG=9vcuGFrKOBgYpGtvoi@mail.gmail.com>
	<20101217231449.GF9937@n2100.arm.linux.org.uk>
	<AANLkTi=-foyb9c5F4tFpGK6KzQnP9htJW8GwYoUHVK0r@mail.gmail.com>
	<20101218000828.GG9937@n2100.arm.linux.org.uk>
	<AANLkTinSg+iCGM64iQqLn32Wjpta_87=HWuG==KJ9-eW@mail.gmail.com>
	<20101218120154.GA4803@n2100.arm.linux.org.uk>
	<AANLkTimG8yuCMOJPz9-ANi_2hf7E2HPYPy9sWaxVPXmE@mail.gmail.com>
	<20101218200443.GM9937@n2100.arm.linux.org.uk>
	<AANLkTikHGX6OQWfGoNiQj-UX81=8_HwP3W+DXwZASatN@mail.gmail.com>
	<20101224173824.GI20587@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimLcGEDrexVCyMROYA1x_GsXdpx_6_ziYWVipMp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 24, 2010 at 11:38 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> On Tue, Dec 21, 2010 at 03:53:46PM -0600, Andrei Warkentin wrote:
> > Russel,
>
> Grr.
>
> > Thank you! The culprit looks as it seems to be the writel without
> > __iowmb, as you pointed out. At the very least I've yet to hit the
> > problem again this way.
>
> Good news.
>
> > I still want to add code inside the platform SMP support as a safety
> > net. Maybe I am being too pedantic, but ?In the near future (with
> > those 40 patches), secondaries are going to boot directly via
> > secondary_startup as well, so the first time platform-specific code
> > gets invoked is platform_secondary_init. I want to ensure that when
> > boot_secondary returns, the CPU is either guaranteed to be running or
> > for-sure dead. The problem is that platform_secondary_init is already
> > too late - if the CPU gets killed due to timeout anytime between the
> > entry to secondary_start_kernel and ?platform_secondary_init, it could
> > have already increased the refcount on init_mm or disabled preemption.
>
> Here's a problem for you to ponder on over Christmas.
>
> Let's say the secondary CPU is running slowly due to system load. ?It
> makes it through to secondary_start_kernel(), and calls through to
> your preinit function. ?It checks that it should be booting, and
> passes that test.
>
> At this point, the requesting CPU times out, but gets preempted to
> other tasks (which could very well happen on a heavily loaded system
> with preempt enabled).
>
> The booting CPU signals that via writing the reset vector, and continues
> on to increment the mm_count and switch its page tables.

My goal was for the preinit to run explicitely before the mm_count is
incremented. The cpu
sits (spins) inside the preinit until it is either told to continue
with the init (thus the synchronized CPU knows it succeeded), or it
sits there spinning inside the preinit until it gets killed due to a
timeout. Since I think the "side effects" only start after the
mm_count is incremented, I thought right before would be a good place.

>
> The requesting CPU finally switches back to the thread requesting
> that the CPU be brought up. ?It decides as it timed out to kill the
> booting CPU, and does so.

I should have made this clearer in my email when I said 'synchronize',
but if the timeout ever occurs it means two things -
1) CPU is dead or someplace before secondary_start_kernel
2) CPU is about to enter/entering preinit
3) CPU is already spinning inside preinit waiting to be allowed to
continue. It hasn't incremented mm_count, switched pts, or done
anything else that affects global kernel state.

In either case, it can be torn down (by say, fiddling with the power/reset).

If the timeout doesn't occur, then the requesting cpu will allow the
secondary to quit spinning inside the preinit.

>
> What this means that we now have exactly the same scenario you've
> referred to above, and adding the pre-init function hasn't really
> solved anything.
>
> I _really_ don't want platforms to start playing these games, because
> we'll end up with lots of different attempts to solve the problem,
> each of them probably racy like the above. ?The safest solution is to
> use a longer timeout - maybe an excessively long timeout - to guarantee
> that we never miss a starting CPU.
>
> If we do end up needing something like this in the kernel, then it needs
> to be done carefully and in generic code where it can be done properly
> once. ?(If any bugs are found in it, we've also only one version to fix,
> not five or six different versions.)

I fully agree. Would you be interested in me bringing back the actual
synchronization code from platform-dependent code into the preinit
function and posting that as a patch for review?

?However, I'd argue that it's better
> to wait longer for the CPU to come up if there's a possibility that it
> will rather than trying to sort out the mess from a partially booted
> secondary CPU.

Fair enough, I suppose that does make any platform bugs in smp path
more immediately obvious :)
