From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 9 Nov 2011 18:00:20 +0530
Subject: [PATCHv4 07/13] ARM: s3c64xx: convert to MULTI_IRQ_HANDLER
In-Reply-To: <20111109115406.GB4253@totoro>
References: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
 <1320369010-23428-8-git-send-email-jamie@jamieiles.com>
 <CAJuYYwRPoFDUhtcVLT_rj4c9whJWVXyQ7tcaK3O_G3X9SYf-cw@mail.gmail.com>
 <20111109115406.GB4253@totoro>
Message-ID: <CAJuYYwQK-V0AYcayUdXy+SCAyTYbH6vJrn=+m5LGy6PSxP0Vzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 November 2011 17:24, Jamie Iles <jamie@jamieiles.com> wrote:
> On Wed, Nov 09, 2011 at 04:55:06PM +0530, Thomas Abraham wrote:
>> Hi Jamie,
>>
>> On 4 November 2011 06:40, Jamie Iles <jamie@jamieiles.com> wrote:
>> > Now that there is a generic IRQ handler for multiple VIC devices use it
>> > for s3c64xx to help building multi platform kernels.
>> >
>> > Cc: Ben Dooks <ben-linux@fluff.org>
>> > Signed-off-by: Jamie Iles <jamie@jamieiles.com>
>> > ---
>> > ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?1 +
>> > ?arch/arm/mach-s3c64xx/include/mach/entry-macro.S | ? ?7 ++++---
>> > ?arch/arm/mach-s3c64xx/mach-anw6410.c ? ? ? ? ? ? | ? ?2 ++
>> > ?arch/arm/mach-s3c64xx/mach-crag6410.c ? ? ? ? ? ?| ? ?2 ++
>> > ?arch/arm/mach-s3c64xx/mach-hmt.c ? ? ? ? ? ? ? ? | ? ?2 ++
>> > ?arch/arm/mach-s3c64xx/mach-mini6410.c ? ? ? ? ? ?| ? ?2 ++
>> > ?arch/arm/mach-s3c64xx/mach-ncp.c ? ? ? ? ? ? ? ? | ? ?2 ++
>> > ?arch/arm/mach-s3c64xx/mach-real6410.c ? ? ? ? ? ?| ? ?2 ++
>> > ?arch/arm/mach-s3c64xx/mach-smartq5.c ? ? ? ? ? ? | ? ?2 ++
>> > ?arch/arm/mach-s3c64xx/mach-smartq7.c ? ? ? ? ? ? | ? ?2 ++
>> > ?arch/arm/mach-s3c64xx/mach-smdk6400.c ? ? ? ? ? ?| ? ?2 ++
>> > ?arch/arm/mach-s3c64xx/mach-smdk6410.c ? ? ? ? ? ?| ? ?2 ++
>> > ?12 files changed, 25 insertions(+), 3 deletions(-)
>> >
>>
>> I have tested this patch series on smdk6410 board (s3c64xx) using the
>> following repositorty and branch
>>
>> https://github.com/jamieiles/linux-2.6-ji.git ?branch: vic-dt
>>
>> There is a crash while booting. Am I using the right tree and branch?
>> The following is the boot log. Is there any other config option to be
>> enabled?
>
> Hmm, could you please try with the patch below applied?
>
> Rob, I'm not sure if this is the best fix. ?The alternatives I can think
> of would be to always export irq_domain_simple_ops even if
> !CONFIG_OF_IRQ but not set .dt_translate or provide a generic
> irq_domain_null_ops.
>
> Jamie
>
> 8<----
>
> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
> index 8c5f4b0..9a5fb9e 100644
> --- a/arch/arm/common/vic.c
> +++ b/arch/arm/common/vic.c
> @@ -163,6 +163,10 @@ static int __init vic_pm_init(void)
> ?late_initcall(vic_pm_init);
> ?#endif /* CONFIG_PM */
>
> +#ifndef CONFIG_OF_IRQ
> +static const struct irq_domain_ops vic_domain_null_ops;
> +#endif /* !CONFIG_OF_IRQ */
> +
> ?/**
> ?* vic_register() - Register a VIC.
> ?* @base: The base address of the VIC.
> @@ -197,6 +201,8 @@ static void __init vic_register(void __iomem *base, unsigned int irq,
> ?#ifdef CONFIG_OF_IRQ
> ? ? ? ?v->domain.of_node = of_node_get(node);
> ? ? ? ?v->domain.ops = &irq_domain_simple_ops;
> +#else /* CONFIG_OF_IRQ */
> + ? ? ? v->domain.ops = &vic_domain_null_ops;
> ?#endif /* CONFIG_OF */
> ? ? ? ?irq_domain_add(&v->domain);
> ?}
>

This patch solves the issue and both smdk6410 and smdkv210 works fine.

Thanks,
Thomas.
