From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 28 Apr 2015 12:05:37 +0200
Subject: [REGRESSION?] ARM: 7677/1: LPAE: Fix mapping in alloc_init_section
 for unaligned addresses  (was Re: Memory size unaligned to section boundary)
In-Reply-To: <a865bd68d706f8c4c9e82a374ff6adc4@agner.ch>
References: <a865bd68d706f8c4c9e82a374ff6adc4@agner.ch>
Message-ID: <553F5B71.8030309@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On 23-04-15 15:19, Stefan Agner wrote:
> Hi,
>
> It seems to me that I hit an issue in low memory mapping (map_lowmem).
> I'm using a custom memory size, which leads to an freeze on Linux 4.0
> and also with Linus master on two tested ARMv7-A SoC's (Freescale Vybrid
> and NVIDIA Tegra 3):
>
> With mem=259744K
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.0.0-00189-ga4d2a4c3-dirty
> (ags at trochilidae) (gcc version 4.8.3 20140401 (prerelease) (Linaro GCC
> 4.8-2014.04) ) #506 Thu Apr 23 14:13:21 CEST 2015
> [    0.000000] CPU: ARMv7 Processor [410fc051] revision 1 (ARMv7),
> cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
> instruction cache
> [    0.000000] Machine model: Toradex Colibri VF61 on Colibri Evaluation
> Board
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] cma: Reserved 16 MiB at 0x8e400000
> [    0.000000] Memory policy: Data cache writeback
> <freeze>
>
> I dug a bit more into that, and it unveiled that when creating the
> mapping for the non-kernel_x part (if (kernel_x_end < end) in
> map_lowmem), the unaligned section at the end leads to the freeze. In
> alloc_init_pmd, if the memory end is section unaligned, alloc_init_pte
> gets called which allocates a PTE outside of the initialized region (in
> early_alloc_aligned). The system freezes at the call of memset in
> early_alloc_aligned function.
>
> With some debug print, this can be better illustrated:
> [    0.000000] pgd 800063f0, addr 8fc00000, end 8fda8000, next 8fda8000
> [    0.000000] pud 800063f0, addr 8fc00000, end 8fda8000, next 8fda8000
> [    0.000000] pmd 800063f0, addr 8fc00000, next 8fda8000
>                           => actual end of memory ^^^^^^^^
> [    0.000000] alloc_init_pte
> [    0.000000] set_pte_ext, pte 00000000, addr 8fc00000, end 8fda8000
> [    0.000000] early_pte_alloc
> [    0.000000] early_alloc_aligned, 00001000, ptr 8fcff000, align
> 00001000
>       => PTE allocated outside of initialized area ^^^^^^^^
>
> It seems that memory gets allocation in the last section. When the last
> section was in the previous PMD, the allocation works, however if the
> last section is within the same PMD, the allocation ends up in the
> non-initialized area. So:
>
> In other words, sizes which end in a upper part of the 2MB sized PMD
> fail, while sizes in the lower part of a PMD work.
> 0xFF80000 => fails (mem=261632K)
> 0xFE80000 => works (mem=260608K)
> 0xFD80000 => fails (mem=261632K)
> ...
>
> While I understand the reason for the freeze, I don't know to properly
> fix it. It looks to me that in alloc_init_pmd, we should use
> __map_init_section first to map the last aligned section, before calling
> alloc_init_pte on the non aligned section.
>
> Background: I tried to reuse the boot loader part of the simplefb
> implementation for sunxi. It decreases memory size by the size of the
> framebuffer. Hence the actually memory size can be unaligned, depending
> on the display size used. In the case at hand, a framebuffer of the size
> 800x600 worked while 1024x600 did not work... The implementation uses
> device tree to report the memory size, but the kernel arguments show the
> same behavior.
>
> Maybe a regression of e651eab0af ("ARM: 7677/1: LPAE: Fix mapping in
> alloc_init_section for unaligned addresses"). I currently do not have a
> platform at hand which works on that Linux version out of the box.

I'm seeing this to an Allwinner Cortex A7 based SoCs, specifically
on tablets with a 1024x600 lcd screen it seems that shaving exactly the
amount of memory needed for a 32bpp 1024x600 framebuffer of from the
top of memory triggers this.

Regards,

Hans
