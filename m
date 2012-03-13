From: charu@ti.com (Varadarajan, Charulatha)
Date: Tue, 13 Mar 2012 13:51:41 +0530
Subject: [PATCH v2 5/5] ARM: OMAP2+: clean up some cppcheck warnings
In-Reply-To: <alpine.DEB.2.00.1203130211300.22211@utopia.booyaka.com>
References: <20120312224006.4103.29464.stgit@dusk>
 <20120312224257.4103.11096.stgit@dusk>
 <alpine.DEB.2.00.1203130211300.22211@utopia.booyaka.com>
Message-ID: <CA+HSevoVd-pU968DxMsYtHw58gUid9pAyY8gp1u1NdOc3orTzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 13:42, Paul Walmsley <paul@pwsan.com> wrote:
>
>
> Resolve some warnings identified by cppcheck in arch/arm/mach-omap2:
>
> ? ?[arch/arm/mach-omap2/usb-tusb6010.c:129]: (style) Checking if unsigned
> variable 'tmp' is less than zero.
> ? ?[arch/arm/mach-omap2/prm_common.c:241]: (error) Possible null pointer
> dereference: irq_setup - otherwise it is redundant to check if irq_setup is
> null at line 247
> ? ?[arch/arm/mach-omap2/pm34xx.c:790]: (style) Variable 'per_clkdm' is
> assigned a value that is never used
> ? ?[arch/arm/mach-omap2/pm34xx.c:790]: (style) Variable 'core_clkdm' is
> assigned a value that is never used
> ? ?[arch/arm/mach-omap2/pm24xx.c:185]: (style) Variable 'only_idle' is
> assigned a value that is never used
> ? ?[arch/arm/mach-omap2/mux.c:254]: (error) Possible null pointer
> dereference: mux
> ? ?[arch/arm/mach-omap2/mux.c:258]: (error) Possible null pointer
> dereference: mux
> ? ?[arch/arm/mach-omap2/gpmc-onenand.c:178]: (style) Variable 'tick_ns' is
> assigned a value that is never used
> ? ?[arch/arm/mach-omap2/gpio.c:56]: (error) Possible null pointer
> dereference: pdata - otherwise it is redundant to check if pdata is null at
> line 57
> ? ?[arch/arm/mach-omap2/devices.c:45]: (style) Variable 'l' is assigned a
> value that is never used
> ? ?[arch/arm/mach-omap2/board-am3517evm.c:134]: (style) Variable 'regval'
> is assigned a value that is never used
>
> Some of them are pretty good catches, such the gpio.c:56 and
> usb-tusb6010.c:129.
>
> Thanks to Jarkko Nikula for some comments on the sscanf() warnings.
> It seems that the kernel sscanf() ignores the field width anyway for the
> %d format, so those changes have been dropped from this second version.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Cc: Charulatha Varadarajan <charu@ti.com>
> ---
> ?arch/arm/mach-omap2/board-am3517evm.c | ? ?6 +-----
> ?arch/arm/mach-omap2/board-omap3evm.c ?| ? ?8 ++++----
> ?arch/arm/mach-omap2/devices.c ? ? ? ? | ? ?3 +--
> ?arch/arm/mach-omap2/gpio.c ? ? ? ? ? ?| ? ?2 +-
> ?arch/arm/mach-omap2/gpmc-onenand.c ? ?| ? ?3 +--
> ?arch/arm/mach-omap2/mux.c ? ? ? ? ? ? | ? ?2 +-
> ?arch/arm/mach-omap2/pm24xx.c ? ? ? ? ?| ? ?3 ---
> ?arch/arm/mach-omap2/pm34xx.c ? ? ? ? ?| ? ?4 +---
> ?arch/arm/mach-omap2/prm_common.c ? ? ?| ? ?4 +++-
> ?arch/arm/mach-omap2/usb-tusb6010.c ? ?| ? ?2 +-
> ?10 files changed, 14 insertions(+), 23 deletions(-)
>

[snip]

> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 8cbfbc2..2803ff8 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -54,7 +54,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh,
> void *unused)
> ? ? ? ?pdata->virtual_irq_start = IH_GPIO_BASE + 32 * (id - 1);
>
> ? ? ? ?pdata->regs = kzalloc(sizeof(struct omap_gpio_reg_offs),
> GFP_KERNEL);
> - ? ? ? if (!pdata) {
> + ? ? ? if (!pdata->regs) {
> ? ? ? ? ? ? ? ?pr_err("gpio%d: Memory allocation failed\n", id);
> ? ? ? ? ? ? ? ?return -ENOMEM;
> ? ? ? ?}

Reviewed-by: Charulatha Varadarajan <charu@ti.com>
