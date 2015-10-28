From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 28 Oct 2015 13:12:36 -0500
Subject: [PATCH] [v2] arm64: efi: make sure vmlinux load address aligned
 on 2MB
In-Reply-To: <20151028180836.GB26777@leverpostej>
References: <1446053844-27281-1-git-send-email-timur@codeaurora.org>
 <20151028180836.GB26777@leverpostej>
Message-ID: <56311014.9020400@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2015 01:08 PM, Mark Rutland wrote:

> arm64: efi: ensure kernel is loaded at correct address
>
> The kernel image needs to be loaded text_offset_bytes from a 2M-aligned
> base, per Documentation/arm64/booting.txt. If loaded at the wrong offset
> modulo 2M, __create_page_tables will create incorrect page tables.
>
> The EFI stub implicitly assumes that dram_base (i.e. the lowest address
> with a EFI_MEMORY_WB attribute) is 2M-aligned, and tries to load the
> kernel at dram_base + TEXT_OFFSET. If dram_base is not 2M-aligned, the
> kernel will be loaded at the wrong offset from 2M.

Thanks, I'll use that.  I messed up a couple other things, so I need to 
send out a v3 anyway.

>> -		*image_addr = *reserve_addr = dram_base + TEXT_OFFSET;
>> +		*image_addr = *reserve_addr =
>> +			round_up(dram_base, SZ_2M) + TEXT_OFFSET;
>
> We also need to fix the test for whether we need to relocate the kernel:
> (*image_addr != (dram_base + TEXT_OFFSET)).
>
> When dram_base is not 2M aligned, that is broken, and it's been broken
> since it was introduced in commit 3c7f255039a2ad6e ("arm64: efi: add EFI
> stub") in v3.16.
>
> It's a bit hideous to fix the general case, though, it seems.

Um, so I should I do something more in my v3 patch, or is this a change 
for a different patch?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
