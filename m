From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 15 Dec 2011 11:00:41 -0800
Subject: [RFC PATCH] ARM: vmlinux.lds.S: do not hardcode cacheline size
 as 32 bytes
In-Reply-To: <1323799572-5641-1-git-send-email-will.deacon@arm.com>
References: <1323799572-5641-1-git-send-email-will.deacon@arm.com>
Message-ID: <4EEA43D9.9040700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/11 10:06, Will Deacon wrote:
> The linker script assumes a cacheline size of 32 bytes when aligning
> the .data..cacheline_aligned and .data..percpu sections.
>
> This patch updates the script to use L1_CACHE_BYTES, which should be set
> to 64 on platforms that require it.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>
> I'm posting this as an RFC because, whilst this fixes a bug, it looks
> like many platforms don't select ARM_L1_CACHE_SHIFT_6 when they should
> (all Cortex-A8 platforms should select this, for example).

What are the implications of not having cache aligned data? Is it a
performance impact or something more?

> @@ -205,7 +206,7 @@ SECTIONS
>  #endif
>  
>  		NOSAVE_DATA
> -		CACHELINE_ALIGNED_DATA(32)
> +		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
>  		READ_MOSTLY_DATA(32)

Does READ_MOSTLY_DATA also need to be cache aligned? At least powerpc is
doing that.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
