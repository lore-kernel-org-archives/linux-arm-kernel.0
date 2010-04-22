From: Dave.Martin@arm.com (Dave P. Martin)
Date: Thu, 22 Apr 2010 14:18:08 +0100
Subject: kernel virtual memory access (from app) does not generatesegfault
In-Reply-To: <20100422122901.GA5126@desktop>
References: <20100420192813.GA29831@n2100.arm.linux.org.uk>
	<20100420223106.GQ11723@shareable.org>
	<20100420224108.GA1432@n2100.arm.linux.org.uk>
	<000001cae144$4281a9a0$4044010a@Emea.Arm.com>
	<20100421193534.GC26616@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1004211723230.7232@xanadu.home>
	<20100421214447.GK26616@n2100.arm.linux.org.uk>
	<20100421215425.GL26616@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1004211848151.7232@xanadu.home>
	<000001cae20a$6ab7c820$4044010a@Emea.Arm.com>
	<20100422122901.GA5126@desktop>
Message-ID: <000101cae21e$403e4740$4044010a@Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

> -----Original Message-----
> From: anfei [mailto:anfei.zhou at gmail.com] 
> Sent: 22 April 2010 13:29
> To: Dave P Martin
> Cc: 'Nicolas Pitre'; Russell King - ARM Linux; 
> linux-arm-kernel at lists.infradead.org; Jamie Lokier; Ben Dooks
> Subject: Re: kernel virtual memory access (from app) does not 
> generatesegfault
> 
> On Thu, Apr 22, 2010 at 11:56:09AM +0100, Dave P. Martin wrote:
> > Hi there,
> > 
> > > -----Original Message-----
> > > From: Nicolas Pitre [mailto:nico at fluxnic.net]
> > > Sent: 21 April 2010 23:59
> > > To: Russell King - ARM Linux
> > > Cc: linux-arm-kernel at lists.infradead.org; anfei; Jamie 
> Lokier; Dave 
> > > P Martin; Ben Dooks
> > > Subject: Re: kernel virtual memory access (from app) does not 
> > > generatesegfault
> > > 
> > > On Wed, 21 Apr 2010, Russell King - ARM Linux wrote:
> > > 
> > > > On Wed, Apr 21, 2010 at 10:44:47PM +0100, Russell King -
> > > ARM Linux wrote:
> > > > > On Wed, Apr 21, 2010 at 05:24:51PM -0400, Nicolas Pitre wrote:
> > > > > > On Wed, 21 Apr 2010, Russell King - ARM Linux wrote:
> > > > > > 
> > > > > > > On Wed, Apr 21, 2010 at 12:17:41PM +0100, Dave P. 
> > > Martin wrote:
> > > > > > > >  
> > > > > > > > 
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Russell King - ARM Linux 
> > > > > > > > > [mailto:linux at arm.linux.org.uk]
> > > > > > > > > Sent: 20 April 2010 23:41
> > > > > > > > > To: Jamie Lokier
> > > > > > > > > Cc: Ben Dooks; anfei; Dave P Martin; 
> > > > > > > > > linux-arm-kernel at lists.infradead.org
> > > > > > > > > Subject: Re: kernel virtual memory access (from app) 
> > > > > > > > > does not generatesegfault
> > > > > > > > 
> > > > > > > > [...]
> > > > > > > > 
> > > > > > > > > The difference between instruction faults and
> > > data faults is
> > > > > > > > > that we always interpret instruction faults 
> on pre-ARMv6 
> > > > > > > > > CPUs as a 'translation fault' rather than a
> > > permission fault
> > > > > > > > > since they can't tell us what the problem was.
> > > > > > > > 
> > > > > > > > Note that my observations were on an armv7 kernel.  
> > > Should we
> > > > > > > > still hit the same bit of code in this case, or
> > > have I misdiagnosed the problem?
> > > > > > > 
> > > > > > > If it was ARMv7, we should be reading the IFSR, which
> > > should be
> > > > > > > telling us that there's a permission fault trying to read 
> > > > > > > instructions from 0xc0000000.
> > > > > > > 
> > > > > > > If changing do_translation_fault() on a recent kernel
> > > fixes your
> > > > > > > problem, something's going wrong.  Any chance you
> > > could add some
> > > > > > > debugging to
> > > > > > > do_PrefetchAbort() so that when you see your test program 
> > > > > > > running (eg, if (strcmp(current->comm, "progname") ==
> > > 0) { ... 
> > > > > > > }) you could dump out the values of ifsr and addr please?
> > > > > > 
> > > > > > If I remember right, the original bug report 
> mentioned ARM926.
> > > > > 
> > > > > So here we go again with confusion raining.
> > > > > 
> > > > > Someone please tell me _definitively_ _what_ is being
> > > seen on _what_
> > > > > CPU, and separate the two issues into two different threads.  
> > > > > I'm going to ignore any further comments on this issue until 
> > > > > that's done.  Life is too short to try to work this 
> out on my own.
> > > > 
> > > > Actually, no, you're creating the confusion; this
> > > sub-thread is about
> > > > the behaviour on ARMv7, as a completely separate subject
> > > from ARM926.
> > > 
> > > It is well possible that I missed the subject transition.
> > > 
> > > The only person who provided a test program is Sasha Sirotkin who 
> > > said:
> > > 
> > > On Tue, 20 Apr 2010, Sasha Sirotkin wrote:
> > > 
> > > > P.S. My kernel is 2.6.32.7 and the CPU is ARM926EJ-S rev 5 (v5l)
> > > 
> > > Message-id: <4BCD7076.9030802@browserseal.com>
> > > 
> > > Only later did Dave P. Martin mention having made similar 
> > > observations on an ARMv7.
> > 
> > To clarify:
> > 
> > 	* I haven't tested this on 926 myself
> > 	* On armv7, I have observed the problem only on *old* kernels 
> > (<2.6.32; which lack any of the patches under discussion)
> > 	* Using 2.6.34-rc1 (from rmk's versatile branch) on 
> armv7, I get the 
> > expected SEGV when userspace tries to execute >= TASK_SIZE
> > 
> > so...
> > 	* Sasha's problem is caused by a problem in the current 
> kernel on 
> > 926.
> > 	* My problem relates to v7 and has already been fixed 
> (but isn't 
> > fixed in the Ubuntu kernels yet)
> > 
> > The test case was
> > 
> > int main(void)
> > {
> > 	((void (*)(void))0xc0000000)();
> > 	return 0;
> > }
> > 
> I did a test on arm926 using QEMU with the latest kernel 
> (just pull from git.kernel.org).  Without checking user_mode, 
> this test case will continue to trigger do_translation_fault 
> with address 0xc0000000, so I think that two-liner patch is 
> necessary.  With it, the case will get SIGSEGV, and the 
> system seems running well.
> 
> Regards,
> Anfei.

That matches my understanding--- it sounds like the two-liner is relevant
for all pre-v6 platforms (including ARM926), so it probably makes sense to
merge it.

---Dave
