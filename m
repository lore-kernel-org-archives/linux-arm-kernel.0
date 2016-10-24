From: net147@gmail.com (Jonathan Liu)
Date: Mon, 24 Oct 2016 15:46:27 +1100
Subject: [PATCH V5 1/3] ACPI, PCI, IRQ: assign ISA IRQ directly during
 early boot stages
In-Reply-To: <1477283492-26657-2-git-send-email-okaya@codeaurora.org>
References: <1477283492-26657-1-git-send-email-okaya@codeaurora.org>
 <1477283492-26657-2-git-send-email-okaya@codeaurora.org>
Message-ID: <CANwerB3nRjFZ_2VKT6jf3T+ytwjkWCXvgUnmNg9P_-99kh_+xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 October 2016 at 15:31, Sinan Kaya <okaya@codeaurora.org> wrote:
> We do not want to store the SCI penalty in the acpi_isa_irq_penalty[]
> table because acpi_isa_irq_penalty[] only holds ISA IRQ penalties and
> there's no guarantee that the SCI is an ISA IRQ.  We add in the SCI
> penalty as a special case in acpi_irq_get_penalty().
>
> But if we called acpi_penalize_isa_irq() or acpi_irq_penalty_update()
> for an SCI that happened to be an ISA IRQ, they stored the SCI
> penalty (part of the acpi_irq_get_penalty() return value) in
> acpi_isa_irq_penalty[].  Subsequent calls to acpi_irq_get_penalty()
> returned a penalty that included *two* SCI penalties.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/acpi/pci_link.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index c983bf7..6229b02 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -849,7 +849,7 @@ static int __init acpi_irq_penalty_update(char *str, int used)
>                         continue;
>
>                 if (used)
> -                       new_penalty = acpi_irq_get_penalty(irq) +
> +                       new_penalty = acpi_isa_irq_penalty[irq] +
>                                         PIRQ_PENALTY_ISA_USED;
>                 else
>                         new_penalty = 0;
> @@ -871,7 +871,7 @@ static int __init acpi_irq_penalty_update(char *str, int used)
>  void acpi_penalize_isa_irq(int irq, int active)
>  {
>         if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
> -               acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
> +               acpi_isa_irq_penalty[irq] +=
>                   (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
>  }
>
> --
> 1.9.1
>

This series fixes one or more network adapters not working in Linux
32-bit x86 guest running inside VirtualBox if I have 4 network
adapters enabled.
The following message no longer appears in the kernel log:
ACPI: No IRQ available for PCI Interrupt Link [LNKD]. Try pci=noacpi or acpi=off

Tested-by: Jonathan Liu <net147@gmail.com>
