From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 28 May 2012 15:28:20 +0530
Subject: [RFC PATCH 04/11] OMAP: Add early device for system control module
In-Reply-To: <1337934361-1606-5-git-send-email-eduardo.valentin@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-5-git-send-email-eduardo.valentin@ti.com>
Message-ID: <CAMQu2gyVZ8iq3S=WMXNNaw6PtrcggRkoOEOpM9nL-Ngy+SoRfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 1:55 PM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> This is a way to add an early device for system control module.
> the code is also requesting for driver registration and probing.
> Done at early_initcall because at that time, ioremapping is possible.
>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
> ?arch/arm/mach-omap2/devices.c | ? 29 +++++++++++++++++++++++++++++
> ?1 files changed, 29 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 9332673..58cc5c3 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -40,6 +40,35 @@
> ?#define L3_MODULES_MAX_LEN 12
> ?#define L3_MODULES 3
>
> +static struct resource control_resources[] = {
> + ? ? ? [0] = {
> + ? ? ? ? ? ? ? .start ?= 0x4a002000,
> + ? ? ? ? ? ? ? .end ? ?= 0x4a0027ff,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
> + ? ? ? },
> +};
> +static struct platform_device control_device = {
> + ? ? ? .name ? ? ? ? ? = "omap-control-core",
> + ? ? ? .id ? ? ? ? ? ? = 0,
> + ? ? ? .resource ? ? ? = control_resources,
> + ? ? ? .num_resources ?= ARRAY_SIZE(control_resources),
> +};
> +
> +static struct platform_device *early_devices[] __initdata = {
> + ? ? ? &control_device,
> +};
> +
> +static int __init plat_early_device_setup(void)
> +{
> + ? ? ? early_platform_add_devices(early_devices,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?ARRAY_SIZE(early_devices));
> + ? ? ? early_platform_driver_register_all("early_omap_control");
> + ? ? ? early_platform_driver_probe("early_omap_control", 1, false);
> +
> + ? ? ? return 0;
> +}
> +early_initcall(plat_early_device_setup);
> +
> ?static int omap_init_control(void)
> ?{
> ? ? ? ?struct omap_hwmod ? ? ? ? ? ? ? *oh;

Nice !!
Apart from fix from Konstantin and Benoit's DT comment,
patch looks fine to me.

Regards
Santosh
