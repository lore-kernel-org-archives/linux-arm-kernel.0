From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Wed, 22 Jun 2016 09:55:55 +0800
Subject: [PATCH v4 00/14] fix some type infos and bugs for arm64/of numa
In-Reply-To: <57678F8F.6060303@huawei.com>
References: <1465286898-13828-1-git-send-email-thunder.leizhen@huawei.com>
 <20160607135852.GA20477@arm.com> <5757DE57.10700@huawei.com>
 <20160614142220.GC14654@e104818-lin.cambridge.arm.com>
 <57678F8F.6060303@huawei.com>
Message-ID: <5769F02B.7090705@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/6/20 14:39, Leizhen (ThunderTown) wrote:
> 
> 
> On 2016/6/14 22:22, Catalin Marinas wrote:
>> On Wed, Jun 08, 2016 at 04:59:03PM +0800, Leizhen (ThunderTown) wrote:
>>> On 2016/6/7 21:58, Will Deacon wrote:
>>>> On Tue, Jun 07, 2016 at 04:08:04PM +0800, Zhen Lei wrote:
>>>>> v3 -> v4:
>>>>> 1. Packed three patches of Kefeng Wang, patch6-8.
>>>>> 2. Add 6 new patches(9-15) to enhance the numa on arm64.
>>>>>
>>>>> v2 -> v3:
>>>>> 1. Adjust patch2 and patch5 according to Matthias Brugger's advice, to make the
>>>>>    patches looks more well. The final code have no change. 
>>>>>
>>>>> v1 -> v2:
>>>>> 1. Base on https://lkml.org/lkml/2016/5/24/679
>>>>
>>>> If you want bug fixes to land in 4.7, you'll need to base them on a
>>>> mainline kernel.
>>>
>>> I heared that David Daney's acpi numa patch series was accepted and
>>> put into next branch(Linux 4.8).
>>> Otherwise I will suggest him sending his patch6-7 to mainline first.
>>> So that, only a very small conflict will be exist.
>>>
>>> I also tested that:
>>> 1. git am David Daney's patch6-7, then git am all of my patches on a
>>> branch, named branch A.
>>> 2. git am David Daney's patch6-7 on another branch, named branch B.
>>> 3. when I git merge B into branch A, it's still conflict. So I guess
>>> git merge is based on source code, rather than patches.
>>>
>>> So at present, unless the maintainers are willing to resolve the
>>> conflict, otherwise I update my patches will not work.
>>
>> It usually depends on how complex the conflict is and whether your
>> patches functionally depend on the other patches. I have no idea what
>> the dependency is here since I haven't tried applying them to mainline.
>>
>>> Fortunately, these patches are not particularly urgent. So I think I
>>> can wait until Linux 4.8 start, then send these patches again. But I'm
>>> not sure whether these patches can be merged into Linux 4.8, I really
>>> hope.
>>
>> If there are fixes to the arm64 ACPI NUMA patches that Rafael queued
>> into linux-next, they should be sent to him and potentially being queued
>> on top ahead of the 4.8 merging window or shortly after 4.8-rc1.
>> Non-ACPI NUMA patches (as I can see, most of these patches are DT
>> specific) could be merged independently.
>>
>> So how many patches do you have in each category below:
>>
>> 1. NUMA fixes against current mainline (4.7-rc3)
>> 2. NUMA fixes against the arm64 ACPI NUMA patches queued by Rafael
> My patches have not fixed any bugs for ACPI NUMA, but just based on it.
> There are only three related patches:
> [PATCH v7 06_15] arm64, numa  rework numa_add_memblk()
> [PATCH v7 07_15] arm64, numa  Cleanup NUMA disabled messages.
> [PATCH v7 14_15] arm64, acpi, numa  NUMA support based on SRAT and SLIT
> 
> arch/arm64/mm/numa.c          |  28 ++++--
> drivers/of/of_numa.c          |   4 +-
> 
> My patches 1-5, 8, 11 will confict with it.
> 
>> 3. New functionality or clean-up. Are these against mainline or ACPI
>>    NUMA patches?
> Hi, Catalin
> I'm sorry to reply this email too late. Because I have been thinking if
> there are any other solutions.
> 
> I try to adjust the sequence of my patches as below:
> 1. New functionality 		//queued in your branch  (my patches 9-14, and 6, 6 is clean-up)
> 2. 4.8-rc1			//apci numa series and my new functionality had been merged
> 3. bug fixes			//other 4.8-rc versions	 (my patches 1-5)
> 4. clean-up (pr_fmt)		//queued in 4.9		 (my patches 7-8)

Hi, Catalin
  What about your opinion? Are you agree?

> 
> And there only one confliction exist:
> ++<<<<<<< HEAD
>  +static u8 numa_distance[MAX_NUMNODES][MAX_NUMNODES];			//choose this
>  +static int numa_off;
> ++=======
> + static int numa_distance_cnt;
> + static u8 *numa_distance;
> + static bool numa_off;							//choose this
> ++>>>>>>> acpi
> 
>>
