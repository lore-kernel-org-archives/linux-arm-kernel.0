From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 29 Apr 2015 16:37:16 +0200
Subject: Regression: Kirkwood fails to boot because of bf35706f3d0929b
In-Reply-To: <20150429140516.GA32151@lunn.ch>
References: <20150429140516.GA32151@lunn.ch>
Message-ID: <CAKv+Gu_CeMzWKJ-obW6hX7d5vM7fkr8vOAvbMQ74GZ3ZkU8Kow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 April 2015 at 16:05, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Ard
>
> It seems as thought all Kirkwood boards are dead in v4.1-rc1. They
> fail to boot with the message:
>
> Starting kernel ...
>
> Uncompressing Linux... done, booting the kernel.
>
> Error: unrecognized/unsupported processor variant (0x56251311).
>
> With a bit of testing, Ezequiel and Florian have found the guilty
> commit is:
>
> bf35706f3d09 ("ARM: 8314/1: replace PROCINFO embedded branch with relative offset")
>
> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Date:   Wed Mar 18 07:29:32 2015 +0100
>
>     ARM: 8314/1: replace PROCINFO embedded branch with relative offset
>
>     This patch replaces the 'branch to setup()' instructions embedded
>     in the PROCINFO structs with the offset to that setup function
>     relative to the base of the struct. This preserves the position
>     independent nature of that field, but uses a data item rather
>     than an instruction.
>
>     This is mainly done to prevent linker failures on large kernels,
>     where the setup function is out of reach for the branch.
>
>
> Kirkwood uses arch/arm/mm/proc-feroceon.S.
>
> Please can you have this patch either fixed or reverted. Come by
> #mvlinux if you want to chat with us, ask for testing, etc.
>

Apologies for the breakage. Does this fix it?

diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index e494d6d6acbe..92e08bf37aad 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -602,7 +602,6 @@ __\name\()_proc_info:
                PMD_SECT_AP_WRITE | \
                PMD_SECT_AP_READ
        initfn  __feroceon_setup, __\name\()_proc_info
-       .long __feroceon_setup
        .long   cpu_arch_name
        .long   cpu_elf_name
        .long   HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP


Regards,
Ard.
