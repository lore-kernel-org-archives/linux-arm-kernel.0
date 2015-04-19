From: dhdang@apm.com (Duc Dang)
Date: Sun, 19 Apr 2015 11:40:09 -0700
Subject: [PATCH v4 1/4] PCI: X-Gene: Add the APM X-Gene v1 PCIe MSI/MSIX
 termination driver
In-Reply-To: <2306642.JeuMKoBEGq@wuerfel>
References: <cover.1429263201.git.dhdang@apm.com>
 <5160bc222361ff36cc6e72ca14358c5dee8c7548.1429263201.git.dhdang@apm.com>
 <2306642.JeuMKoBEGq@wuerfel>
Message-ID: <CADaLNDn_U_VKBg-ve+X_Ovvzi7TZZJkPotCTKiWjfvANXqsSPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 17, 2015 at 7:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 17 April 2015 02:50:07 Duc Dang wrote:
>> +
>> +       /*
>> +        * MSIINTn (n is 0..F) indicates if there is a pending MSI interrupt
>> +        * If bit x of this register is set (x is 0..7), one or more interupts
>> +        * corresponding to MSInIRx is set.
>> +        */
>> +       grp_select = readl(xgene_msi->msi_regs + MSI_INT0 + (msi_grp << 16));
>> +       while (grp_select) {
>> +               msir_index = ffs(grp_select) - 1;
>> +               /*
>> +                * Calculate MSInIRx address to read to check for interrupts
>> +                * (refer to termination address and data assignment
>> +                * described in xgene_compose_msi_msg function)
>> +                */
>> +               msir_reg = (msi_grp << 19) + (msir_index << 16);
>> +               msir_val = readl(xgene_msi->msi_regs + MSI_IR0 + msir_reg);
>> +               while (msir_val) {
>> +                       intr_index = ffs(msir_val) - 1;
>> +                       /*
>> +                        * Calculate MSI vector number (refer to the termination
>> +                        * address and data assignment described in
>> +                        * xgene_compose_msi_msg function)
>> +                        */
>> +                       hw_irq = (((msir_index * IRQS_PER_IDX) + intr_index) *
>> +                                NR_HW_IRQS) + msi_grp;
>> +                       virq = irq_find_mapping(xgene_msi->domain, hw_irq);
>> +                       if (virq != 0)
>> +                               generic_handle_irq(virq);
>> +                       msir_val &= ~(1 << intr_index);
>> +                       processed++;
>> +               }
>> +               grp_select &= ~(1 << msir_index);
>> +       }
>>
>
> As the MSI is forwarded to the GIC here, how do you maintain ordering
> between DMA data getting forwarded from the PCI host bridge to RAM
> with regard to the MSI handler getting entered from this code?

When device perform a DMA transfer, the order of PCIE inbound requests
will be like this:
1. DMA data get transferred via PCIe inbound request
2. After devices issue DMA transfer request, the device fires an MSI
interrupt by issuing another inbound write to write MSI data to MSI
termination address.

As these 2 requests are transferred via PCIe bus in order, the DMA
data will be all in DDR before the MSI data hit the termination
address to trigger the MSI handler in interrupt handler code.
>
>         Arnd
Regards,
Duc Dang.
