From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 30 Oct 2015 08:01:35 -0700
Subject: arm64: about Add CONFIG_DEBUG_SET_MODULE_RONX suport
In-Reply-To: <563335FF.5020400@huawei.com>
References: <5633279A.7000003@huawei.com> <56332ADB.7030306@iogearbox.net>
 <563335FF.5020400@huawei.com>
Message-ID: <5633864F.6030203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(cc-ing the mailing list. Please always remember to do that)

Hi,

On 10/30/15 2:18 AM, Xishi Qiu wrote:
> On 2015/10/30 16:31, Daniel Borkmann wrote:
>
>> On 10/30/2015 09:17 AM, zhong jiang wrote:
>>> hi,can I ask you a question ? say , you provide the patch is restricted within
>>> the module is used. whether it can be used to other area ofmemory like x86_64.
>>> what is the limit?
>>
>> Sorry, I don't quite understand the question. You mean ...
>>
>> commit e6a2e1b6c24a3993ffbb69a05dda202d2830ad90
>> Author: Daniel Borkmann <daniel@iogearbox.net>
>> Date:   Sun Mar 1 10:14:39 2015 +0000
>>
>>      arm64: mm: unexport set_memory_ro and set_memory_rw
>>
>>      This effectively unexports set_memory_ro and set_memory_rw functions from
>>      commit 11d91a770f1f ("arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support").
>>
>>      No module user of those is in mainline kernel and we explicitly do not want
>>      modules to use these functions, as they i.e. RO-protect eBPF (interpreted and
>>      JIT'ed) images from malicious modifications/bugs.
>>
>>      Outside of eBPF scope, I believe also other set_memory_* functions should
>>      be unexported on arm64 due to non-existant mainline module user. Laura
>>      mentioned that they have some uses for modules doing set_memory_*, but
>>      none that are in mainline and it's unclear if they would ever get there.
>>
>>      Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>      Acked-by: Alexei Starovoitov <ast@plumgrid.com>
>>      Acked-by: Laura Abbott <lauraa@codeaurora.org>
>>      Signed-off-by: Will Deacon <will.deacon@arm.com>
>>
>> ...? What is your question in relation to this?
>>
>> ( x86_64 also has an implementation of set_memory_ro(). )
>>
>> Cheers,
>> Daniel
>>
>
> Hi Daniel,
>
> Sorry for didn't saying it clearly. I find this interface(set_memory_ro/rw) can
> only be used in module address. So why not extend the function? e.g. like x86,
> it can be used in direct mapping address too.
>
> Is there some limits in arm64 or we will do this later?
>

arm64 maps low mem (all direct mapped memory on arm64) with section
mappings for performance. set_memory_ro/rw works on PAGE_SIZE
granularity so if we wanted to use those functions on direct mapped
memory we would need to break down the section mappings. On arm,
this was a pain due to the TLB maintaince requried. On arm64, less
so but we still lose the benefit of the section mappings.

Do you have a use case in mind for wanting to use set_memory_ro/rw
outside of the module area?

> One more question, in arm64, create_mapping() will create the page table of direct
> mapping area, is the page 2M or 1G? I mean like the flag PAGE_KERNEL_LARGE in x86.
>

It will try to do 1G if it can.

Thanks,
Laura
