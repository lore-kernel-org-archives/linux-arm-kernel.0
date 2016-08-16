From: groeck@google.com (Guenter Roeck)
Date: Tue, 16 Aug 2016 08:02:53 -0700
Subject: Problem with atomic accesses in pstore on some ARM CPUs
In-Reply-To: <20160816132103.GD27088@arm.com>
References: <CABXOdTfT7xMfiBvRuUS1hsVs=q5q2wY1x1Z8oCyyJNFckM0g0A@mail.gmail.com>
 <8f0c9ced-cdc3-ab9b-caee-06fe85e6c1e7@arm.com>
 <CABXOdTfg2T2tZrQOd2S5SjeySAMbfQX0weFuvRXBr2o8Of9nVQ@mail.gmail.com>
 <20160816132103.GD27088@arm.com>
Message-ID: <CABXOdTfHX_ZB1CuM7hzU5LCZPYdHvBSatN9Nen=rb8r1rXhz-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 6:21 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Aug 16, 2016 at 06:14:53AM -0700, Guenter Roeck wrote:
>> On Tue, Aug 16, 2016 at 3:32 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>> > On 16/08/16 00:19, Guenter Roeck wrote:
>> >> we are having a problem with atomic accesses in pstore on some ARM
>> >> CPUs (specifically rk3288 and rk3399). With those chips, atomic
>> >> accesses fail with both pgprot_noncached and pgprot_writecombine
>> >> memory. Atomic accesses do work when selecting PAGE_KERNEL protection.
>> >
>> > What's the pstore backed by? I'm guessing it's not normal DRAM.
>> >
>>
>> it is normal DRAM.
>
> In which case, why does it need to be mapped with weird attributes?
> Is there an alias in the linear map you can use?
>

I don't really _want_ to do anything besides using pstore as-is, or,
in other words, to have the upstream kernel work with the affected
systems.

The current pstore code runs the following code for memory with
pfn_valid() = true.

        if (memtype)
                prot = pgprot_noncached(PAGE_KERNEL);
        else
                prot = pgprot_writecombine(PAGE_KERNEL);
        ...
        vaddr = vmap(pages, page_count, VM_MAP, prot);

It then uses the memory pointed to by vaddr for atomic operations.

In my case, both protection options don't work. Everything works fine
(or at least doesn't create an exception) if I use
        vaddr = vmap(pages, page_count, VM_MAP, PAGE_KERNEL);
instead.

Thanks,
Guenter
