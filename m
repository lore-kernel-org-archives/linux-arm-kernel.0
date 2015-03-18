From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Mar 2015 11:01:14 +0000
Subject: [PATCH v3] ARM: advertise availability of v8 Crypto instructions
In-Reply-To: <1425974088-15591-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1425974088-15591-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150318110114.GE8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 08:54:48AM +0100, Ard Biesheuvel wrote:
> @@ -393,6 +393,37 @@ static void __init cpuid_init_hwcaps(void)
>  	vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
>  	if (vmsa >= 5)
>  		elf_hwcap |= HWCAP_LPAE;
> +
> +	/*
> +	 * ID_ISAR5 contains 4-bit wide signed feature blocks.
> +	 * The blocks we test below represent incremental functionality
> +	 * for non-negative values. Negative values are reserved.
> +	 */
> +	features = read_cpuid_ext(ID_ISAR5);
> +	block = (features >> 4) & 0xf;

Okay, what I'd like to see is something like:

	block = cpuid_feature_extract_field(features, 4);

with this in cputype.h:

static inline int cpuid_feature_extract_field(u32 features, unsigned int field)
{
	int feature = (features >> field) & 15;

	/* feature registers are signed values */
	if (feature > 8)
		feature -= 16;

	return feature;
}

We can then use proper signed tests in the code - and convert all tests
to use this helper.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
