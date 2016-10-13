From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 13 Oct 2016 15:36:11 -0400
Subject: [PATCH V2 1/3] Revert "ACPI, PCI,
 IRQ: reduce static IRQ array size to 16"
In-Reply-To: <20161013181535.GB21529@localhost>
References: <1475615720-31047-1-git-send-email-okaya@codeaurora.org>
 <1475615720-31047-2-git-send-email-okaya@codeaurora.org>
 <20161012221357.GB15116@localhost>
 <09f93442-89c8-7b2c-467d-d29b857739ff@codeaurora.org>
 <20161013181535.GB21529@localhost>
Message-ID: <498097a5-f75c-d2dd-f134-148b3fb8e1ed@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/2016 2:15 PM, Bjorn Helgaas wrote:
> It seems like the problem is that we removed acpi_penalize_sci_irq(),
> which told us the polarity and trigger mode.  We tried to get that
> information via irq_get_trigger_type(), but that didn't work in this
> case because we use the acpi_irq_get_penalty() path before the SCI is
> registered.
> 
> It makes sense to me to add acpi_penalize_sci_irq() back in, which is
> what patch [3/3] does.
> 
> I don't understand how *this* patch, which basically just increases
> the penalty array size from 16 to 256, helps fix the problem.  It
> seems like this patch should only matter if the SCI were some IRQ
> between 16 and 255.


I see your point. The original code supported 256 interrupts. 

The machine where we had the problem had an SCI interrupt of 11. So,
this patch does not necessarily fix anything for this machine alone.
However, to be safe; I wanted to go back to the old behavior to fix
the SCI issue for all existing platforms.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
