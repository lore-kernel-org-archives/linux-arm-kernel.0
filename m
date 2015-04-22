From: bhaskarbudiredla@gmail.com (Bhaskara rao Budiredla)
Date: Thu, 23 Apr 2015 00:39:02 +0530
Subject: Programming the boundary between Inner and Outer caches on ARM
 architecture
In-Reply-To: <CAJWVF-wg1ROj_rwufJzszCR594NcJc89cW4R85ZSTQtissT4Bw@mail.gmail.com>
References: <CAJWVF-w5YpZjRqnvbz1p70_WTBROL9vDkvYb_sG43nGp=s1vLg@mail.gmail.com>
 <20150420100119.GC24715@e104818-lin.cambridge.arm.com>
 <CAJWVF-xvca0MpKF1=GoyyffGTzxtvy_LoaZfjhwU27vSuyOHFA@mail.gmail.com>
 <20150421110038.GH30114@e104818-lin.cambridge.arm.com>
 <CAJWVF-wg1ROj_rwufJzszCR594NcJc89cW4R85ZSTQtissT4Bw@mail.gmail.com>
Message-ID: <CAJWVF-xwBwjfQxV3+wEsNz0oDsR+VGVh2WMg+RdTE8_Lr1AJEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ctalin - by mistake I pressed the send button. The remaining
comments are added in line.


> 1. I am unable to find the register name that can be used for the
> above said purpose from Cortex A15 documentation. Please help me in
> providing that register details, if there is any such register (or)
> some other procedure by which the same can be achieved.

No such configuration. L1 and L2 caches are inner on A15.
[Bhaskara] I see, this is the reason why there is no such
configuration needed on Cortex A series processors. All of them
(including Cortex- A53/A57/A72) are configured for L1 and L2 caches
with inner cacheable attribute.

> 2. Configuration of the boundary between inner and outer caches is not
> needed for a system where in the inner and outer cacheable attributes
> are same. Does the current Linux kernel for ARM architecture assumes
> this?

The outer attributes are sent on the bus in case you have an L3 cache.
In general, I would set both inner and outer attributes the same. I
don't understand what your "specific requirement" is.
[Bhaskara] For all the Cortex-A series processors the CLIDR[8:6] bits
set to b000, which indicates the type of cache implemented at level 3
as "No Cache". Is this not an issue if any specific silicon vendor
wants to integrate L3 cache on his/her SOC along with Coretx-Axx
processor?

Thanks,
Bhaskara

On Thu, Apr 23, 2015 at 12:12 AM, Bhaskara rao Budiredla
<bhaskarbudiredla@gmail.com> wrote:
> Thanks very much Catalin for the help. Please find my comments in line.
>
>
>> Hi Catalin - The above said desired configuration was with respect to
>> a specific requirement of mine on Cortex A15. Seems it is confusing.
>> Let me give you the complete details. Along with PRRR/NMRR registers,
>> I am using [TEX[0], C, B] to configure the memory system attributes.
>> The inner cacheable attribute of NMRR normal memory region is
>> "write-back, write-allocate" and the corresponding outer cacheable
>> attribute is "write-back, no write-allocate".
>
> Any reason why they need to be different or that's just what Linux
> writes in NMRR?
> [Bhaskara] I am not sure why those are different. During Linux kernel
> booting, I wrote a function to read the contents of NMRR in
> build_mem_type_table( ) function. May be I need to sync up with boot
> loader folks to check why those are set up with different cacheable
> attributes. This difference was the reason to start this thread.
>
>> Since the lowest level
>> (level zero) cache defaults to inner cacheable attribute and the
>> highest level (level two) defaults to outer cacheable attribute,
>
> Why do you say that level two defaults to outer cacheable? Actually,
> what do you mean by zero, one, two? Are these the indices in the CLIDR?
> Cortex-A15 has two levels of cache, one and two, both treated as inner.
> [Bhaskara] It was my miss understanding. My apologies for that. Yes, I
> was referring to CLIDR indices, same as L1, L2 and L3 caches.
>
>> level one cache is the remaining that I need to program explicitly.
>> Hence the requirement to configure the boundary between the inner and
>> outer cacheable attributes to group the level one cache either with
>> level zero (or) level two.
>
> IIRC, the only CPU where we could configure this was Cortex-A8 via the
> L2ACTLR register ("L2 inner" bit) and from some past discussions, we
> wanted this to be treated as inner cache:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/082561.html
>
> (in Linux, we call outer cache some cache that needs separate
> maintenance by PA like the PL310)
>
>> 1. I am unable to find the register name that can be used for the
>> above said purpose from Cortex A15 documentation. Please help me in
>> providing that register details, if there is any such register (or)
>> some other procedure by which the same can be achieved.
>
> No such configuration. L1 and L2 caches are inner on A15.
> [Bhaskara] I see, this is the reason why there is no such
> configuration on Cortex v7
>
>> 2. Configuration of the boundary between inner and outer caches is not
>> needed for a system where in the inner and outer cacheable attributes
>> are same. Does the current Linux kernel for ARM architecture assumes
>> this?
>
> The outer attributes are sent on the bus in case you have an L3 cache.
> In general, I would set both inner and outer attributes the same. I
> don't understand what your "specific requirement" is.
> [Bhaskara]
>
>
> On Tue, Apr 21, 2015 at 4:30 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
>> On Tue, Apr 21, 2015 at 12:23:17AM +0530, Bhaskara rao Budiredla wrote:
>>> Hi Catalin - The above said desired configuration was with respect to
>>> a specific requirement of mine on Cortex A15. Seems it is confusing.
>>> Let me give you the complete details. Along with PRRR/NMRR registers,
>>> I am using [TEX[0], C, B] to configure the memory system attributes.
>>> The inner cacheable attribute of NMRR normal memory region is
>>> "write-back, write-allocate" and the corresponding outer cacheable
>>> attribute is "write-back, no write-allocate".
>>
>> Any reason why they need to be different or that's just what Linux
>> writes in NMRR?
>>
>>> Since the lowest level
>>> (level zero) cache defaults to inner cacheable attribute and the
>>> highest level (level two) defaults to outer cacheable attribute,
>>
>> Why do you say that level two defaults to outer cacheable? Actually,
>> what do you mean by zero, one, two? Are these the indices in the CLIDR?
>> Cortex-A15 has two levels of cache, one and two, both treated as inner.
>>
>>> level one cache is the remaining that I need to program explicitly.
>>> Hence the requirement to configure the boundary between the inner and
>>> outer cacheable attributes to group the level one cache either with
>>> level zero (or) level two.
>>
>> IIRC, the only CPU where we could configure this was Cortex-A8 via the
>> L2ACTLR register ("L2 inner" bit) and from some past discussions, we
>> wanted this to be treated as inner cache:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/082561.html
>>
>> (in Linux, we call outer cache some cache that needs separate
>> maintenance by PA like the PL310)
>>
>>> 1. I am unable to find the register name that can be used for the
>>> above said purpose from Cortex A15 documentation. Please help me in
>>> providing that register details, if there is any such register (or)
>>> some other procedure by which the same can be achieved.
>>
>> No such configuration. L1 and L2 caches are inner on A15.
>>
>>> 2. Configuration of the boundary between inner and outer caches is not
>>> needed for a system where in the inner and outer cacheable attributes
>>> are same. Does the current Linux kernel for ARM architecture assumes
>>> this?
>>
>> The outer attributes are sent on the bus in case you have an L3 cache.
>> In general, I would set both inner and outer attributes the same. I
>> don't understand what your "specific requirement" is.
>>
>> --
>> Catalin
>
>
>
> --
> .



-- 
.
