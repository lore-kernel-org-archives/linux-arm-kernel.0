From: govindraj.ti@gmail.com (Govindraj)
Date: Sat, 18 Sep 2010 14:47:22 +0530
Subject: [PATCH 00/11] OMAP: Serial: Add omap-serial driver with platform
	support
In-Reply-To: <87tylorl9i.fsf@deeprootsystems.com>
References: <13965.10.24.255.18.1284739547.squirrel@dbdmail.itg.ti.com>
	<87tylorl9i.fsf@deeprootsystems.com>
Message-ID: <AANLkTik-+RC7y=dJnDdxzrqMFnTzRV-j8s5FtmMy8ZhE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 18, 2010 at 5:11 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> This patch series adds a serial driver to handle uarts on omap platforms.
>> Currenlty omap-uarts are handled with 8250 driver, since updating
>> this driver with omap specific features will over load
>> the 8250 driver with all omap-specific data thus a new driver
>> is added to configure and support features like
>> dma, h/w, s/w flowcontrol for omap-uarts.
>> Also the patch series updates various low level platform specific
>> serial data to support omap-uarts with hwmod framework and adds support
>> for uart4 on OMAP3630.
>
> This series is missing a couple things to work more broadly on all
> boards, specifically 3630-based boards.
>
> First, due to the current UART idle code base, you need to enable all
> OMAP UARTs 36xx. ?Enabling less than all OMAP UARTs will break the
> current idle code. ?As we discussed, the next phase we will move the
> idle management from this serial.c hackery into the omap-serial driver
> iteself. ?Until then, you need to call omap_serial_init() on
> Zoom2/Zoom3. ?Patch below[1]
>
> Also, you previously had a patch that updated omap_uart_idle_init() to
> handle 36xx and specifically UART4. ?Without that, struct
> omap_uart_state is not setup correctly for UART4, and thus cannot be
> properly idled on 3630.

ok fine, I will I incorporate initialize all uarts patch for zoom boards.

Are you referring to this patch?
https://patchwork.kernel.org/patch/108066/

Is this still needed if we have initialized all uarts?
This patch might not needed if we have initialized all uarts right?

>
> Also, it's been a while since I tested this on OMAP2. ?Please re-test on
> OMAP2 with the whole series. ?Also, please report here the other
> platforms this was tested on. ?The final needs to be tested on OMAP2, 3
> and 4 before merge.

Yes Sure,

Just FYI this patch series was also tested on omap2,3,4.

>
>> This patch series is tested on mainline 2.6.36-rc4
>> and has dependencies on:
>>
>> 1) https://patchwork.kernel.org/patch/117148/
>> ? ? ? This patch to support all hwmod data with proper structure name.
>>
>> 2) https://patchwork.kernel.org/patch/117347/
>> ? ? ? This patch is needed to apply omap4 uart hwmods.
>
> Can you rebase this against my pm-core branch, which already has these
> dependencies, as well as several other fixes to the hwmod and PM cores
> that are queued for 2.6.37?
>
> Thanks,
>
> Kevin
>
>> 3) http://marc.info/?l=linux-omap&m=128403141221947&w=2
>> ? ? ? This patch series is needed for omap4430SDP ES2.0 validation.
>>
>>
>> Benoit Cousson (1):
>> ? OMAP4: UART: Add uart1-4 hwmods data for omap4
>>
>> Govindraj.R (6):
>> ? OMAP2: UART: remove set_uart_globals.
>> ? OMAP clock: Add uart4_ick/fck definitions for 3630
>> ? OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
>> ? OMAP3: PM: Add prepare idle and resume idle call for uart4
>> ? serial: Add OMAP high-speed UART driver
>> ? OMAP: SERIAL: Enable omap-serial driver in Kconfig.
>>
>> Kevin Hilman (4):
>> ? OMAP2/3: UART: add omap_hwmod data for UARTs 1-4
>> ? OMAP: UART: omap_device converions, remove implicit 8520 assumptions
>> ? OMAP: UART: don't do automatic bus-level suspend/resume
>> ? OMAP: UART: use non-locking versions of hwmod enable/idle functions
>>
>> ?arch/arm/mach-omap2/Kconfig ? ? ? ? ? ? ? ? ? | ? 11 +-
>> ?arch/arm/mach-omap2/clock3xxx_data.c ? ? ? ? ?| ? 22 +
>> ?arch/arm/mach-omap2/cm-regbits-34xx.h ? ? ? ? | ? ?2 +
>> ?arch/arm/mach-omap2/omap_hwmod_2420_data.c ? ?| ?193 ++++
>> ?arch/arm/mach-omap2/omap_hwmod_2430_data.c ? ?| ?193 ++++
>> ?arch/arm/mach-omap2/omap_hwmod_3xxx_data.c ? ?| ?253 +++++-
>> ?arch/arm/mach-omap2/omap_hwmod_44xx_data.c ? ?| ?235 +++++
>> ?arch/arm/mach-omap2/pm34xx.c ? ? ? ? ? ? ? ? ?| ? 17 +-
>> ?arch/arm/mach-omap2/prcm-common.h ? ? ? ? ? ? | ? ?5 +
>> ?arch/arm/mach-omap2/prm-regbits-34xx.h ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-omap2/serial.c ? ? ? ? ? ? ? ? ?| ?548 +++++-----
>> ?arch/arm/plat-omap/common.c ? ? ? ? ? ? ? ? ? | ? 16 -
>> ?arch/arm/plat-omap/include/plat/common.h ? ? ?| ? ?1 -
>> ?arch/arm/plat-omap/include/plat/dma.h ? ? ? ? | ? ?2 +
>> ?arch/arm/plat-omap/include/plat/irqs.h ? ? ? ?| ? ?2 +
>> ?arch/arm/plat-omap/include/plat/omap-serial.h | ?129 +++
>> ?drivers/serial/Kconfig ? ? ? ? ? ? ? ? ? ? ? ?| ? 27 +
>> ?drivers/serial/Makefile ? ? ? ? ? ? ? ? ? ? ? | ? ?1 +
>> ?drivers/serial/omap-serial.c ? ? ? ? ? ? ? ? ?| 1332 +++++++++++++++++++++++++
>> ?include/linux/serial_core.h ? ? ? ? ? ? ? ? ? | ? ?3 +
>> ?20 files changed, 2699 insertions(+), 294 deletions(-)
>> ?create mode 100644 arch/arm/plat-omap/include/plat/omap-serial.h
>> ?create mode 100644 drivers/serial/omap-serial.c
>
>
> [1]
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index 6b39849..641765a 100644
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -282,4 +282,5 @@ void __init zoom_peripherals_init(void)
> ? ? ? ?omap_i2c_init();
> ? ? ? ?usb_musb_init(&musb_board_data);
> ? ? ? ?enable_board_wakeup_source();
> + ? ? ? omap_serial_init();
> ?}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>



-- 
---
Regards,
Govindraj.R
