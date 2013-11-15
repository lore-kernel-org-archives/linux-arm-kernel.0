From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 14 Nov 2013 17:35:11 -0800
Subject: [PATCH 6/6] ARM: kvm: TMP: Commit the hyp page tables to main
 memory
In-Reply-To: <52857691.8000907@ti.com>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-7-git-send-email-santosh.shilimkar@ti.com>
 <20131115001115.GC20516@lvm> <528567B0.1020308@ti.com>
 <20131115002739.GF20516@lvm> <52856C95.6000102@ti.com>
 <20131115004250.GH20516@lvm> <52857691.8000907@ti.com>
Message-ID: <20131115013511.GI20516@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 08:19:13PM -0500, Santosh Shilimkar wrote:
> On Thursday 14 November 2013 07:42 PM, Christoffer Dall wrote:
> > On Thu, Nov 14, 2013 at 07:36:37PM -0500, Santosh Shilimkar wrote:
> >> On Thursday 14 November 2013 07:27 PM, Christoffer Dall wrote:
> >>> On Thu, Nov 14, 2013 at 07:15:44PM -0500, Santosh Shilimkar wrote:
> >>>> On Thursday 14 November 2013 07:11 PM, Christoffer Dall wrote:
> >>>>> On Thu, Nov 14, 2013 at 02:37:46PM -0500, Santosh Shilimkar wrote:
> >>>>>> This is a temporary hack which I have to use to avoid a weired crash while
> >>>>>> starting the guest OS on Keystsone. They are random crashesh while the
> >>>>>> guest os userspace starts. Additional data point is, it seen only with first
> >>>>>> guest OS lanch. Subsequest guest OS starts normal.
> >>>>>>     
> >>>>>
> >>>>> what crashes?  The guest?  Where, how?
> >>>>>
> >>>> When guest userspace starts. The crashes are random but always after the
> >>>> guest init process have started.
> >>>>  
> >>>
> >>> So you get a guest kernel crash when guest userspace starts?
> >>>
> >>> Are the crashes completely random or is it always some pointer
> >>> dereference that goes wrong, is it init crashing and causing the kernel
> >>> to crash (from killed init), or is it always the same kernel thread, or
> >>> anything coherent at all?
> >>>
> >> Completely random. I have seen almost all of the above possible crashes
> >> like pointer derefence, init process skipping some steps, console going
> >> for toss, the log in prompt just won't let me log in etc
> >>
> >>  
> >>> It could be anything, really.  You could try a really brute force
> >>> debugging option of adding a complete cache flush at the end of
> >>> user_mem_abort in arch/arm/kvm/mmu.c to see if this is cache related at
> >>> all...
> >>>
> >> I will try that. I strongly suspect this has to do with bad page tables.
> >> remember I see this issue with when using memory which starts beyond 4GB.
> >>
> full cache full at end of user_mem_abort() doesn't help. So it might not be
> cache related then.
> 
> > 
> > But once it crashes, if you kill the VM process and start a new one,
> > then the new one runs flawlessly?  Did you stress test the second VM
> > (hackbench or something) so we're sure the second one is indeed stable?
> > 
> > What happens if you start a guest, kill it immediately, and then start
> > another guest?
> > 
> And the observation about subsequent VM's being stable also doesn't hold
> true. Additional symptom what I saw was segmentation fault as well as
> hitting kvm load/store trap. This also possibly indicates instructions
> corruption.
> 
Cool, so we only know it breaks when the physical address is >4GB.
Awesome.

It may be helpful to cherry-pick this commit:
https://git.linaro.org/gitweb?p=people/cdall/linux-kvm-arm.git;a=commitdiff;h=df6dc9f43f2a37547d4ce034706ef0cfc4235129

Then capture a full trace of the VM when executing until the guest
crashes and look at the trace to see if we're mapping and faulting on
the pages we think we are or if it looks like something is being
truncated.

Feel free to send me one of those logs and I'll be happy to take a look.

-Christoffer
