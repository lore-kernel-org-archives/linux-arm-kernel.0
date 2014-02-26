From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 26 Feb 2014 14:25:53 -0800
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140226214843.GD12169@bivouac.eciton.net>
References: <20140226183454.GA14639@cbox> <5553754.0b4gMg5OS7@wuerfel>
 <20140226214843.GD12169@bivouac.eciton.net>
Message-ID: <20140226222553.GF16149@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 09:48:43PM +0000, Leif Lindholm wrote:
> On Wed, Feb 26, 2014 at 08:55:58PM +0100, Arnd Bergmann wrote:
> > On Wednesday 26 February 2014 10:34:54 Christoffer Dall wrote:
> > > ARM VM System Specification
> > > ===========================
> > > 
> > > Goal
> > > ----
> > > The goal of this spec is to allow suitably-built OS images to run on
> > > all ARM virtualization solutions, such as KVM or Xen.
> > > 
> > > Recommendations in this spec are valid for aarch32 and aarch64 alike, and
> > > they aim to be hypervisor agnostic.
> > > 
> > > Note that simply adhering to the SBSA [2] is not a valid approach,
> > > for example because the SBSA mandates EL2, which will not be available
> > > for VMs.  Further, the SBSA mandates peripherals like the pl011, which
> > > may be controversial for some ARM VM implementations to support.
> > > This spec also covers the aarch32 execution mode, not covered in the
> > > SBSA.
> > 
> > I would prefer if we can stay as close as possible to SBSA for individual
> > hardware components, and only stray from it when there is a strong reason.
> > pl011-subset doesn't sound like a significant problem to implement,
> > especially as SBSA makes the DMA part of that optional. Can you
> > elaborate on what hypervisor would have a problem with that?
> 
> I believe it comes down to how much extra overhead pl011-access-trap
> would be over virtio-console. If low, then sure.
> (Since there are certain things we cannot provide SBSA-compliant in
> the guest anyway, I wouldn't consider lack of pl011 to be a big issue.)
> 

I don't think it's about overhead, sure pl011 may be slower, but it's a
serial port, does anyone care about performance of a console? pl011
should be good enough for sure.

I think the issue is that Xen does no real device emulation today at
all, they don't use QEMU etc.  That being said, adding a pl011 emulation
in the Xen tools doesn't seem like the worst idea in the world, but I
will let them chime in on why they are opposed to it.

> > >   no FDT.  In this case, the VM implementation must provide ACPI, and
> > >   the OS must be able to locate the ACPI root pointer through the UEFI
> > >   system table.
> > > 
> > > For more information about the arm and arm64 boot conventions, see
> > > Documentation/arm/Booting and Documentation/arm64/booting.txt in the
> > > Linux kernel source tree.
> > > 
> > > For more information about UEFI and ACPI booting, see [4] and [5].
> > 
> > What's the point of having ACPI in a virtual machine? You wouldn't
> > need to abstract any of the hardware in AML since you already know
> > what the virtual hardware is, so I can't see how this would help
> > anyone.
> 
> The point is that if we need to share any real hw then we need to use
> whatever the host has.
> 
> > However, as ACPI will not be supported by arm32, not having the
> > complete FDT will prevent you from running a 32-bit guest on
> > a 64-bit hypervisor, which I consider an important use case.
> 
> In which case we would be making an active call to ban anything other
> than virtio/xen-pv devices for 32-bit guests on hardware without DT.
> 
> However, I see the case of a 32-bit guest on 64-bit hypervisor as less
> likely in the server space than in mobile, and ACPI in mobile as
> unlikely, so it may end up not being a big issue.
> 
But you may want a networking applicance, for example, built on ARM
64-bit hardware, with an ARM 64-bit hypervisor on there, and you wish to
run some 32-bit system in a VM.  If the hardware is ACPI based, it would
be a shame if the VM implementation (or the virtual firmware) couldn't
provide a useable 32-bit FDT.  We may want to call that case out in this
document?

Thanks,
-Christoffer
