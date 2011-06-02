From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Thu, 2 Jun 2011 17:46:39 +0100 (BST)
Subject: using identity_mapping_add & switching MMU state - how ?
In-Reply-To: <20110602162207.GB2156@arm.com>
References: <alpine.DEB.2.00.1106021621400.2311@localhost6.localdomain6>
	<20110602162207.GB2156@arm.com>
Message-ID: <alpine.DEB.2.00.1106021728140.2311@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Jun 2011, Dave Martin wrote:

> On Thu, Jun 02, 2011 at 04:44:02PM +0100, Frank Hofmann wrote:
>> Hi,
>>
>>
>> I'm trying to find a way to do an MMU off / on transition.
>>
>> What I want to do is to call cpu_do_resume() from the hibernation
>> restore codepath.
>>
>> I've succeeded to make this work by adding a test whether the MMU is
>> already on when cpu_resume_mmu() is called.
>>
>> I'm not sure that sort of thing is proper; hence I've been trying to
>> find a way to disable the MMU before calling cpu_do_resume().
>>
>> Can't seem to get this to work though; even though I'm creating a
>> separate MMU context that's given 1:1 mappings for all of kernel
>> code/data, execution still hangs as soon as I enable the code
>> section below that switches the MMU off.
>
> I think Per Fransson has been working on this area for kexec.
>
> Given the intrinsic scariness of code for turning MMUs off, I think
> it would be best if there's a single common implementation which is
> usable for hibernation and kexec, and any other code which needs
> to do this (CPU hotplug?)
>
> Maybe Per has some ideas on how to do that...
>
> Cheers
> ---Dave

Dave, Will,

thanks for the pointer.

I agree common code to do this sort of transition would be useful, both 
for kexec and hibernation.


The code for cpu_reset() on the _older_ ARM architectures does switch the 
MMU off, but said for v6/v7 isn't mainline (it's discussed in various 
patch submissions, by Per and others, related to kexec over the last 
year).

It seems not to be quite that simple as to add a cpu_reset() which zeroes 
CR_M in the control bits. I'm unsure as to what works and who made it work 
...

Ideally, I'd hope for being able to do the transition like this:

 	/* set up whatever 1:1 mappings are needed - which ones ?! */

 	flush_cache_all();
 	flush_tlb_all();

 	/* flush/disable whatever other caches ... */

 	cpu_proc_fin();				/* i/d cache off */

 	cpu_reset(__pa(target_function));	/* MMU off, jump physical */

which seems pretty much the usecase that machine_kexec() also does.

It just doesn't look like the code is reached.

The only real difference between the hibernation restore and the kexec 
path, seems to be that kexec "reuses" current->mm(->pgd) while hibernation 
restore uses init_mm and a throwaway pagedir; the latter means there's no 
need attempting to save/restore the pmd's overwritten by the identity 
mappings.


FrankH.
