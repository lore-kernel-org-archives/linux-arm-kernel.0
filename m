From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 27 Feb 2014 08:02:57 -0800
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <530F39C3.5060808@codeaurora.org>
References: <20140226183454.GA14639@cbox> <530E402C.9040502@codeaurora.org>
 <20140226195111.GB16149@cbox> <530F39C3.5060808@codeaurora.org>
Message-ID: <20140227160257.GA22935@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 08:12:35AM -0500, Christopher Covington wrote:
> Hi Christoffer,
> 
> On 02/26/2014 02:51 PM, Christoffer Dall wrote:
> > On Wed, Feb 26, 2014 at 02:27:40PM -0500, Christopher Covington wrote:
> 

[...]

> >>>
> >>> The virtual hardware platform must provide a number of mandatory
> >>> peripherals:
> >>>
> >>>   Serial console:  The platform should provide a console,
> >>>   based on an emulated pl011, a virtio-console, or a Xen PV console.
> >>>
> >>>   An ARM Generic Interrupt Controller v2 (GICv2) [3] or newer.  GICv2
> >>>   limits the the number of virtual CPUs to 8 cores, newer GIC versions
> >>>   removes this limitation.
> >>>
> >>>   The ARM virtual timer and counter should be available to the VM as
> >>>   per the ARM Generic Timers specification in the ARM ARM [1].
> >>>
> >>>   A hotpluggable bus to support hotplug of at least block and network
> >>>   devices.  Suitable buses include a virtual PCIe bus and the Xen PV
> >>>   bus.
> >>
> >> Is VirtIO hotplug capable? Over PCI or MMIO transports or both?
> > 
> > VirtIO devices attached on a PCIe bus are hotpluggable, the emulated
> > PCIe bus itself would not have anything to do with virtio, except that
> > virtio devices can hang off of it.  AFAIU.
> 
> So network/block device only as memory mapped peripherals (like SMSC or PL
> SD/MMC) or over VirtIO-MMIO won't meet the specification? Is PCI/VirtIO-PCI on
> ARM production ready? What's the motivation for requiring hotplug?
> 

Platform devices that don't sit on any 'real bus' are generally not
hotpluggable.

VM management systems such as OpenStack make heavy use of hotplug to add
storage to your VMs, for example.

This spec does not prohibit devices over mmio, or over virtio-mmio, in
fact it encourages guest kernels to include support for such.  But it
mandates that there is some hotpluggable bus, so a very common VM use
case is supported for ARM VMs.

PCI for ARM is not ready yet, but people are working on it.  That should
not have any bearing on what the right decision for this spec is though
- it's all early stage at this point.

-Christoffer
