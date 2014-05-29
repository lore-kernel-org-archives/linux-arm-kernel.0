From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 29 May 2014 10:08:07 -0700
Subject: [PATCH v6 4/4] add 2nd stage page fault handling during live
 migration
In-Reply-To: <20140529085134.GB61607@lvm>
References: <1400178451-4984-1-git-send-email-m.smarduch@samsung.com>
 <1400178451-4984-5-git-send-email-m.smarduch@samsung.com>
 <20140527201945.GD16428@lvm> <53853C2F.8080003@samsung.com>
 <20140528080957.GH16428@lvm> <5386232A.3050602@samsung.com>
 <20140529085134.GB61607@lvm>
Message-ID: <53876977.1040502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> So this needs to be cleared up given this is key to logging.
>> Cases this code handles during migration -
>> 1. huge page fault described above - write protect fault so you breakup
>>    the huge page.
>> 2. All other faults - first time access, pte write protect you again wind up in
>>    stage2_set_pte().
>>
>> Am I missing something here?
>>
> 
> no, I forgot about the fact that we can take the permission fault now.
> Hmm, ok, so either we need to use the original approach of always
> splitting up huge pages or we need to just follow the regular huge page
> path here and just mark all 512 4K pages dirty in the log, or handle it
> in stage2_set_pte().
> 
> I would say go with the most simple appraoch for now (which may be going
> back to splitting all pmd_huge() into regular pte's), and we can take a
> more careful look in the next patch iteration.
> 

Looking at the overall memslot update architecture and various
fail scenarios - user_mem_abort() appears to be the most
optimal and reliable place. First Write Protect huge pages after
memslots are committed and deal with rest in user_mem_abort().

Still need some feedback on the pud_huge() before revising for
next iteration?

- Mario
