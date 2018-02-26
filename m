From: guohanjun@huawei.com (Hanjun Guo)
Date: Mon, 26 Feb 2018 20:53:17 +0800
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_[RFC_patch]_ioremap:_don't_set_up?=
 =?UTF-8?Q?_huge_I/O_mappings_when_p4d/pud/pmd_is_zero?=
In-Reply-To: <20180226110422.GD8736@arm.com>
References: <1514460261-65222-1-git-send-email-guohanjun@huawei.com>
 <861128ce-966f-7006-45ba-6a7298918686@codeaurora.org>
 <1519175992.16384.121.camel@hpe.com> <etPan.5a8d2180.1dbfd272.49b8@localhost>
 <20180221115758.GA7614@arm.com>
 <32c9b1c3-086b-ba54-f9e9-aefa50066730@huawei.com>
 <20180226110422.GD8736@arm.com>
Message-ID: <a80e540f-f3bd-53da-185d-7fffe801f10c@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/2/26 19:04, Will Deacon wrote:
> On Mon, Feb 26, 2018 at 06:57:20PM +0800, Hanjun Guo wrote:
>> On 2018/2/21 19:57, Will Deacon wrote:
>>> [sorry, trying to deal with top-posting here]
>>>
>>> On Wed, Feb 21, 2018 at 07:36:34AM +0000, Wangxuefeng (E) wrote:
>>>>      The old flow of reuse the 4k page as 2M page does not follow the BBM flow
>>>> for page table reconstruction?not only the memory leak problems.  If BBM flow
>>>> is not followed?the speculative prefetch of tlb will made false tlb entries
>>>> cached in MMU, the false address will be got? panic will happen.
>>>
>>> If I understand Toshi's suggestion correctly, he's saying that the PMD can
>>> be cleared when unmapping the last PTE (like try_to_free_pte_page). In this
>>> case, there's no issue with the TLB because this is exactly BBM -- the PMD
>>> is cleared and TLB invalidation is issued before the PTE table is freed. A
>>> subsequent 2M map request will see an empty PMD and put down a block
>>> mapping.
>>>
>>> The downside is that freeing becomes more expensive as the last level table
>>> becomes more sparsely populated and you need to ensure you don't have any
>>> concurrent maps going on for the same table when you're unmapping. I also
>>> can't see a neat way to fit this into the current vunmap code. Perhaps we
>>> need an iounmap_page_range.
>>>
>>> In the meantime, the code in lib/ioremap.c looks totally broken so I think
>>> we should deselect CONFIG_HAVE_ARCH_HUGE_VMAP on arm64 until it's fixed.
>>
>> Simply do something below at now (before the broken code is fixed)?
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index b2b95f7..a86148c 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -84,7 +84,6 @@ config ARM64
>>         select HAVE_ALIGNED_STRUCT_PAGE if SLUB
>>         select HAVE_ARCH_AUDITSYSCALL
>>         select HAVE_ARCH_BITREVERSE
>> -   select HAVE_ARCH_HUGE_VMAP
>>         select HAVE_ARCH_JUMP_LABEL
>>         select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
>>         select HAVE_ARCH_KGDB
> 
> No, that actually breaks with the use of block mappings for the kernel
> text. Anyway, see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=15122ee2c515a253b0c66a3e618bc7ebe35105eb

Sorry, just back from holidays and didn't catch up with all the emails,
thanks for taking care of this.

Hanjun
