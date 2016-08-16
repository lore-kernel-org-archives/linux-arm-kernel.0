From: groeck@google.com (Guenter Roeck)
Date: Tue, 16 Aug 2016 06:21:08 -0700
Subject: Problem with atomic accesses in pstore on some ARM CPUs
In-Reply-To: <20160816104537.GB27088@arm.com>
References: <CABXOdTfT7xMfiBvRuUS1hsVs=q5q2wY1x1Z8oCyyJNFckM0g0A@mail.gmail.com>
 <8f0c9ced-cdc3-ab9b-caee-06fe85e6c1e7@arm.com>
 <20160816104537.GB27088@arm.com>
Message-ID: <CABXOdTdJUVDbuFnLqQtJTwfe=XkziDUamNiPPHwDgD=MUTxraA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 3:45 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Aug 16, 2016 at 11:32:04AM +0100, Robin Murphy wrote:
>> On 16/08/16 00:19, Guenter Roeck wrote:
>> > we are having a problem with atomic accesses in pstore on some ARM
>> > CPUs (specifically rk3288 and rk3399). With those chips, atomic
>> > accesses fail with both pgprot_noncached and pgprot_writecombine
>> > memory. Atomic accesses do work when selecting PAGE_KERNEL protection.
>>
>> What's the pstore backed by? I'm guessing it's not normal DRAM.
>
> Regardless, pgprot_noncached and pgprot_writecombine map to Device-nGnRnE
> and Normal-non-cacheable respectively, and so it's IMP DEP whether or not
> exclusives will work there.
>
>> > Debugging on rk3399 shows the following crash.
>> >
>> > [    0.912669] Bad mode in Error handler detected, code 0xbf000002 -- SError
>> > [    0.920140] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 4.4.14 #389
>> > [    0.926838] Hardware name: Google Kevin (DT)
>> > [    0.931533] task: ffffffc0edfe0000 ti: ffffffc0edf7c000 task.ti:
>> > ffffffc0edf 7c000
>> > [    0.939780] PC is at __ll_sc___cmpxchg_case_mb_4+0x2c/0x5c
>> > [    0.945811] LR is at 0x1
>> >
>> > The "solution" for this problem in various Chrome OS releases is to
>> > disable atomic accesses in pstore entirely, which seems to be a bit
>> > brute-force. Question is what a proper upstream-acceptable solution
>
> Why do you require atomics to the pstore? If you need to serialise updates
> from coherent observers (e.g. CPUs), is it acceptable to use a lock in
> normal memory instead?
>

Sure, this is just how pstore works today, and I would prefer not
having to hack upstream code. This is normal DRAM. The initialization
code does the following.

        if (pfn_valid(start >> PAGE_SHIFT))
                prz->vaddr = persistent_ram_vmap(start, size, memtype);
        else
                prz->vaddr = persistent_ram_iomap(start, size, memtype);

persistent_ram_vmap() uses atomics, persistent_ram_iomap() uses
spinlocks. For normal DRAM, pfn_valid() returns true.

Thanks,
Guenter
