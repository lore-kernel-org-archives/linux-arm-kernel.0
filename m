From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Fri, 3 Jun 2011 11:44:02 +0100 (BST)
Subject: using identity_mapping_add & switching MMU state - how ?
In-Reply-To: <20110602201611.GA10532@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1106021621400.2311@localhost6.localdomain6>
	<20110602201611.GA10532@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1106030834240.2311@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Jun 2011, Russell King - ARM Linux wrote:

> On Thu, Jun 02, 2011 at 04:44:02PM +0100, Frank Hofmann wrote:
>> I'm trying to find a way to do an MMU off / on transition.
>>
>> What I want to do is to call cpu_do_resume() from the hibernation restore
>> codepath.
>>
>> I've succeeded to make this work by adding a test whether the MMU is
>> already on when cpu_resume_mmu() is called.
>
> I think you're making things more complicated than they need to be.

I agree - should've been more precise; what I want as final code for the 
hibernation paths is to _use_ cpu_suspend/cpu_resume directly. See below.

>
>> I'm not sure that sort of thing is proper; hence I've been trying to find
>> a way to disable the MMU before calling cpu_do_resume().
>
> Well, I don't really condone using cpu_do_resume() outside of its
> original context of arch/arm/kernel/sleep.S - the two were written
> to work together, and the processor specific bit is not really
> designed to be used separately.

With that I agree ...

But that is also exactly what I'm attempting to do - I don't want to 
leapfrog anything in sleep.S, but ideally _use_ the code directly ... i.e. 
call both cpu_suspend and cpu_resume from the hibernation suspend/resume 
codepaths.

There's two issues currently blocking this:

a) hibernation and suspend-to-ram cannot share the register save area,
    because suspend-to-ram could be invoked while writing the snapshot.

    (the global sleep_save_sp is the issue there - the hibernation code
    must do some sort of fixup to get that out of the way)

That's the reason why _at the moment_ the hibernation codepath is calling 
cpu_do_suspend directly instead of cpu_suspend; mere laziness on my side 
not yet having bothered to either change cpu_suspend or call it unmodified 
via sp fixup and extract the reg buffer / phys addr afterwards.

The current behaviour, i.e. the direct invocation of cpu_do_suspend/resume 
is not supposed to stay that way.

But the rather significant problem is the second issue:

b) cpu_resume must be called with MMU off - and doing that isn't working
    for me at the moment.

Please don't get me wrong - I'm all with you on the _interface_ being 
cpu_suspend / cpu_resume and agree that's what it should be.


To make it clear: Once I can do b) above, a) is trivial, just a small 
restructuring of the code. Even using cpu_suspend as-is, unmodified, would 
be possible by just temporarily fixing up sp before invoking it.

The problem is b) - no way I've attempted of switching the MMU off so far 
has ended in a recoverable situation.

>
>> Can't seem to get this to work though; even though I'm creating a
>> separate MMU context that's given 1:1 mappings for all of kernel
>> code/data, execution still hangs as soon as I enable the code section
>> below that switches the MMU off.
>
> I'm not surprised - cpu_do_resume() has some special entry requirements
> which are not obvious by way of the rest of the code in
> arch/arm/kernel/sleep.S.  As I say, cpu_do_resume is not designed to be
> used by other code other than what's in that file.
>
> But... it requires the v:p offset in r1, and the _virtual_ address of
> the code to continue at in lr.  These are specifically saved for it by
> cpu_suspend in arch/arm/kernel/sleep.S.

I've read that - that's why the hibernation resume path has been written 
this way. I'm trying to create the conditions necessary, i.e. set up 
r0/r1/lr _and_ the MMU state in such a way that it's callable unmodified.

Thing is, as said, calling it as such works - as long as I make 
cpu_resume_mmu (!) bypass MMU enabling if the MMU is on already.
Of course, all that proves is that I've got r0 (virtual) and lr (virtual) 
right, as only the MMU enabler code actually uses the v:p offset.



But this is disgressing a little from the problem at hand, sorry.

The function being called is rather irrelevant for the problem I'm 
attempting to address ... it's the MMU off transition that doesn't seem to 
do the thing.

Even 'blinking' CR_M causes a hang for me; i.e. code like:

 		identity_mapping_add(pgd, __pa(_stext), __pa(_etext));
 		...
 		cpu_proc_fin();		/* caches off */
 		flush_tlb_all();
 		flush_cache_all();
 		/* isb(), dsb() make no difference ... */
 	}

and then returning to:

 	mrc	p15, 0, r0, c0, c1, 0   @ read CR
 	bic	r0, #CR_M
 	mcr	p15, 0, r0, c0, c1, 0   @ off ...
 	orr	r0, #CR_M
 	mcr	p15, 0, r0, c0, c1, 0   @ on ...
 	... 				@ hoping it'll just continue here

doesn't work, it ends up at cloud kuckoo country.


FrankH.
