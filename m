From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 3 Mar 2015 14:43:01 +0100
Subject: [PATCH] ARM: advertise availability of v8 Crypto instructions
In-Reply-To: <1425054991-29951-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1425054991-29951-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu_dSgtsUp8aeMwz9a6stEC3DCg8GMU5QWWTPy_oOyHCSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 February 2015 at 17:36, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> When running the 32-bit ARM kernel on ARMv8 capable bare metal (e.g.,
> 32-bit Android userland and kernel on a Cortex-A53), or as a KVM guest
> on a 64-bit host, we should advertise the availability of the Crypto
> instructions, so that userland libraries such as OpenSSL may use them.
> (Support for the v8 Crypto instructions in the 32-bit build was added
> to OpenSSL more than six months ago)
>
> This adds the ID feature bit detection, and sets elf_hwcap2 accordingly.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/kernel/setup.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index e55408e96559..8d4cb1c1c9ac 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -393,6 +393,22 @@ static void __init cpuid_init_hwcaps(void)
>         vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
>         if (vmsa >= 5)
>                 elf_hwcap |= HWCAP_LPAE;
> +
> +       /* check for supported v8 Crypto instructions on non v7-M CPUs */

Perhaps this should be 'on v7+ (non v7-M) CPUs'

> +       if (cpu_architecture() == CPU_ARCH_ARMv7) {

@Russell: any thoughts on this?

Currently, v8 CPUs are identified as CPU_ARCH_ARMv7, and there is no
point in performing this test on other architectures (including v7-M)

> +               unsigned int id = read_cpuid_ext(CPUID_EXT_ISAR5);
> +
> +               switch ((id >> 4) & 0xf) {
> +               case 2: elf_hwcap2 |= HWCAP2_PMULL;
> +               case 1: elf_hwcap2 |= HWCAP2_AES;
> +               }
> +               if (((id >> 8) & 0xf) == 1)
> +                       elf_hwcap2 |= HWCAP2_SHA1;
> +               if (((id >> 12) & 0xf) == 1)
> +                       elf_hwcap2 |= HWCAP2_SHA2;
> +               if (((id >> 16) & 0xf) == 1)
> +                       elf_hwcap2 |= HWCAP2_CRC32;
> +       }
>  }
>
>  static void __init elf_hwcap_fixup(void)
> --
> 1.8.3.2
>
