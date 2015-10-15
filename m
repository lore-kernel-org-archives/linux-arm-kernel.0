From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 15 Oct 2015 14:25:28 +0100
Subject: [PATCH] ARM: SWP emulation: Restore original *data when failed
In-Reply-To: <20151015130247.GB29301@arm.com>
References: <1444791077-26020-1-git-send-email-shengjiu.wang@freescale.com>
 <20151015082417.GX32532@n2100.arm.linux.org.uk>
 <20151015083629.GA32630@shlinux2>
 <20151015085700.GY32532@n2100.arm.linux.org.uk> <561F6F3B.6030607@arm.com>
 <20151015130247.GB29301@arm.com>
Message-ID: <561FA948.5080505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/15 14:02, Will Deacon wrote:
> On Thu, Oct 15, 2015 at 10:17:47AM +0100, Vladimir Murzin wrote:
>> We might need the same change for arm64 counterpart (see
>> arch/arm64/kernel/armv8_deprecated.c).
> 
> Something like below?

Looks good. Should these two go to stable?

Vladimir

> 
> Will
> 
>>From 63c3e83073cfac2e011adf0ed6f335275cc977a7 Mon Sep 17 00:00:00 2001
> From: Will Deacon <will.deacon@arm.com>
> Date: Thu, 15 Oct 2015 13:55:53 +0100
> Subject: [PATCH] arm64: compat: fix stxr failure case in SWP emulation
> 
> If the STXR instruction fails in the SWP emulation code, we leave *data
> overwritten with the loaded value, therefore corrupting the data written
> by a subsequent, successful attempt.
> 
> This patch re-jigs the code so that we only write back to *data once we
> know that the update has happened.
> 
> Reported-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/armv8_deprecated.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
> index bcee7abac68e..6039d1eb5912 100644
> --- a/arch/arm64/kernel/armv8_deprecated.c
> +++ b/arch/arm64/kernel/armv8_deprecated.c
> @@ -284,12 +284,12 @@ static void register_insn_emulation_sysctl(struct ctl_table *table)
>  	__asm__ __volatile__(					\
>  	ALTERNATIVE("nop", SET_PSTATE_PAN(0), ARM64_HAS_PAN,	\
>  		    CONFIG_ARM64_PAN)				\
> -	"	mov		%w2, %w1\n"			\
> -	"0:	ldxr"B"		%w1, [%3]\n"			\
> -	"1:	stxr"B"		%w0, %w2, [%3]\n"		\
> +	"0:	ldxr"B"		%w2, [%3]\n"			\
> +	"1:	stxr"B"		%w0, %w1, [%3]\n"		\
>  	"	cbz		%w0, 2f\n"			\
>  	"	mov		%w0, %w4\n"			\
>  	"2:\n"							\
> +	"	mov		%w1, %w2\n"			\
>  	"	.pushsection	 .fixup,\"ax\"\n"		\
>  	"	.align		2\n"				\
>  	"3:	mov		%w0, %w5\n"			\
> 
