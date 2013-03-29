From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 29 Mar 2013 17:37:37 +0900
Subject: [RFC][PATCH 1/3] ARM: shmobile: define PLATFORM_xxx_INFO()
In-Reply-To: <87y5dfewip.wl%kuninori.morimoto.gx@renesas.com>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
 <87y5dfewip.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <CANqRtoRs5bYD52GTOmK5BSGJYVMgBVsm63ZCZORPYti69DipwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Morimoto-san,

Thanks for your patch. Good to see that you're adding support for
external IRQs and the SMSC chip. I would like to merge the actual
hardware support code right away, but it I have some comments on this
patch and I believe you will have to rework patches and resend. Please
see below for more information.

On Fri, Mar 22, 2013 at 4:14 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> platform_device_register_xxx() are needed until
> DT supports of all drivers are completed.
> This PLATFORM_xxx_INFO() macro is useful for it
> and is possible to reduce code.
> This patch put it ot common.h
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/include/mach/common.h |   20 +++++++++++
>  arch/arm/mach-shmobile/setup-r8a7778.c       |   48 +++++++++++---------------
>  2 files changed, 41 insertions(+), 27 deletions(-)

Uhm, there is a certain contradiction between your change log message
and the diffstat. =)

This patch is actually adding lines of code instead of saving lines, no?

> diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
> index 03f73de..6a066a3 100644
> --- a/arch/arm/mach-shmobile/include/mach/common.h
> +++ b/arch/arm/mach-shmobile/include/mach/common.h
> @@ -94,4 +94,24 @@ static inline void __init shmobile_init_late(void)
>         shmobile_cpuidle_init();
>  }
>
> +#define PLATFORM_FULL_INFO(n, i, m)                    \
> +{                                                      \
> +       .parent         = &platform_bus,                \
> +       .name           = n,                            \
> +       .id             = i,                            \
> +       .res            = m ## _resources,              \
> +       .num_res        = ARRAY_SIZE(m ##_resources),   \
> +       .data           = &m ##_platform_data,          \
> +       .size_data      = sizeof(m ## _platform_data),  \
> +}
> +
> +#define PLATFORM_DATA_INFO(n, i, m)                    \
> +{                                                      \
> +       .parent         = &platform_bus,                \
> +       .name           = n,                            \
> +       .id             = i,                            \
> +       .data           = &m ##_platform_data,          \
> +       .size_data      = sizeof(m ## _platform_data),  \
> +}

Thanks for trying to improve the situation, but I must confess that I
don't like this. Basically, if you want to improve something related
to platform device registration then this must to happen on a higher
level like for instance modifying the generic platform device
registration code base. So making this optimization in
mach-shmobile/include/mach/common.h will just lead to mach-shmobile
including special non-standard code that becomes difficult to read for
people. There is no point in being special.

>  #endif /* __ARCH_MACH_COMMON_H */
> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 01c62be..45a1a53 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -44,14 +44,18 @@
>         .irqs           = SCIx_IRQ_MUXED(irq),                  \
>  }
>
> -static struct plat_sci_port scif_platform_data[] = {
> -       SCIF_INFO(0xffe40000, gic_iid(0x66)),
> -       SCIF_INFO(0xffe41000, gic_iid(0x67)),
> -       SCIF_INFO(0xffe42000, gic_iid(0x68)),
> -       SCIF_INFO(0xffe43000, gic_iid(0x69)),
> -       SCIF_INFO(0xffe44000, gic_iid(0x6a)),
> -       SCIF_INFO(0xffe45000, gic_iid(0x6b)),
> -};
> +static struct plat_sci_port scif0_platform_data =
> +       SCIF_INFO(0xffe40000, gic_iid(0x66));
> +static struct plat_sci_port scif1_platform_data =
> +       SCIF_INFO(0xffe41000, gic_iid(0x67));
> +static struct plat_sci_port scif2_platform_data =
> +       SCIF_INFO(0xffe42000, gic_iid(0x68));
> +static struct plat_sci_port scif3_platform_data =
> +       SCIF_INFO(0xffe43000, gic_iid(0x69));
> +static struct plat_sci_port scif4_platform_data =
> +       SCIF_INFO(0xffe44000, gic_iid(0x6a));
> +static struct plat_sci_port scif5_platform_data =
> +       SCIF_INFO(0xffe45000, gic_iid(0x6b));

As you notice, these lines above increase the number of lines of code
in this file. I prefer first of all being standard, and after that
going the other direction to asmaller code base. =)

> -       for (i = 0; i < ARRAY_SIZE(scif_platform_data); i++)
> -               platform_device_register_data(&platform_bus, "sh-sci", i,
> -                                             &scif_platform_data[i],
> -                                             sizeof(struct plat_sci_port));
> -
>         for (i = 0; i < ARRAY_SIZE(platform_devinfo); i++)
>                 platform_device_register_full(&platform_devinfo[i]);

Why do you want to use platform_device_register_full() for all cases
when you instead can use different functions case-by-case?

For instance, you can use platform_device_register_simple() or
platform_device_register_data() or platform_device_register_resndata()
depending on what kind of device you are registering.

So please drop the special macros introduced by this patch.

Next time please consider submitting patches in a different order. I
would prefer the following:
[PATCH 01/03] ARM: shmobile: r8a7778: add r8a7778_init_irq_extpin()
[PATCH 02/03] ARM: shmobile: bockw: add SMSC ethernet support
[PATCH 03/03] ARM: shmobile: define PLATFORM_xxx_INFO()

If you put the cleanup patch as final portion it is easy to compare
saved number of lines. Also, if we disagree about your macro then it
is easy to only merge 1 and 2.

So because of the existing patch order in this series I am afraid I
will have to ask you to resend patch 2/3 and 3/3 without using special
macros like PLATFORM_xxxx_INFO().

Thanks for your help!

/ magnus
