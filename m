From: frank.hofmann@tomtom.com (Frank Hofmann)
Date: Fri, 3 Jun 2011 16:56:32 +0100 (BST)
Subject: using identity_mapping_add & switching MMU state - how ?
In-Reply-To: <alpine.DEB.2.00.1106030834240.2311@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106021621400.2311@localhost6.localdomain6>
	<20110602201611.GA10532@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106030834240.2311@localhost6.localdomain6>
Message-ID: <alpine.DEB.2.00.1106031626590.2311@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, hi all,


thanks for the help and suggestions; I've managed to get the V->P->V 
transition to work, so the next thing to do for the hibernation code is to 
fix it up in such a way that it directly calls cpu_suspend/cpu_resume.

Job for next week.


What I've found that caused a problem was the use of a "mint" pagedir. 
I've been using this:

 	/* pre-resume */
 	pgd_t __swsusp_pg_dir = pgd_alloc(&init_mm);


 	cpu_switch_mm(__swsusp_pg_dir, &init_mm);

 	... [ restore copy loop ] ...

 	identity_mapping_add(__swsusp_pg_dir, __pa(_stext), __pa(_etext));
 	identity_mapping_add(__swsusp_pg_dir, __pa(_sdata), __pa(_edata));
 	cpu_switch_mm(__swsusp_pg_dir, &init_mm);

 	cpu_proc_fin();
 	flush_tlb_all();
 	flush_cache_all();

 	cpu_reset(__pa(__builtin_return_address(0)));

to return to the 1:1-mapped resume function.

But that would hang; I believe it's simply fallen foul of the kernel heap 
overwrite done by the copy loop.


I've noticed it works just fine if using the initial tables.

 	cpu_switch_mm(swapper_pg_dir, &init_mm);

and setting the identity mappings within swapper_pg_dir.


I'd prefer to get away from "abusing" swapper_pg_dir for this; I don't 
think it should have these identity mappings in (and right now I'm not 
attempting to take them out again). But I don't yet have a good idea where 
else to take a usable pagedir from.


Anyway ... a great weekend to everyone !
FrankH.
