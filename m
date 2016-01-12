From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 12 Jan 2016 19:32:32 +0000
Subject: [PATCH v3 1/2] acpi: Fix proper return code for function
 acpi_gsi_to_irq
In-Reply-To: <CAGDN=zYVvU9=Qj8_szqYW3qh7G=phr_Bc_dm8+KVO=yhp=YTVQ@mail.gmail.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
 <1446857519-5908-2-git-send-email-lho@apm.com> <56954D18.1010306@arm.com>
 <CAGDN=zYVvU9=Qj8_szqYW3qh7G=phr_Bc_dm8+KVO=yhp=YTVQ@mail.gmail.com>
Message-ID: <569554D0.2000406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/16 19:13, Tuan Phan wrote:
> On Tue, Jan 12, 2016 at 10:59 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 07/11/15 00:51, Loc Ho wrote:
>>> The function acpi_gsi_to_irq should returns 0 on success as upper function
>>> caller expect an 0 for sucesss.
>>
>> I have to ask: why do you feel the need to change an API that behaves
>> like the rest of the IRQ allocation functions (at least when it comes to
>> its return value)?
>>
>> 0 is defined as an invalid interrupt, and I wish it stayed that way.
> 
> The upper caller expects 0 for success.
> In drivers/acpi/apei/ghes.c:
>         case ACPI_HEST_NOTIFY_EXTERNAL:
>                 /* External interrupt vector is GSI */
>                 rc = acpi_gsi_to_irq(generic->notify.vector, &ghes->irq);
>                 if (rc) {
>                         pr_err(GHES_PFX "Failed to map GSI to IRQ for
> generic hardware error source: %d\n",
>                                generic->header.source_id);
>                         goto err_edac_unreg;
>                 }
> 
> Also the implementation of acpi_gsi_to_irq for X86 in
> arch/x86/kernel/acpi/boot.c also return 0 for success and -1 for
> failure.
> int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
> {
>         int rc, irq, trigger, polarity;
> 
>         if (acpi_irq_model == ACPI_IRQ_MODEL_PIC) {
>                 *irqp = gsi;
>                 return 0;
>         }
> 
>         rc = acpi_get_override_irq(gsi, &trigger, &polarity);
>         if (rc == 0) {
>                 trigger = trigger ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
>                 polarity = polarity ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>                 irq = acpi_register_gsi(NULL, gsi, trigger, polarity);
>                 if (irq >= 0) {
>                         *irqp = irq;
>                         return 0;
>                 }
>         }
> 
>         return -1;
> }
> 

Right. In which case please document this properly in the commit log.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
