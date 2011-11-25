From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 25 Nov 2011 11:11:18 +0800
Subject: [PATCH] ARM: w90x900: add common nuc9xx.h
In-Reply-To: <20111124203748.GV9581@n2100.arm.linux.org.uk>
References: <E1RRUQa-0005MI-5C@rmk-PC.arm.linux.org.uk>
 <CAKT61h9v8uVBF3orXOESq8piajzxY4VXCQ7Ox8g96dndGUwoXg@mail.gmail.com>
 <20111124203748.GV9581@n2100.arm.linux.org.uk>
Message-ID: <CAKT61h-0=kdv2wzFrfJyA6zMDaV+Bf4iwrGx4YShm=2KrLDB9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/11/25 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Nov 21, 2011 at 11:56:04AM +0800, Wan ZongShun wrote:
>> 2011/11/19 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> > Rather than having separate extern declarations in nuc9*.h, provide
>> > a common header file containing these definitions.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>
>> Tested-by :Wan Zongshun <mcuos.com@gmail.com>
>
> Thanks.
>
> Here's the follow-on patch for w90x900 for the restart fixups. ?Ack?
>
> 8<=====
> ARM: restart: w90x900: use new restart hook
>
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by :Wan Zongshun <mcuos.com@gmail.com>

Thanks!

> ---
> ?arch/arm/mach-w90x900/cpu.c ? ? ? ? ? ? ? ? | ? 16 ++++++++++++++++
> ?arch/arm/mach-w90x900/include/mach/system.h | ? 17 -----------------
> ?arch/arm/mach-w90x900/mach-nuc910evb.c ? ? ?| ? ?1 +
> ?arch/arm/mach-w90x900/mach-nuc950evb.c ? ? ?| ? ?1 +
> ?arch/arm/mach-w90x900/mach-nuc960evb.c ? ? ?| ? ?1 +
> ?arch/arm/mach-w90x900/nuc9xx.h ? ? ? ? ? ? ?| ? ?1 +
> ?6 files changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
> index 0a235e5..604e1db 100644
> --- a/arch/arm/mach-w90x900/cpu.c
> +++ b/arch/arm/mach-w90x900/cpu.c
> @@ -33,9 +33,11 @@
> ?#include <mach/regs-serial.h>
> ?#include <mach/regs-clock.h>
> ?#include <mach/regs-ebi.h>
> +#include <mach/regs-timer.h>
>
> ?#include "cpu.h"
> ?#include "clock.h"
> +#include "nuc9xx.h"
>
> ?/* Initial IO mappings */
>
> @@ -222,3 +224,17 @@ void __init nuc900_init_clocks(void)
> ? ? ? ?clkdev_add_table(nuc900_clkregs, ARRAY_SIZE(nuc900_clkregs));
> ?}
>
> +#define ? ? ? ?WTCR ? ?(TMR_BA + 0x1C)
> +#define ? ? ? ?WTCLK ? (1 << 10)
> +#define ? ? ? ?WTE ? ? (1 << 7)
> +#define ? ? ? ?WTRE ? ?(1 << 1)
> +
> +void nuc9xx_restart(char mode, const char *cmd)
> +{
> + ? ? ? if (mode == 's') {
> + ? ? ? ? ? ? ? /* Jump into ROM at address 0 */
> + ? ? ? ? ? ? ? soft_restart(0);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? __raw_writel(WTE | WTRE | WTCLK, WTCR);
> + ? ? ? }
> +}
> diff --git a/arch/arm/mach-w90x900/include/mach/system.h b/arch/arm/mach-w90x900/include/mach/system.h
> index 68875a1..001a2f9 100644
> --- a/arch/arm/mach-w90x900/include/mach/system.h
> +++ b/arch/arm/mach-w90x900/include/mach/system.h
> @@ -14,28 +14,11 @@
> ?* (at your option) any later version.
> ?*
> ?*/
> -
> -#include <linux/io.h>
> -#include <asm/proc-fns.h>
> -#include <mach/map.h>
> -#include <mach/regs-timer.h>
> -
> -#define ? ? ? ?WTCR ? ?(TMR_BA + 0x1C)
> -#define ? ? ? ?WTCLK ? (1 << 10)
> -#define ? ? ? ?WTE ? ? (1 << 7)
> -#define ? ? ? ?WTRE ? ?(1 << 1)
> -
> ?static void arch_idle(void)
> ?{
> ?}
>
> ?static void arch_reset(char mode, const char *cmd)
> ?{
> - ? ? ? if (mode == 's') {
> - ? ? ? ? ? ? ? /* Jump into ROM at address 0 */
> - ? ? ? ? ? ? ? soft_restart(0);
> - ? ? ? } else {
> - ? ? ? ? ? ? ? __raw_writel(WTE | WTRE | WTCLK, WTCR);
> - ? ? ? }
> ?}
>
> diff --git a/arch/arm/mach-w90x900/mach-nuc910evb.c b/arch/arm/mach-w90x900/mach-nuc910evb.c
> index 31c1090..b4243e4 100644
> --- a/arch/arm/mach-w90x900/mach-nuc910evb.c
> +++ b/arch/arm/mach-w90x900/mach-nuc910evb.c
> @@ -38,4 +38,5 @@ MACHINE_START(W90P910EVB, "W90P910EVB")
> ? ? ? ?.init_irq ? ? ? = nuc900_init_irq,
> ? ? ? ?.init_machine ? = nuc910evb_init,
> ? ? ? ?.timer ? ? ? ? ?= &nuc900_timer,
> + ? ? ? .restart ? ? ? ?= nuc9xx_restart,
> ?MACHINE_END
> diff --git a/arch/arm/mach-w90x900/mach-nuc950evb.c b/arch/arm/mach-w90x900/mach-nuc950evb.c
> index 4062e55..067d8f9 100644
> --- a/arch/arm/mach-w90x900/mach-nuc950evb.c
> +++ b/arch/arm/mach-w90x900/mach-nuc950evb.c
> @@ -41,4 +41,5 @@ MACHINE_START(W90P950EVB, "W90P950EVB")
> ? ? ? ?.init_irq ? ? ? = nuc900_init_irq,
> ? ? ? ?.init_machine ? = nuc950evb_init,
> ? ? ? ?.timer ? ? ? ? ?= &nuc900_timer,
> + ? ? ? .restart ? ? ? ?= nuc9xx_restart,
> ?MACHINE_END
> diff --git a/arch/arm/mach-w90x900/mach-nuc960evb.c b/arch/arm/mach-w90x900/mach-nuc960evb.c
> index 0ab9995..cbb3adc 100644
> --- a/arch/arm/mach-w90x900/mach-nuc960evb.c
> +++ b/arch/arm/mach-w90x900/mach-nuc960evb.c
> @@ -38,4 +38,5 @@ MACHINE_START(W90N960EVB, "W90N960EVB")
> ? ? ? ?.init_irq ? ? ? = nuc900_init_irq,
> ? ? ? ?.init_machine ? = nuc960evb_init,
> ? ? ? ?.timer ? ? ? ? ?= &nuc900_timer,
> + ? ? ? .restart ? ? ? ?= nuc9xx_restart,
> ?MACHINE_END
> diff --git a/arch/arm/mach-w90x900/nuc9xx.h b/arch/arm/mach-w90x900/nuc9xx.h
> index 847c4f3..91acb40 100644
> --- a/arch/arm/mach-w90x900/nuc9xx.h
> +++ b/arch/arm/mach-w90x900/nuc9xx.h
> @@ -21,3 +21,4 @@ struct sys_timer;
>
> ?extern void nuc900_init_irq(void);
> ?extern struct sys_timer nuc900_timer;
> +extern void nuc9xx_restart(char, const char *);
> --
> 1.7.4.4
>
>
>



-- 
Wan ZongShun.
www.mcuos.com
