From: Russ.Dill@ti.com (Russ Dill)
Date: Fri, 21 Feb 2014 22:46:59 -0800
Subject: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
In-Reply-To: <20140222043714.19852.67450@capellas-linux>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140219193315.3732.21819@capellas-linux>
 <20140220162754.GC15994@e102568-lin.cambridge.arm.com>
 <20140221183956.29890.80931@capellas-linux>
 <20140221235911.14777.13919@capellas-linux>
 <20140222043714.19852.67450@capellas-linux>
Message-ID: <530847E3.4070401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/21/2014 08:37 PM, Sebastian Capella wrote:
> Quoting Sebastian Capella (2014-02-21 15:59:11)
>> - Cyril Chemparathy as his email is bouncing back to me. 
>>
>> Quoting Sebastian Capella (2014-02-21 10:39:56)
>>> Quoting Lorenzo Pieralisi (2014-02-20 08:27:55)
>>>>>>> +     cpu_switch_mm(idmap_pgd, &init_mm);
>>   [ ... ]
>>> I can try removing it and seeing if there are side effects.
>>
>> FYI, It's definitely hanging with this removed, still looking.
> 
> I see when we reach this call, the 1st level page table @ TTBR0 is located
> at different memory locations each run (expected).  If we omit the
> cpu_switch_mm we're corrupting the page table causing the observed
> intermittent failures.  I believe these match the corruption you expected.
> 
> The reason this doesn't happen when I leave the call is that idmap_pgd
> is always at the same memory location.  I expect this is because it's
> allocated during init.  I've seen the same address 50/50 times for
> idmap_pgd.  I don't think it is correct to rely on this behavior.
> 
> Would it be appropriate to use the swapper_pg_dir directly in place
> of idmap_pgd?
>   - I do not see any modification to the swapper_pg_dir contents in the
>     code that would change from init time.
>   - swapper_pg_dir is always at the same offset.
> 
> Ideally we should have no issue with overwriting it with identical data.
> 
> I've run a couple hundred test loops using swapper_pg_dir and so far
> there are no failures.

If there is worry about this, you could setup a page mapping in a
__nosave region, preventing it from being overwritten.
