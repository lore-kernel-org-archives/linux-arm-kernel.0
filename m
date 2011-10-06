From: gdavis@mvista.com (George G. Davis)
Date: Thu, 6 Oct 2011 15:38:31 -0400
Subject: [RFC/PATCH 1/7] ARM: ARM11 MPCore: pgd_alloc is not preempt safe
In-Reply-To: <20111006163520.GA21464@n2100.arm.linux.org.uk>
References: <05942148-7AFB-4755-A22F-355E0360B098@mvista.com>
	<1317877714-11355-1-git-send-email-gdavis@mvista.com>
	<1317877714-11355-2-git-send-email-gdavis@mvista.com>
	<20111006163520.GA21464@n2100.arm.linux.org.uk>
Message-ID: <0D5AA174-DD77-4A5A-B16C-864649415F25@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 6, 2011, at 12:35 PM, Russell King - ARM Linux wrote:

> On Thu, Oct 06, 2011 at 01:08:28AM -0400, gdavis at mvista.com wrote:
>> @@ -31,6 +32,9 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
>> 	if (!new_pgd)
>> 		goto no_pgd;
>> 
>> +	if (cache_ops_need_broadcast())
>> +		get_cpu();
> 
> Is there something wrong with preempt_disable() here and preempt_enable()
> below?

I used the {get,put}_cpu() variants merely to (try to) make it clear that we want
this region to be non-preemptible for the current CPU.

>  If it's preempt that we're concerned about, these are the correct
> interfaces to be used.

Since  {get,put}_cpu() are wrappers for preempt_{enable,disable}, it works
either way and I'm happy to just use preempt_{enable,disable} instead.  It
achieves the same goal with slightly less overhead.  Also, while we're on
the subject of preempt_enable, an earlier version of this change used
preempt_enable_no_resched() but I chose to avoid the no_reched flavor
since I felt that it was worth minimizing scheduler latencies.

I'll change all of the  {get,put}_cpu() variants to  preempt_{enable,disable}
and submit an updated series.

Thanks!

--
Regards,
George


>> +
>> 	memset(new_pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
>> 
>> 	/*
>> @@ -42,6 +46,9 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
>> 
>> 	clean_dcache_area(new_pgd, PTRS_PER_PGD * sizeof(pgd_t));
>> 
>> +	if (cache_ops_need_broadcast())
>> +		put_cpu();
>> +
