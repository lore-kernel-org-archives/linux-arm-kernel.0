From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jun 2014 09:47:22 +0100
Subject: [RFC PATCH v6 04/20] iommu/arm-smmu: add capability
 IOMMU_CAP_INTR_REMAP
In-Reply-To: <1403811384.31091.151.camel@ul30vt.home>
References: <20140616151329.GQ16758@arm.com>
 <20140616152157.GB31771@8bytes.org>
 <20140616152526.GR16758@arm.com>
 <20140616153832.GC31771@8bytes.org>
 <9353770066894e85809e1e443b71d1cd@BY2PR07MB203.namprd07.prod.outlook.com>
 <748dccbbd3284521af4659ccbbb11453@BY2PR07MB203.namprd07.prod.outlook.com>
 <b085e02e72dc424d9624c3e810951087@BY2PR07MB203.namprd07.prod.outlook.com>
 <1403809223.31091.137.camel@ul30vt.home>
 <ec8dbbcb991e4d73b73f4b4f98342445@BY2PR07MB203.namprd07.prod.outlook.com>
 <1403811384.31091.151.camel@ul30vt.home>
Message-ID: <20140627084722.GB26276@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 08:36:24PM +0100, Alex Williamson wrote:
> On Thu, 2014-06-26 at 19:10 +0000, Chalamarla, Tirumalesh wrote:
> > Thanks for the clarification Alex, That?s exactly my point, why are we
> > relying on  QEMU or something else to emulate the MSI space when we can
> > directly give access to devices using ITS (of course with a small
> > emulation code).  This way we are also benefited from all ITS services
> > like VCPU migration etc.  
> 
> I have no idea what ITS is.

ITS is the MSI doorbell for GICv3 (ARM's latest interrupt controller).

I agree that we will need an ITS emulation if we want to use MSIs in the
guest, and I believe that Marc (CC'd) had already started thinking about
that.

> > What about non QEMU VFIO users, for example, if I wanted to use VFIO to
> > assign a device to a user process I don't need to depend on QEMU.   I
> > thought this is one of the main goals of vfio to make it independent of
> > hypervisors.     
> 
> Where did QEMU become a requirement?  Maybe I'm missing something in the
> ARM part of the conversation that got chopped off, but this is exactly
> why we have the VFIO/QEMU split that we do.  VFIO provides basic
> virtualization for config space and restricts access to other areas that
> users shouldn't be allowed to change.  QEMU is just one example of a
> userspace VFIO driver.  QEMU takes the decomposed device exposed through
> the VFIO ABI and re-creates a PCI device out of it.  VFIO itself has no
> dependency on QEMU.  Thanks,

I also don't understand the QEMU part here. The MSI emulation would be in
the kernel, just like the GICv2 emulation that we already have. For
userspace drivers, wouldn't you just use eventfd rather than bother with
emulating MSIs?

Finally, the interrupt remapping part is about the SMMU preventing MSI
writes to arbitrary portions of the host address space. The ITS is about
routing interrupts to CPUs.

Will
