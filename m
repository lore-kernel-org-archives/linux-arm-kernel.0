From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Nov 2011 22:52:01 +0000
Subject: 2b034922 breaks kexec on ARM
In-Reply-To: <CALZhoSSyUAhriZU0wM3qQV5npN67d-Rvr=DgTyRTTtgiW94V4A@mail.gmail.com>
References: <20111107185125.GA17464@mudshark.cambridge.arm.com>
 <20111107190314.GS12913@n2100.arm.linux.org.uk>
 <20111107191453.GC17464@mudshark.cambridge.arm.com>
 <20111107192043.GT12913@n2100.arm.linux.org.uk>
 <CALZhoSRZu=fbsToqWQsxJBSQ6huwxtkR=M7iFZyJ576jeJ4FHw@mail.gmail.com>
 <20111107210317.GU12913@n2100.arm.linux.org.uk>
 <CALZhoSSyUAhriZU0wM3qQV5npN67d-Rvr=DgTyRTTtgiW94V4A@mail.gmail.com>
Message-ID: <20111107225201.GV12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 05:15:13AM +0800, Lei Wen wrote:
> Hi Russel,
> 
> On Tue, Nov 8, 2011 at 5:03 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Nov 08, 2011 at 04:55:43AM +0800, Lei Wen wrote:
> >> On Tue, Nov 8, 2011 at 3:20 AM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Mon, Nov 07, 2011 at 07:14:53PM +0000, Will Deacon wrote:
> >> >> On Mon, Nov 07, 2011 at 07:03:15PM +0000, Russell King - ARM Linux wrote:
> >> >> > Hmm, having looked at kernel/kexec.c, this patch is clearly wrong.
> >> >> > There are two kernels which can be loaded into kexec - a crash kernel
> >> >> > and a default kernel. ?These are kept entirely separately (and the
> >> >> > per-kernel context is stored in 'image').
> >> >> >
> >> >> > However, this patch makes machine_kexec_prepare() store into some
> >> >> > _global_ variables, which means if you've loaded a crash kernel
> >> >> > followed by a default kernel, the values for the crash kernel will
> >> >> > be corrupted.
> >> >> >
> >> >> > So yes, I think a revert of this patch is the right thing.
> >> >>
> >> >> Great. Would you like me to submit the revert to the patch system or are you
> >> >> happy just to do it using git?
> >> >
> >> > I've reverted it myself (see the tip of the fixes branch). ?It's slightly
> >> > annoying that the branch was only pulled last night.
> >> >
> >> >> > I think the only valid thing its doing is moving the copy of the
> >> >> > reboot code earlier, but I don't see the value of moving just that.
> >> >>
> >> >> Neither can I. It seems to be happy enough with the patch reverted, so if it
> >> >> ain't broke...
> >> >
> >> > I guess this is where the problems of poor commit descriptions crop up.
> >> > We don't know _why_ the original author of the patch wanted to make the
> >> > change - we don't know if they were seeing a problem.
> >> >
> >>
> >> Apologize for messing things up...
> >> But we have make in-depth testing over that patch already in our local
> >> code base...
> >> Does this problem happens for the kernel is running on a SMP soc? Our current
> >> testing haven't extend to SMP one, but only have test on non-smp.
> >
> > It doesn't matter - as I've pointed out, the change is _fundamentally_
> > wrong because you're storing state in global variables which refers to
> > one of two possible images which may be loaded.
> 
> I still cannot get understand your point there... Why image->start would refer
> to the default kernel? You means kexec load two kernel at the same time?

I've now stated the problem twice.  Let me re-state it again:

You are storing state in global variables which refers to one of two
possible images which may be loaded.

Take a moment to _think_ about what effect this sequence of events has:

1. loading a crash kernel has with image->type = KEXEC_TYPE_CRASH.
   This calls machine_kexec_prepare() for this kernel, which with your
   patch ends up writing to these variables:
	kexec_start_address
	kexec_indirection_page
	kexec_mach_type
	kexec_boot_atags

   this will be loaded and retained in memory.

2. loading a normal kexec image.
   Again, this calls machine_kexec_prepare() for this kernel, which with
   your patch ends up writing to these variables:
	kexec_start_address
	kexec_indirection_page
	kexec_mach_type
	kexec_boot_atags

3. you experience a crash at this point, and the kernel which is attempted
   to be booted is the one with image->type = KEXEC_TYPE_CRASH.  However,
	kexec_start_address
	kexec_indirection_page
	kexec_mach_type
	kexec_boot_atags
   are all set for the normal image, not the kexec image.

See - storing this state in global variables does _NOT_ work if it has to
persist to the point where the kexec actually happens.

> The original intension for this posting is for we want to have a chance to
> launch the crash kernel, even when default kernel is hanging, which
> means it has no chance to trigger the panic path that lead to load the
> crash kernel.

Right.  That's a better explanation.

It doesn't get us away from the fact that the patch is _technically_
wrong though for the point I make above.  Those variables must stay
inside machine_kexec() so they are correctly initialized for the
kernel being booted.
