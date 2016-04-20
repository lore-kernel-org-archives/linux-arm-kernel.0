From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 20 Apr 2016 11:43:30 +0200
Subject: SoCFPGA with CONFIG_THUMB2_KERNEL boot error
In-Reply-To: <CAKv+Gu8_hZvY1TK=D3bhwy6F2UW1kSeSGyRciU5wVQPHy0m7LA@mail.gmail.com>
References: <20160419140220.GA9503@pengutronix.de>
 <20160420092516.GA21732@e103592.cambridge.arm.com>
 <CAKv+Gu8_hZvY1TK=D3bhwy6F2UW1kSeSGyRciU5wVQPHy0m7LA@mail.gmail.com>
Message-ID: <CAKv+Gu9rzxtw2i1QJAU0C-y4Lmh6KDWH0p+TYNHsndr-6c11zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(replying to self)

On 20 April 2016 at 11:39, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> (+ Arnd)
>
> On 20 April 2016 at 11:25, Dave Martin <Dave.Martin@arm.com> wrote:
>> On Tue, Apr 19, 2016 at 04:02:20PM +0200, Steffen Trumtrar wrote:
>>> Hi!
>>>
>>> According to kernelci.org (and validating on my own hardware), the current
>>> socfpga mainline kernel has an issue with CONFIG_THUMB2_KERNEL enabled.
>>>
>>> https://storage.kernelci.org/mainline/v4.6-rc4-11-g12566cc35d0e/arm-multi_v7_defconfig/lab-khilman/boot-socfpga_cyclone5_de0_sockit.html
>>>
>>> vs
>>>
>>> https://storage.kernelci.org/mainline/v4.6-rc4-11-g12566cc35d0e/arm-multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y/lab-khilman/boot-socfpga_cyclone5_de0_sockit.html
>>>
>>> Both boot successfully, but notice that the board fails to bring up CPU1 if
>>> thumb2 support is enabled.
>>>
>>> Any ideas why this might be happening?
>>

Actually, this looks like a problem with the secondary entry point to
me. Could you try this?

diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
index 07945748b571..b56c81340a85 100644
--- a/arch/arm/mach-socfpga/platsmp.c
+++ b/arch/arm/mach-socfpga/platsmp.c
@@ -40,7 +40,7 @@ static int socfpga_boot_secondary(unsigned int cpu,
struct task_struct *idle)

                memcpy(phys_to_virt(0), &secondary_trampoline, trampoline_size);

-               writel(virt_to_phys(secondary_startup),
+               writel(virt_to_phys(secondary_startup_arm),
                       sys_manager_base_addr + (socfpga_cpu1start_addr
& 0x000000ff));

                flush_cache_all();
