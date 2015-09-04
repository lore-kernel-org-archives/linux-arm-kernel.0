From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Sep 2015 12:25:56 +0100
Subject: [PATCH 1/3] arm64/cpufeature.h: Add macros for a cpu features
 testing
In-Reply-To: <1441303911-9421-1-git-send-email-kuleshovmail@gmail.com>
References: <1441303911-9421-1-git-send-email-kuleshovmail@gmail.com>
Message-ID: <20150904112555.GB17253@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2015 at 12:11:51AM +0600, Alexander Kuleshov wrote:
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -28,7 +28,50 @@
>  
>  #define ARM64_NCAPS				4
>  
> +/*
> + * ID_AA64ISAR0_EL1 AES, bits [7:4]
> + */
> +#define ID_AA64ISAR0_EL1_AES_MASK	4
> +#define ID_AA64ISAR0_EL1_AES(feature)	\
> +	(((feature >> ID_AA64ISAR0_EL1_AES_MASK) & 0xf) & 1UL)

This looks more like a shift than a mask. I don't think it's worth
defining another macro for the shift.

> +#define ID_AA64ISAR0_EL1_PMULL(feature)	\
> +	(((feature >> ID_AA64ISAR0_EL1_AES_MASK) & 0xf) & 2UL)

I'm not against some clean-up here but I think you break the original
logic. AES and PMULL are not exclusive, the latter implies the former
but the way you check here is just individual bits. These id fields are
meant to be treated as 4-bit signed values, so if AES means >= 1, PMULL
means >= 2. We have a cpuid_feature_extract_field() (in linux-next and
about to go in 4.3-rc1), so use this one for extracting the signed 4-bit
field.

-- 
Catalin
