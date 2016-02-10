From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Feb 2016 14:46:02 +0000
Subject: [PATCH 3/5] irqchip/gic-v2: Parse and export virtual GIC
 information
In-Reply-To: <56BB46DC.7080202@arm.com>
References: <1454950049-741-1-git-send-email-julien.grall@arm.com>
 <1454950049-741-4-git-send-email-julien.grall@arm.com>
 <20160209204914.GE5171@cbox> <56BB46DC.7080202@arm.com>
Message-ID: <56BB4D2A.1030903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/16 14:19, Julien Grall wrote:
> Hi Christoffer,
> 
> On 09/02/16 20:49, Christoffer Dall wrote:
>>> +static void __init gic_acpi_setup_kvm_info(void)
>>> +{
>>> +	gic_v2_kvm_info.type = GIC_V2;
>>> +
>>> +	gic_v2_kvm_info.maint_irq = acpi_register_gsi(NULL,
>>> +						      acpi_data.maint_irq,
>>> +						      acpi_data.maint_irq_mode,
>>> +						      ACPI_ACTIVE_HIGH);
>>> +	gic_v2_kvm_info.vctrl_base = acpi_data.vctrl_base;
>>> +	if (gic_v2_kvm_info.vctrl_base)
>>> +		gic_v2_kvm_info.vctrl_size = SZ_8K;
>>> +
>>> +	gic_v2_kvm_info.vcpu_base = acpi_data.vcpu_base;
>>> +	if (gic_v2_kvm_info.vcpu_base)
>>> +		gic_v2_kvm_info.vcpu_size = SZ_8K;
>>
>> why are the sizes hard-coded to 8K in this case?
> 
> The MADT only provides the base addresses and not the size. The default 
> value has been chosen based on the GICv2 spec (ARM IHI 0048B.b)
> 	* GICV: See 5.5
> 	* GICH: I can't find again the section about it. But the example 
> bindings in 
> Documents/devicetree/bindings/interrupt-controller/arm,gic.txt uses 8K.
> 
> I will add a comment in the code explaining where the 8K come from.

The GICH size can be found in the GIC400 TRM:

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0471b/CHDBJDCB.html

The first 4kB are banked per CPU, while the next 4kB are exposing all
CPUs, each in a 512 bytes window. We don't give a damn about the second
page, but hey, it is there...

Of course, this is GIC400, not the architecture spec. So maybe
considering a 4kB size would be better, just in case someone is
braindead enough to produce another GICv2 implementation without the
aliases...

	M.
-- 
Jazz is not dead. It just smells funny...
