From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Jun 2011 21:16:11 +0100
Subject: using identity_mapping_add & switching MMU state - how ?
In-Reply-To: <alpine.DEB.2.00.1106021621400.2311@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106021621400.2311@localhost6.localdomain6>
Message-ID: <20110602201611.GA10532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2011 at 04:44:02PM +0100, Frank Hofmann wrote:
> I'm trying to find a way to do an MMU off / on transition.
>
> What I want to do is to call cpu_do_resume() from the hibernation restore 
> codepath.
>
> I've succeeded to make this work by adding a test whether the MMU is  
> already on when cpu_resume_mmu() is called.

I think you're making things more complicated than they need to be.

> I'm not sure that sort of thing is proper; hence I've been trying to find 
> a way to disable the MMU before calling cpu_do_resume().

Well, I don't really condone using cpu_do_resume() outside of its
original context of arch/arm/kernel/sleep.S - the two were written
to work together, and the processor specific bit is not really
designed to be used separately.

> Can't seem to get this to work though; even though I'm creating a 
> separate MMU context that's given 1:1 mappings for all of kernel 
> code/data, execution still hangs as soon as I enable the code section 
> below that switches the MMU off.

I'm not surprised - cpu_do_resume() has some special entry requirements
which are not obvious by way of the rest of the code in
arch/arm/kernel/sleep.S.  As I say, cpu_do_resume is not designed to be
used by other code other than what's in that file.

But... it requires the v:p offset in r1, and the _virtual_ address of
the code to continue at in lr.  These are specifically saved for it by
cpu_suspend in arch/arm/kernel/sleep.S.
