From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Jun 2018 10:17:57 +0100
Subject: [PATCH 3/5] arm64/kernel: jump_label: switch to relative
 references
In-Reply-To: <20180627160604.8154-4-ard.biesheuvel@linaro.org>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-4-ard.biesheuvel@linaro.org>
Message-ID: <20180628091757.GA10751@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 06:06:02PM +0200, Ard Biesheuvel wrote:
> On a randomly chosen distro kernel build for arm64, vmlinux.o shows the
> following sections, containing jump label entries, and the associated
> RELA relocation records, respectively:
> 
>   ...
>   [38088] __jump_table      PROGBITS         0000000000000000  00e19f30
>        000000000002ea10  0000000000000000  WA       0     0     8
>   [38089] .rela__jump_table RELA             0000000000000000  01fd8bb0
>        000000000008be30  0000000000000018   I      38178   38088     8
>   ...
> 
> In other words, we have 190 KB worth of 'struct jump_entry' instances,
> and 573 KB worth of RELA entries to relocate each entry's code, target
> and key members. This means the RELA section occupies 10% of the .init
> segment, and the two sections combined represent 5% of vmlinux's entire
> memory footprint.
> 
> So let's switch from 64-bit absolute references to 32-bit relative
> references: this reduces the size of the __jump_table by 50%, and gets
> rid of the RELA section entirely.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/Kconfig                  |  1 +
>  arch/arm64/include/asm/jump_label.h | 16 ++++------------
>  arch/arm64/kernel/jump_label.c      |  6 +++---
>  3 files changed, 8 insertions(+), 15 deletions(-)

Looks good, cheers:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
