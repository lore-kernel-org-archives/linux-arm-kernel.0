From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 10 Nov 2017 17:26:56 +0000
Subject: [PATCH] arm64: cpu_errata: Add Kryo to Falkor 1003 errata
In-Reply-To: <20171108190029.19835-1-sboyd@codeaurora.org>
References: <20171108190029.19835-1-sboyd@codeaurora.org>
Message-ID: <20171110172656.zvnpfjkky7rqumyf@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 08, 2017 at 11:00:29AM -0800, Stephen Boyd wrote:
> The Kryo CPUs are also affected by the Falkor 1003 errata, so
> we need to do the same workaround on Kryo CPUs. The MIDR is
> slightly more complicated here, where the PART number is not
> always the same when looking at all the bits from 15 to 4. Drop
> the lower 8 bits and just look at the top 4 to see if it's '2'
> and then consider those as Kryo CPUs. This covers all the
> combinations without having to list them all out.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> We may need to introduce another Kconfig option to block software PAN
> from being enabled when this errata is enabled (and then have software PAN
> depend on this new config being false).

It depends on whether you'd want to use SW PAN together with these CPUs.
>From a defconfig + single Image perspective, SW PAN is disabled but it
would be nice to allow single Image with both E1003 and SW PAN configs
enabled (though SW PAN wouldn't be used at run-time).

As a quick hack, something like below but we may want to add a separate
cap bit as a minor optimisation (not sure it makes a difference).
Untested:

------------------8<--------------------------
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index ac67cfc2585a..8d2ddaef70a2 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -268,7 +268,8 @@ static inline bool system_supports_fpsimd(void)
 static inline bool system_uses_ttbr0_pan(void)
 {
 	return IS_ENABLED(CONFIG_ARM64_SW_TTBR0_PAN) &&
-		!cpus_have_const_cap(ARM64_HAS_PAN);
+		!cpus_have_const_cap(ARM64_HAS_PAN) &&
+		!cpus_have_const_cap(ARM64_WORKAROUND_QCOM_FALKOR_E1003);
 }
 
------------------8<--------------------------

> Otherwise, I can take a look at updating the software PAN implementation
> to handle this errata, but that is probably a dead-end?

It will probably be more intrusive and would also make SW PAN a lot
slower. I don't think it's worth it.

-- 
Catalin
