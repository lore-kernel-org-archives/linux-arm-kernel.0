From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 25 Mar 2013 15:36:46 +0100
Subject: [PATCH 5/6] ARM: ux500: move PRCMU functions into the CPUidle
 driver
In-Reply-To: <201303251411.43356.arnd@arndb.de>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <51505816.1020302@linaro.org>
 <CACRpkdab+iT4m5gDtuH2vYpRQRgTyOho4=s+zj0cEDfxE5g_FQ@mail.gmail.com>
 <201303251411.43356.arnd@arndb.de>
Message-ID: <CACRpkda=FT1cHA=2oZkNcxxB=NvGLbuKia=hHkxSzEBu07CL8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 3:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 25 March 2013, Linus Walleij wrote:
>> On Mon, Mar 25, 2013 at 2:58 PM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>> > On 03/25/2013 02:44 PM, Linus Walleij wrote:
>>
>> >> Shall I put it in <linux/platform_data/arm-ux500-pm.h> or so,
>> >> with the implementation in arch/arm/mach-ux500/pm.c
>> >> or so?
>> >
>> > Wouldn't <asm/pm.h> be better ? So we can have the same header name for
>> > all the drivers, no ?
>>
>> I don't think that works with multiplatform. When building multiple
>> systems our approach is to not let any two header files have the same
>> name.
>>
>> What we did for debug macro for example was to create the <debug/*>
>> namespace, so the old <mach/debug-macro.S> is now <debug/imx.S>,
>> <debug/vt8500.h>, <debug/ux500.h> ... etc.
>>
>> So what would be needed would then rather be <pm/*> in
>> arch/arm/include/pm and under this we would create
>> <pm/ux500.h>.
>>
>> But that require Russell and Arnds/Olofs consent I think,
>> what do you guys say? Other recommendations?
>
> I would first like to understand what contents you actually need to
> have in the header file.

So in this case headers for the PRCMU+GIC code moving out
of the PRCMU driver. These are the functions and the comments
right above them:

/* This function decouple the gic from the prcmu */
prcmu_gic_decouple()

/* This function recouple the gic with the prcmu */
prcmu_gic_recouple()

/*
 * This function checks if there are pending irq on the gic. It only
 * makes sense if the gic has been decoupled before with the
 * db8500_prcmu_gic_decouple function. Disabling an interrupt only
 * disables the forwarding of the interrupt to any CPU interface. It
 * does not prevent the interrupt from changing state, for example
 * becoming pending, or active and pending if it is already
 * active. Hence, we have to check the interrupt is pending *and* is
 * active.
 */
prcmu_gic_pending_irq()

/*
 * This function checks if there are pending interrupt on the
 * prcmu which has been delegated to monitor the irqs with the
 * db8500_prcmu_copy_gic_settings function.
 */
bool prcmu_pending_irq()

/*
 * This function checks if the specified cpu is in in WFI. It's usage
 * makes sense only if the gic is decoupled with the db8500_prcmu_gic_decouple
 * function. Of course passing smp_processor_id() to this function will
 * always return false...
 */
bool prcmu_is_cpu_in_wfi()

/*
 * This function copies the gic SPI settings to the prcmu in order to
 * monitor them and abort/finish the retention/off sequence or state.
 */
int prcmu_copy_gic_settings()

This set of functions are called both for idling and suspend, i.e.
both by the machine-specific cpuidle driver and the machine-specific
suspend code.

They are conceptually coherent functions but messing with both PRCMU
and GIC registers, moving the responsibility of keeping track of the
IRQs back and forth between the GIC and the PRCMU.

Being able to freeze and decouple the GIC and check if a CPU is
in WFI is a ux500-PRCMU-specific pecularity but saves us a lot of
criss-cross IPIs when going to idle or sleep.

Yours,
Linus Walleij
