From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Oct 2012 15:53:50 -0700
Subject: [PATCH 5/7] ARM: hw_breakpoint: make boot quieter without CPUID
 feature registers
In-Reply-To: <1350487901-3108-6-git-send-email-will.deacon@arm.com>
References: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
 <1350487901-3108-6-git-send-email-will.deacon@arm.com>
Message-ID: <5088717E.4000001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/12 08:31, Will Deacon wrote:
> Booting on a v6 core without the CPUID feature registers (e.g. 1136)
> leads to a noisy dmesg complaining about their absence.
>
> This patch changes the pr_warning into a WARN_ONCE to keep the log
> quieter.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> @@ -135,11 +135,10 @@ static u8 get_debug_arch(void)
>  	u32 didr;
>  
>  	/* Do we implement the extended CPUID interface? */
> -	if (((read_cpuid_id() >> 16) & 0xf) != 0xf) {
> -		pr_warning("CPUID feature registers not supported. "
> -			   "Assuming v6 debug is present.\n");
> +	if (WARN_ONCE(((read_cpuid_id() >> 16) & 0xf) != 0xf,
> +		"CPUID feature registers not supported. "
> +		"Assuming v6 debug is present.\n"))

Won't this print a big stack trace instead of a one liner? Perhaps you
want pr_warn_once()?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
