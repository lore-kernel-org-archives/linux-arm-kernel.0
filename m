From: ccross@android.com (Colin Cross)
Date: Tue, 16 Aug 2016 10:35:52 -0700
Subject: Problem with atomic accesses in pstore on some ARM CPUs
In-Reply-To: <20160815221518.GD1120@svinekod>
References: <CABXOdTfT7xMfiBvRuUS1hsVs=q5q2wY1x1Z8oCyyJNFckM0g0A@mail.gmail.com>
 <8f0c9ced-cdc3-ab9b-caee-06fe85e6c1e7@arm.com>
 <CABXOdTfg2T2tZrQOd2S5SjeySAMbfQX0weFuvRXBr2o8Of9nVQ@mail.gmail.com>
 <20160816132103.GD27088@arm.com>
 <CABXOdTfHX_ZB1CuM7hzU5LCZPYdHvBSatN9Nen=rb8r1rXhz-g@mail.gmail.com>
 <20160815221518.GD1120@svinekod>
Message-ID: <CAMbhsRQiU-UyiCWqjaWNXbhDd0+=Tv_pWoeQkJKJaHC6y4=HwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2016 at 3:15 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Aug 16, 2016 at 08:02:53AM -0700, Guenter Roeck wrote:
>> On Tue, Aug 16, 2016 at 6:21 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, Aug 16, 2016 at 06:14:53AM -0700, Guenter Roeck wrote:
>> >> On Tue, Aug 16, 2016 at 3:32 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>> >> > On 16/08/16 00:19, Guenter Roeck wrote:
>> >> >> we are having a problem with atomic accesses in pstore on some ARM
>> >> >> CPUs (specifically rk3288 and rk3399). With those chips, atomic
>> >> >> accesses fail with both pgprot_noncached and pgprot_writecombine
>> >> >> memory. Atomic accesses do work when selecting PAGE_KERNEL protection.
>> >> >
>> >> > What's the pstore backed by? I'm guessing it's not normal DRAM.
>> >> >
>> >>
>> >> it is normal DRAM.
>> >
>> > In which case, why does it need to be mapped with weird attributes?
>> > Is there an alias in the linear map you can use?
>> >
>>
>> I don't really _want_ to do anything besides using pstore as-is, or,
>> in other words, to have the upstream kernel work with the affected
>> systems.
>>
>> The current pstore code runs the following code for memory with
>> pfn_valid() = true.
>>
>>         if (memtype)
>>                 prot = pgprot_noncached(PAGE_KERNEL);
>>         else
>>                 prot = pgprot_writecombine(PAGE_KERNEL);
>>         ...
>>         vaddr = vmap(pages, page_count, VM_MAP, prot);
>>
>> It then uses the memory pointed to by vaddr for atomic operations.
>
> This means that the generic ramoops / pstore code is making non-portable
> assumptions about memory types.
>
> So _something_ has to happen to that code.
>
>> In my case, both protection options don't work. Everything works fine
>> (or at least doesn't create an exception) if I use
>>         vaddr = vmap(pages, page_count, VM_MAP, PAGE_KERNEL);
>> instead.
>
> Architecturally, that will give you a memory type to which we can safely use
> atomics on.
>
> It would be nice to know why the ramoops/pstore code must use atomics, and
> exactly what it's trying to achieve (i.e. is this just for serialisation, or an
> attempt to ensure persistence).
>
> Depending on that, it may be possible to fix things more generically by using
> memremap by default, for example, and only allowing uncached mappings on those
> architectures which support them.

persistent_ram uses atomic ops in uncached memory to store the start
and end positions in the ringbuffer so that the state of the
ringbuffer will be valid if the kernel crashes at any time.  This was
inherited from Android's ram_console implementation, and worked
through armv7.  It has been causing more and more problems recently,
see for example 027bc8b08242c59e19356b4b2c189f2d849ab660 (pstore-ram:
Allow optional mapping with pgprot_noncached) and
7ae9cb81933515dc7db1aa3c47ef7653717e3090 (pstore-ram: Fix hangs by
using write-combine mappings).

Maybe it should be replaced with a spinlock in normal ram protecting
writes to the uncached region.
