From: sramana@codeaurora.org (Srinivas Ramana)
Date: Wed, 22 Mar 2017 19:15:32 +0530
Subject: [PATCH v2] arm64: kaslr: Fix up the kernel image alignment
In-Reply-To: <20170322124008.GH8026@arm.com>
References: <904FACBF-3DFE-4DDE-ACB5-7109A137D477@linaro.org>
 <1490182705-14243-1-git-send-email-sramana@codeaurora.org>
 <CAKv+Gu-XUY0XBSK_oe4DbveZOhk8_ZQLMEdPmLiaRv9rCh7ifw@mail.gmail.com>
 <20170322124008.GH8026@arm.com>
Message-ID: <58D27FFC.8030205@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2017 06:10 PM, Will Deacon wrote:
> On Wed, Mar 22, 2017 at 12:16:24PM +0000, Ard Biesheuvel wrote:
>> On 22 March 2017 at 11:38, Srinivas Ramana <sramana@codeaurora.org> wrote:
>>> From: Neeraj Upadhyay <neeraju@codeaurora.org>
>>>
>>> If kernel image extends across alignment boundary, existing
>>> code increases the KASLR offset by size of kernel image. The
>>> offset is masked after resizing. There are cases, where after
>>> masking, we may still have kernel image extending across
>>> boundary. This eventually results in only 2MB block getting
>>> mapped while creating the page tables. This results in data aborts
>>> while accessing unmapped regions during second relocation (with
>>> kaslr offset) in __primary_switch. To fix this problem, round up the
>>> kernel image size, by swapper block size, before adding it for
>>> correction.
>>>
>>> For example consider below case, where kernel image still crosses
>>> 1GB alignment boundary, after masking the offset, which is fixed
>>> by rounding up kernel image size.
>>>
>>> SWAPPER_TABLE_SHIFT = 30
>>> Swapper using section maps with section size 2MB.
>>> CONFIG_PGTABLE_LEVELS = 3
>>> VA_BITS = 39
>>>
>>> _text  : 0xffffff8008080000
>>> _end   : 0xffffff800aa1b000
>>> offset : 0x1f35600000
>>> mask = ((1UL << (VA_BITS - 2)) - 1) & ~(SZ_2M - 1)
>>>
>>> (_text + offset) >> SWAPPER_TABLE_SHIFT = 0x3fffffe7c
>>> (_end + offset) >> SWAPPER_TABLE_SHIFT  = 0x3fffffe7d
>>>
>>> offset after existing correction (before mask) = 0x1f37f9b000
>>> (_text + offset) >> SWAPPER_TABLE_SHIFT = 0x3fffffe7d
>>> (_end + offset) >> SWAPPER_TABLE_SHIFT  = 0x3fffffe7d
>>>
>>> offset (after mask) = 0x1f37e00000
>>> (_text + offset) >> SWAPPER_TABLE_SHIFT = 0x3fffffe7c
>>> (_end + offset) >> SWAPPER_TABLE_SHIFT  = 0x3fffffe7d
>>>
>>> new offset w/ rounding up = 0x1f38000000
>>> (_text + offset) >> SWAPPER_TABLE_SHIFT = 0x3fffffe7d
>>> (_end + offset) >> SWAPPER_TABLE_SHIFT  = 0x3fffffe7d
>>>
>>> Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
>>> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
>>> Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
>>
>> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> ... and thanks for the excellent commit log message!
>
> Thanks both. I've picked this up as a fix.
>
> Will
>

Thanks Ard and Will for the review and picking this patch.
can we also CC: <stable@vger.kernel.org> ?

Thanks,
-- Srinivas R


-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, 
Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
