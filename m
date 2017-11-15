From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Nov 2017 16:35:22 -0800
Subject: [PATCH] arm64: cpu_errata: Add Kryo to Falkor 1003 errata
In-Reply-To: <20171110172656.zvnpfjkky7rqumyf@armageddon.cambridge.arm.com>
References: <20171108190029.19835-1-sboyd@codeaurora.org>
 <20171110172656.zvnpfjkky7rqumyf@armageddon.cambridge.arm.com>
Message-ID: <20171115003522.GL11955@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10, Catalin Marinas wrote:
> On Wed, Nov 08, 2017 at 11:00:29AM -0800, Stephen Boyd wrote:
> > The Kryo CPUs are also affected by the Falkor 1003 errata, so
> > we need to do the same workaround on Kryo CPUs. The MIDR is
> > slightly more complicated here, where the PART number is not
> > always the same when looking at all the bits from 15 to 4. Drop
> > the lower 8 bits and just look at the top 4 to see if it's '2'
> > and then consider those as Kryo CPUs. This covers all the
> > combinations without having to list them all out.
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> > 
> > We may need to introduce another Kconfig option to block software PAN
> > from being enabled when this errata is enabled (and then have software PAN
> > depend on this new config being false).
> 
> It depends on whether you'd want to use SW PAN together with these CPUs.
> From a defconfig + single Image perspective, SW PAN is disabled but it
> would be nice to allow single Image with both E1003 and SW PAN configs
> enabled (though SW PAN wouldn't be used at run-time).
> 
> As a quick hack, something like below but we may want to add a separate
> cap bit as a minor optimisation (not sure it makes a difference).
> Untested:

Ok. The Falkor CPUs support HW PAN so your patch looks like it
should work. If we're running on a Kryo CPU we may not see the HW
PAN capability and then we would still return false here because
the errata is present. I'll fold it in and test it out.

> 
> ------------------8<--------------------------
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index ac67cfc2585a..8d2ddaef70a2 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -268,7 +268,8 @@ static inline bool system_supports_fpsimd(void)
>  static inline bool system_uses_ttbr0_pan(void)
>  {
>  	return IS_ENABLED(CONFIG_ARM64_SW_TTBR0_PAN) &&
> -		!cpus_have_const_cap(ARM64_HAS_PAN);
> +		!cpus_have_const_cap(ARM64_HAS_PAN) &&
> +		!cpus_have_const_cap(ARM64_WORKAROUND_QCOM_FALKOR_E1003);
>  }
>  

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
