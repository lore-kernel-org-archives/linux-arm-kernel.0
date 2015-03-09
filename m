From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 18:06:45 +0000
Subject: [PATCH v2] ARM: advertise availability of v8 Crypto instructions
In-Reply-To: <1425556302-3370-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1425556302-3370-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150309180645.GD8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 12:51:42PM +0100, Ard Biesheuvel wrote:
> @@ -393,6 +393,20 @@ static void __init cpuid_init_hwcaps(void)
>  	vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
>  	if (vmsa >= 5)
>  		elf_hwcap |= HWCAP_LPAE;
> +
> +	/* check for supported v8 Crypto instructions */
> +	isar5 = read_cpuid_ext(CPUID_EXT_ISAR5);
> +
> +	switch ((isar5 >> 4) & 0xf) {
> +	case 2:	elf_hwcap2 |= HWCAP2_PMULL;	/* pmull implies aes */
> +	case 1:	elf_hwcap2 |= HWCAP2_AES;
> +	}
> +	if (((isar5 >> 8) & 0xf) == 1)
> +		elf_hwcap2 |= HWCAP2_SHA1;
> +	if (((isar5 >> 12) & 0xf) == 1)
> +		elf_hwcap2 |= HWCAP2_SHA2;
> +	if (((isar5 >> 16) & 0xf) == 1)
> +		elf_hwcap2 |= HWCAP2_CRC32;

Reading through the ARMv7 ARM, the ISAR registers seem to work in a way
that "feature >= N" is sufficient to test for something (in other words,
the feature revision bits build on previous instructions added by older
revisions of that feature.)

Hence why PMULL implies AES - that follows the same pattern.  So, I wonder
if those == should all be >=, and there should be a "default:" before
"case 2:" with the zero case handled separately.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
