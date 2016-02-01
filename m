From: will.deacon@arm.com (Will Deacon)
Date: Mon, 1 Feb 2016 14:03:51 +0000
Subject: [PATCH 00/10] KVM PCIe/MSI passthrough on ARM/ARM64
In-Reply-To: <56ABD8E0.6080409@linaro.org>
References: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
 <1454017899.23148.0.camel@redhat.com> <56AB78B1.2030202@linaro.org>
 <1454096004.9301.1.camel@redhat.com> <56ABD8E0.6080409@linaro.org>
Message-ID: <20160201140351.GE6828@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 10:25:52PM +0100, Eric Auger wrote:
> On 01/29/2016 08:33 PM, Alex Williamson wrote:
> >>> We know that x86 handles MSI vectors specially, so there is some
> >>> hardware that helps the situation.  It's not just that x86 has a fixed
> >>> range for MSI, it's how it manages that range when interrupt remapping
> >>> hardware is enabled.  A device table indexed by source-ID references a
> >>> per device table indexed by data from the MSI write itself.  So we get
> >>> much, much finer granularity,
> >> About the granularity, I think ARM GICv3 now provides a similar
> >> capability with GICv3 ITS (interrupt translation service). Along with
> >> the MSI MSG write transaction, the device outputs a DeviceID conveyed on
> >> the bus. This DeviceID (~ your source-ID) enables to index a device
> >> table. The entry in the device table points to a DeviceId interrupt
> >> translation table indexed by the EventID found in the msi msg. So the
> >> entry in the interrupt translation table eventually gives you the
> >> eventual interrupt ID targeted by the MSI MSG.
> >> This translation capability if not available in GICv2M though, ie. the
> >> one I am currently using.
> >>  
> >> Those tables currently are built by the ITS irqchip (irq-gic-v3-its.c)

That's right. GICv3/ITS disambiguates the interrupt source using the
DeviceID, which for PCI is derived from the Requester ID of the endpoint.
GICv2m is less flexible and requires a separate physical frame per guest
to achieve isolation.

Will
