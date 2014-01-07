From: ccross@android.com (Colin Cross)
Date: Tue, 7 Jan 2014 13:37:59 -0800
Subject: [PATCH] arm: mm: add memory type for inner-writeback
In-Reply-To: <20140107150918.GA16947@localhost>
References: <1388120328-17148-1-git-send-email-markz@nvidia.com>
 <20140107150918.GA16947@localhost>
Message-ID: <CAMbhsRR-ZuNjauOje9XoKTBVJ=2upRt6_+xqC3XjTCSCZtDJRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 7, 2014 at 7:09 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Dec 27, 2013 at 04:58:48AM +0000, Mark Zhang wrote:
>> From: Colin Cross <ccross@android.com>
>>
>> For streaming-style operations (e.g., software rendering of graphics
>> surfaces shared with non-coherent DMA devices), the cost of performing
>> L2 cache maintenance can exceed the benefit of having the larger cache
>> (this is particularly true for OUTER_CACHE configurations like the ARM
>> PL2x0).
>>
>> This change uses the currently-unused mapping 5 (TEX[0]=1, C=0, B=1)
>> in the tex remapping tables as an inner-writeback-write-allocate, outer
>> non-cacheable memory type, so that this mapping will be available to
>> clients which will benefit from the reduced L2 maintenance.
>>
>> Signed-off-by: Gary King <gking@nvidia.com>
>
> Is Colin signing off this patch as well?
>
>> --- a/arch/arm/mm/proc-v7-2level.S
>> +++ b/arch/arm/mm/proc-v7-2level.S
>> @@ -144,8 +144,8 @@ ENDPROC(cpu_v7_set_pte_ext)
>>        *   NS1 = PRRR[19] = 1         - normal shareable property
>>        *   NOS = PRRR[24+n] = 1       - not outer shareable
>>        */
>> -.equ PRRR,   0xff0a81a8
>> -.equ NMRR,   0x40e040e0
>> +.equ PRRR,   0xff0a89a8
>> +.equ NMRR,   0x40e044e0
>
> It should be done for the *-3level files.
>
> --
> Catalin

I shouldn't have authorship on that patch at all.  The original is at
https://android.googlesource.com/kernel/tegra/+/fb382752691d74a849996daf77be961ca2cdae97
and I must have screwed up the authorship when fixing conflicts when
cherry-picking it to the android-tegra-moto-2.6.39 branch.  Please
change the author back to "Gary King <gking@nvidia.com>".
