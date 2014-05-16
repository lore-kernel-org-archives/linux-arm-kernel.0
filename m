From: m.smarduch@samsung.com (Mario Smarduch)
Date: Fri, 16 May 2014 14:39:16 -0700
Subject: [PATCH v5 2/4] live migration support for initial write protect of
 VM
In-Reply-To: <537544D8.2030005@samsung.com>
References: <1399509616-4632-1-git-send-email-m.smarduch@samsung.com>
 <1399509616-4632-3-git-send-email-m.smarduch@samsung.com>
 <20140515185312.GA6159@lvm> <537544D8.2030005@samsung.com>
Message-ID: <53768584.4060705@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,
  few more comments
>>>  	struct vgic_dist	vgic;
>>> +	/* Marks start of migration, used to handle 2nd stage page faults
>>> +	 * during migration, prevent installing huge pages and split huge pages
>>> +	 * to small pages.
>>> +	 */
>>
>> commenting style
>>
>> this is a bit verbose for a field in a struct, perhaps moving the longer
>> version to where you set this?
> Will do.
>>
>>> +	int migration_in_progress;
>>>  };

I think this flag could be removed all together. Migration can be
stopped at any time (started too), through user request or other events. 
When that happens (like migrate_cancel) migrate cleanup bh runs and eventually calls 
KVM memory listener kvm_log_global_start() (cancel handler) 
that stops logging, clears KVM_MEM_LOG_DIRTY_PAGES, and region ops ioctl,
clears dirty_bitmap. In either case dirty_bitmap for memslot is set or 
unset during migration to track dirty pages, following that field seems to be 
a better way to keep track of migration. This again is QEMU view but it appears 
all these policies are driven from user space.



>>>  
>>> +/* kvm_split_pmd - splits huge pages to small pages, required to keep a dirty
>>> + *	log of smaller memory granules, otherwise huge pages would need to be
>>> + *	migrated. Practically an idle system has problems migrating with
>>
>> This seems abrupt.  Why can't we just represent a 2M huge page as 512 4K
>> bits and write protect the huge pages, if you take a write fault on a 2M
>> page, then split it then.
> 
> That's one alternative the one I put into v6 is clear the PMD
> and force user_mem_abort() to fault in 4k pages, and mark the
> dirty_bitmap[] for that page, reuse the current code. Have not
> checked the impact on performance, it takes few seconds longer
> to converge for the tests I'm running. 

I was thinking about this and if PMD attributes need to be passed
onto the PTEs then it appears what you recommend is required.
But during run time I don't see how 2nd stage attributes can
change, could the guest do anything to change them (SH, Memattr)?


Performance may also be other reason but that always depends
on the load, clearing a PMD seems easier and reuses current code.
Probably several load tests/benchmarks can help here.
Also noticed hw PMD/PTE attributes differ a little which
is not significant now, but moving forward different page size
and any new revisions to fields may require additional maintenance.

I'll be out next week and back 26'th, I'll create a link with
details on test environment and tests. The cover letter will
will go through general overview only.

Thanks,
  Mario

> 
>>
>> If your use case is HA, then you will be doing this a lot, and you don't
>> want to hurt performance of your main live system more than necessary.
> 
>>
>>> + *	huge pages.  Called during WP of entire VM address space, done
>>
