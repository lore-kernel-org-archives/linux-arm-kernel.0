From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 15 Nov 2015 22:14:29 +0200
Subject: [PATCH V3] acpi: add support for extended IRQ to PCI link
In-Reply-To: <1447617653-29743-1-git-send-email-okaya@codeaurora.org>
References: <1447617653-29743-1-git-send-email-okaya@codeaurora.org>
Message-ID: <CAHp75VeKLG2yVhHqSFixmo+jvNG=9tLk5pBnGjbT6660dy694g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 15, 2015 at 10:00 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> The ACPI compiler uses the extended format when used
> interrupt numbers are greater than 256. The PCI link code
> currently only supports simple interrupt format. The IRQ
> numbers are represented using 32 bits when extended IRQ
> syntax. This patch changes the interrupt number type to
> 32 bits and places an upper limit of 1020 as possible
> interrupt id.
>
> 1020 is the maximum interrupt ID that can be assigned to
> an ARM SPI interrupt according to ARM architecture.
>
> Additional checks have been placed to prevent out of bounds
> writes.

One comment below.

> @@ -541,14 +547,16 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>         else
>                 irq = link->irq.possible[link->irq.possible_count - 1];
>
> -       if (acpi_irq_balance || !link->irq.active) {
> +       if ((acpi_irq_balance || !link->irq.active) && (irq < ACPI_MAX_IRQS)) {
>                 /*
>                  * Select the best IRQ.  This is done in reverse to promote
>                  * the use of IRQs 9, 10, 11, and >15.
>                  */
> -               for (i = (link->irq.possible_count - 1); i >= 0; i--) {
> -                       if (acpi_irq_penalty[irq] >
> -                           acpi_irq_penalty[link->irq.possible[i]])
> +               i = link->irq.possible_count;
> +               while (--i) {

Actually it should be (--i >= 0). Sorry if I misled you.

> +                       if ((link->irq.possible[i] < ACPI_MAX_IRQS) &&
> +                           (acpi_irq_penalty[irq] >
> +                           acpi_irq_penalty[link->irq.possible[i]]))
>                                 irq = link->irq.possible[i];
>                 }
>         }


-- 
With Best Regards,
Andy Shevchenko
