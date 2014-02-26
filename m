From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 26 Feb 2014 21:48:43 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <5553754.0b4gMg5OS7@wuerfel>
References: <20140226183454.GA14639@cbox>
 <5553754.0b4gMg5OS7@wuerfel>
Message-ID: <20140226214843.GD12169@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 08:55:58PM +0100, Arnd Bergmann wrote:
> On Wednesday 26 February 2014 10:34:54 Christoffer Dall wrote:
> > ARM VM System Specification
> > ===========================
> > 
> > Goal
> > ----
> > The goal of this spec is to allow suitably-built OS images to run on
> > all ARM virtualization solutions, such as KVM or Xen.
> > 
> > Recommendations in this spec are valid for aarch32 and aarch64 alike, and
> > they aim to be hypervisor agnostic.
> > 
> > Note that simply adhering to the SBSA [2] is not a valid approach,
> > for example because the SBSA mandates EL2, which will not be available
> > for VMs.  Further, the SBSA mandates peripherals like the pl011, which
> > may be controversial for some ARM VM implementations to support.
> > This spec also covers the aarch32 execution mode, not covered in the
> > SBSA.
> 
> I would prefer if we can stay as close as possible to SBSA for individual
> hardware components, and only stray from it when there is a strong reason.
> pl011-subset doesn't sound like a significant problem to implement,
> especially as SBSA makes the DMA part of that optional. Can you
> elaborate on what hypervisor would have a problem with that?

I believe it comes down to how much extra overhead pl011-access-trap
would be over virtio-console. If low, then sure.
(Since there are certain things we cannot provide SBSA-compliant in
the guest anyway, I wouldn't consider lack of pl011 to be a big issue.)

> >   no FDT.  In this case, the VM implementation must provide ACPI, and
> >   the OS must be able to locate the ACPI root pointer through the UEFI
> >   system table.
> > 
> > For more information about the arm and arm64 boot conventions, see
> > Documentation/arm/Booting and Documentation/arm64/booting.txt in the
> > Linux kernel source tree.
> > 
> > For more information about UEFI and ACPI booting, see [4] and [5].
> 
> What's the point of having ACPI in a virtual machine? You wouldn't
> need to abstract any of the hardware in AML since you already know
> what the virtual hardware is, so I can't see how this would help
> anyone.

The point is that if we need to share any real hw then we need to use
whatever the host has.

> However, as ACPI will not be supported by arm32, not having the
> complete FDT will prevent you from running a 32-bit guest on
> a 64-bit hypervisor, which I consider an important use case.

In which case we would be making an active call to ban anything other
than virtio/xen-pv devices for 32-bit guests on hardware without DT.

However, I see the case of a 32-bit guest on 64-bit hypervisor as less
likely in the server space than in mobile, and ACPI in mobile as
unlikely, so it may end up not being a big issue.

/
    Leif
