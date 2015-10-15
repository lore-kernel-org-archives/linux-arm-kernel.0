From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 15 Oct 2015 10:58:56 +0100
Subject: [Xen-devel] xen,arm: enable cpu_hotplug
In-Reply-To: <561F78A4.7060507@citrix.com>
References: <alpine.DEB.2.02.1510081443100.1179@kaball.uk.xensource.com>
 <561EE3E5.2000105@citrix.com> <1444898398.1607.18.camel@citrix.com>
 <561F78A4.7060507@citrix.com>
Message-ID: <561F78E0.2070004@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/15 10:57, Julien Grall wrote:
> Hi Ian,
> 
> On 15/10/15 09:39, Ian Campbell wrote:
>> On Thu, 2015-10-15 at 00:23 +0100, Julien Grall wrote:
>>> My second point is related to how Xen is handling interrupt with vCPU. 
>>> When PSCI off is called, we will set the _VFP_down flag. This flag is 
>>> used in vgic_vcpu_inject_irq and when it's set the interrupt will be 
>>> ignored and stay active on the HW GIC forever. If the vCPU is coming 
>>> back online, this interrupt will never be received. AFAIU the spec, the 
>>> interrupt is expected to stay pending on the distributor side and will 
>>> be receive when the vCPU will come back or migrate to another vCPU. A 
>>> similar problem can happen when the vCPU is powered on again because we 
>>> clear all the interrupt state related to vCPU (see
>>> vgic_clear_pending_irqs).
>>
>> Is there also an interaction with our implementation of ITARGETSR of
>> picking the lowest set bit? e.g. if an IRQ has target 0x6 (targeting CPU 1
>> and CPU2) we will choose CPU 1. If CPU 1 is then unplugged, will we end up
>> targeting CPU 2 or the now-offline CPU 1? In the latter case the lack of
>> interrupts might be considered surprising?
> 
> I though about it when I wrote the mail yesterday night.
> 
> From the spec section 1.4.3 (ARM IHI 0048B.b):
> 
> "The ARM GIC architecture does not guarantee that a 1-N interrupt is
> presented to:
> ? all processors listed in the target processor list
> ? an enabled interface, where at least one interface is enabled."
> 
> AFAIU this paragraph, it means that there is no guarantee to receive an
> interrupt if the target mask contain a vCPU offline.

Hmmm I may not have been clear here. I meant that the interrupt will
stay pending in the distributor but not received by the guest.

-- 
Julien Grall
