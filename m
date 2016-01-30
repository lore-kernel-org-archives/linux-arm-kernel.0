From: qiuxishi@huawei.com (Xishi Qiu)
Date: Sat, 30 Jan 2016 10:48:02 +0800
Subject: [PATCH] arm64: Allow vmalloc regions to be set with set_memory_*
In-Reply-To: <20160129110252.GB17038@leverpostej>
References: <1452635187-8057-1-git-send-email-labbott@fedoraproject.org>
 <CAKv+Gu_A1C9hXgqrYDekoy1YHaRXi_mUF-kYx-TqsOBkWMVjmQ@mail.gmail.com>
 <CAKv+Gu-73QKAsFQCa=yO5+=DihLXp_AKYyY6QRTVM4nuDH=-8g@mail.gmail.com>
 <20160118115640.GK21067@leverpostej> <56A97328.9070003@huawei.com>
 <20160128105138.GE17123@leverpostej> <56A9FFBD.8030303@huawei.com>
 <20160128142746.GL17123@leverpostej> <56AABEA4.3010301@huawei.com>
 <20160129110252.GB17038@leverpostej>
Message-ID: <56AC2462.20506@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/1/29 19:02, Mark Rutland wrote:

> On Fri, Jan 29, 2016 at 09:21:40AM +0800, Xishi Qiu wrote:
>> On 2016/1/28 22:27, Mark Rutland wrote:
>>> On Thu, Jan 28, 2016 at 07:47:09PM +0800, Xishi Qiu wrote:
>>>> Hi Mark,
>>>>
>>>> Is it safe in the following path?
>>>>
>>>> alloc the whole linear map section
>>>
>>> I don't understand what you mean by this, you will need to elaborate.
>>> The terms "alloc" and "section" can mean a number of different things in
>>> this context.
>>>
>>>> cpu A write something on it
>>>> cpu B write something on it
>>>> cpu C set read only flag and call flush_tlb_kernel_range()
>>>
>>> If you want to modify a portion of the linear map, this will not work.
>>> Modfiying the linear map in this manner is not safe.
>>>
>>> If you want an alias of the linear map which was mapped using pages, and
>>> you wanted to change that alias, that could work.
>>>
>>
>> Hi Mark,
>>
>> I mean I change the whole section(maybe 1G?) in linear map.
> 
> If you mean something that was mapped with a section (i.e. a block entry
> in some level of page table), then no. The linear map is not open to
> this kind of change, as portions of the region may be in use elsewhere
> within Linux.
> 
>> In our software, kernel create mapping(linear map) on special memory,
>> and
>> it is separated from buddy system, the service manage the special memory itself.
> 
> This is not what the linear map is for. What exactly is this "special
> memory"?
> 
> Is it some persistent memory?
> 
> Is it normal memory that you wish to use for some communication with
> other agents and/or DMA?
> 
> Is it normal memory that you simply have a special use-case for?
> 
>> And the service alloc/free the memory based on the physical address, so if 
>> the service want to change the prot dynamically, vmalloc doesn't work, and
>> fixmap is a little complex.
> 
> Without further explanation of your use-case, this doesn't make sense to
> me. I don't understand why the physical address matters -- that implies
> you have other agents accessing this memory. If that's the case, I don't
> see what changing the permissions buys you.
> 
> Regardless, it sounds like either we're missing some infrastructure, or
> you are mis-using existing APIs.
> 
>> I think if I create the spacial memory in 4kb, then the service could
>> use set_memory_ro() directly, right?
> 
> Perhaps. If it's a vmalloc'd area, then yes (once Ard's patch to allow
> that is in). I have more general concerns with your approach, in that I
> still do not understand the problem you are trying to solve.
> 

Hi Mark,

Thanks for your reply. Maybe I didn't express it clearly, sorry for it.

The abstract process is the following:
1. do not create a large block, use 4kb for all of the memory(regardless of performance).
setup_arch->paging_init()->map_mem()->__map_memblock()->create_mapping()
2. alloc a page and get the the linear mapping address.
3. modify judgment condition of the function set_memory_ro(), so it could handle the linear mapping range.
4. use set_memory_ro() to change the prot flag of the page which we get in step 2.

Is it safe?

Thanks,
Xishi Qiu

> Thanks,
> Mark.
> 
> .
> 
