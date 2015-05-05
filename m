From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 05 May 2015 22:28:21 +0200
Subject: [RFC PATCH 0/9] Add self-probe infrastructure and stacked
 irqdomain support for ACPI based GICv2/3 init
In-Reply-To: <1430833857-30736-1-git-send-email-hanjun.guo@linaro.org>
References: <1430833857-30736-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <10866239.kAOUxUHTHm@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 05, 2015 09:50:48 PM Hanjun Guo wrote:
> This patch set introduce self-probe infrastructure to init IRQ
> controllers and stacked irqdomain support for ACPI based GICv2/3
> init.
> 
> The self-probe infrastructure for ACPI GIC init is similar as
> IRQCHIP_DECLARE() and based on the GIC version support in ACPI
> MADT table.
> 
> We introduce acpi_irq_domain for GICv2/3 core domain to support
> stacked irqdomain, and pass the gsi (global system interrupt) as
> the agument (void *arg) for gic_irq_domain_alloc(), then we can
> alloc virqs via acpi_register_gsi() with stacked irqdomain.
> 
> I already compiled this patch set ok with both ACPI=on/off on
> ARM64 and also compiled ok on x86, tested with GICv2 init on
> FVP model and it boot successfully.
> 
> Next step I would consolidate all the ACPI GIC init into one
> file -- drivers/irqchip/irq-gic-acpi.c, and introduce ITS and
> IORT support.
> 
> please comment on this patchset to see if we are on the right
> direction.
> 
> Hanjun Guo (6):
>   irqchip / gic: Add GIC version support in ACPI MADT
>   irqchip: gic: ACPI: Use IRQCHIP_ACPI_DECLARE to simplify GICv2 init
>     code
>   irqchip / gic: Add stacked irqdomain support for ACPI based GICv2 init
>   ACPI / gsi: Add gsi_mutex to synchronize
>     acpi_register_gsi()/acpi_unregister_gsi()
>   irqchip / GICv3: Add ACPI support for GICv3+ initialization
>   irqchip / GICv3: Add stacked irqdomain support for ACPI based init
> 
> Tomasz Nowicki (3):
>   ACPICA: Introduce GIC version for arm based system
>   ACPI / irqchip: Add self-probe infrastructure to initialize IRQ
>     controller
>   irqchip / GICv3: Refactor gic_of_init() for GICv3 driver
> 
>  arch/arm64/Kconfig                   |   1 +
>  arch/arm64/include/asm/irq.h         |  13 --
>  arch/arm64/kernel/acpi.c             |  25 ----
>  drivers/acpi/Makefile                |   1 +
>  drivers/acpi/gsi.c                   |  39 ++---
>  drivers/acpi/irq.c                   |  40 ++++++
>  drivers/irqchip/Kconfig              |   3 +
>  drivers/irqchip/Makefile             |   1 +
>  drivers/irqchip/irq-gic-acpi.c       | 116 +++++++++++++++
>  drivers/irqchip/irq-gic-v3.c         | 267 ++++++++++++++++++++++++++++-------
>  drivers/irqchip/irq-gic.c            |  38 ++---
>  drivers/irqchip/irqchip.h            |  12 ++
>  include/acpi/actbl1.h                |  17 ++-
>  include/asm-generic/vmlinux.lds.h    |  13 ++
>  include/linux/acpi.h                 |  14 ++
>  include/linux/acpi_irq.h             |   4 +-
>  include/linux/irqchip/arm-gic-acpi.h |  12 +-
>  include/linux/mod_devicetable.h      |   7 +
>  18 files changed, 489 insertions(+), 134 deletions(-)
>  create mode 100644 drivers/acpi/irq.c
>  create mode 100644 drivers/irqchip/irq-gic-acpi.c

What's the connection between this and the Jiang Liu's patchset?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
