From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 10 Jun 2015 15:58:56 +0200
Subject: IRQFD support with GICv3 ITS (WAS: RE: [PATCH 00/13] arm64: KVM:
 GICv3 ITS emulation)
In-Reply-To: <042601d0a357$d3cec4d0$7b6c4e70$@samsung.com>
References: <042601d0a357$d3cec4d0$7b6c4e70$@samsung.com>
Message-ID: <557842A0.9070503@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 06/10/2015 10:31 AM, Pavel Fedin wrote:
>  Hello guys!
> 
>> Currently on ARM, irqfd supports routing an host eventfd towards a
>> virtual SPI:
>> eventfd -> vSPI = gsi+32
>> parameters of irqfd are the eventfd and the gsi.
> 
>  Yes, but this works only with GICv2m, because it actually turns MSI data into SPI number.
> ITS works in a completely different way.
> 
>> 2) now we have virtual msi injection, we could use msi routing to inject
>> virtual LPI's. But is it what you need for your qemu integration?
> 
>  Actually this is what i wanted to discuss here...
>  I have studied a little bit IRQ routing mechanism... And it comes to a question what is
> 'GSI'. As far as i could understand, on x86 GSI is a completely virtual entity, which can
> be tied either to irqchip's pin (physical IRQ) or MSI event. There is totally no
> correspondence between GSI numbers and guest IRQ numbers. GSIs are just allocated by the
> userspace starting from 0 and on. Is my understanding correct?
Well I think as long as you use irqchip routing, gsi is not random. When
looking at arch/x86/kvm/irq_comm.c and in kvm_set_routing_entry you can
see there is an offset applied on the gsi and irqchip/pin depending on
type of irqchip (pic_master, pic_slave, ioapic). originally done by
BIOS? This is the default routing. Now in qemu the irqchip routing
entries are built by kvm_irqchip_add_irq_route in hw/intc/openpic_kvm.c,
hw/i386/kvm/ioapic.c, ... and then committed.

When looking at MSI routing and qemu integration, in case
kvm_gsi_direct_mapping is NOT used, kvm_irqchp_get_virq indeed finds out
a gsi belonging to the gsi range and not mapped with irqchip entries.

if kvm_gsi_direct_mapping is used, an irqchip mapped gsi is used
instead. At least this is my understanding

>  On ARM, i see, completely different approach is used. For KVM_IRQ_LINE ioctl GSI is
> actually a raw GIC IRQ number plus some extra bits for target and type. For KVM_IRQFD with
> GICv2m GSI is actually SPI number (starting from zero, so that IRQ = GSI + 32).
>  First of all, i would say that we already have an inconsistence in ARM API. The same
> thing called GSI has two different meanings for different functions.
well that's true. This avoided to have ARM archi specific adaptations
for VFIO and MMIO VHOST-NET proto at that time. Now with the MSI advent,
those adaptations becomes needed anyway. Also we concluded it was not
meaningful to inject PPIs. gsi irqfd argument directly matches the IRQ
number found in guest device tree.

>  I think it would be a bad idea to introduce a third, separate meaning for MSIs. However,
> this is what we could do:
> 
>  Approach 1: GICv2m way.
>  We could add one more IOCTL which would decode MSI data into IRQ (in our case it's LPI)
> number. What it would return is LPI - 32, to keep in line with existing convention.
>  Pros: does not bring any more inconsistence into KVM API.
>  Cons: requires adding one more IOCTL and one more MSI handling mechanism. Isn't there too
> many of them already?

indeed in newly added qemu kvm-all.c kvm_arch_msi_data_to_gsi we could
call a new ioctl that translates the data + deviceid? into an LPI and
program irqfd with that LPI. This is done once when setting irqfd up.
This also means extending irqfd support to lpi injection, gsi being the
LPI index if gsi >= 8192. in that case we continue using
kvm_gsi_direct_mapping and gsi still is an IRQ index.
> 
>  Approach 2: IRQ routing.
>  We could implement MSI routing using virtual GSI numbers. In order to stay compatible
> with what we have, we could say that GSI numbers below 8192 are SPI GSIs, and everything
> starting from 8192 is MSI.
I think the gsi can be considered as an index:
0 - 1020: SPI index
>= 8192: LPI index
 Then we could use KVM_SET_GSI_ROUTING ioctl to assign these
> GSIs to actual MSIs which then will go full-cycle through ITS.
>  Pros: Does not introduce any new APIs.
>  Cons:
>     - Introduces third meaning for GSI on ARM.
>     - Slower than approach 1 because in that case every interrupt is pre-translated while
> here we engage ITS every time.

KVM GSI routing, even if only used for MSI routing then mandates to
build entries for non MSI IRQs, using irqchip routing entries. Then you
draw the irqchip.c kvm_irq_routing_table
chip[KVM_NR_IRQCHIPS][KVM_IRQCHIP_NUM_PINS] static allocation issue. I
guess this code would need to be revisited to accomodate large space and
variable pin number of GIC.

Hope it helps

Best Regards

Eric

> 
>  Personally i have already tried approach 1 and i can say that it works. There is no
> problem with target specification because current ITS code stores everything in a single
> bunch so that i anyway have to locate a particular ITTE corresponding to an LPI and get
> collection ID from there. However, yes, i agree, this approach has the same performance
> drawback as my suggested approach 2.
> 
>  Any thoughts / ideas ?
> 
> Kind regards,
> Pavel Fedin
> Expert Engineer
> Samsung Electronics Research center Russia
> 
> 
