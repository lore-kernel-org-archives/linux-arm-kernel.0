From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Oct 2015 12:11:28 +0100
Subject: [PATCH v2 16/22] arm64/debug: Make use of the system wide safe
 value
In-Reply-To: <1444064531-25607-17-git-send-email-suzuki.poulose@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-17-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151008111128.GH17192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 06:02:05PM +0100, Suzuki K. Poulose wrote:
> @@ -137,13 +138,17 @@ extern struct pmu perf_ops_bp;
>  /* Determine number of BRP registers available. */
>  static inline int get_num_brps(void)
>  {
> -	return ((read_cpuid(ID_AA64DFR0_EL1) >> 12) & 0xf) + 1;
> +	return 1 +
> +		cpuid_feature_extract_field(read_system_reg(SYS_ID_AA64DFR0_EL1),
> +						ID_AA64DFR0_BRPS_SHIFT);
>  }

cpuid_feature_extract_field() is fine but we should we bother with
read_system_reg vs just read_cpuid?

Similar question for patch 17/22.

-- 
Catalin
