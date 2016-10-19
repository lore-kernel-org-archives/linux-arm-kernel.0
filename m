From: geoff@infradead.org (Geoff Levand)
Date: Wed, 19 Oct 2016 15:52:30 -0700
Subject: [PATCH] arm64: Add support for additional relocations in the
 kexec purgatory code
In-Reply-To: <1476892714-27304-1-git-send-email-catalin.marinas@arm.com>
References: <1476892714-27304-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <15f9c4d2-34a8-fd74-05ec-0a8df41bc93a@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 10/19/2016 08:58 AM, Catalin Marinas wrote:
> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> index 2e8839a..e067a23 100644
> --- a/kexec/arch/arm64/kexec-arm64.c
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -585,6 +598,19 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
>  		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
>  			+ (((value - address) << 3) & 0xffffe0));
>  		break;
> +	case R_AARCH64_ADR_PREL_PG_HI21:
> +		type = "ADR_PREL_PG_HI21";
> +		imm = ((value & ~0xfff) - (address & ~0xfff)) >> 12;
> +		loc32 = ptr;
> +		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> +			+ ((imm & 3) << 29) + ((imm & 0x1ffffc) << (5 - 2)));
> +		break;
> +	case R_AARCH64_ADD_ABS_LO12_NC:
> +		type = "R_AARCH64_ADD_ABS_LO12_NC";

Following with the others, this should be 'type = "ADD_ABS_LO12_NC"'.

> +		loc32 = ptr;
> +		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> +			+ ((value & 0xfff) << 10));
> +		break;
>  	case R_AARCH64_JUMP26:
>  		type = "JUMP26";
>  		loc32 = ptr;
> @@ -597,6 +623,15 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
>  		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
>  			+ (((value - address) >> 2) & 0x3ffffff));
>  		break;
> +	case R_AARCH64_LDST64_ABS_LO12_NC:
> +		if (value & 7)
> +			die("%s: ERROR Unaligned value: %lx\n", __func__,
> +				value);
> +		type = "R_AARCH64_LDST64_ABS_LO12_NC";

And type = "LDST64_ABS_LO12_NC" here.

> +		loc32 = ptr;
> +		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> +			+ ((value & 0xff8) << (10 - 3)));
> +		break;
>  	default:
>  		die("%s: ERROR Unknown type: %lu\n", __func__, r_type);
>  		break;

Otherwise, looks good.  Thanks for taking time to make the fix.

-Geoff 
