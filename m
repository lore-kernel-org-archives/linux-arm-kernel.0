From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 8 Nov 2016 21:29:22 +0100
Subject: Summary of LPC guest MSI discussion in Santa Fe (was: Re: [RFC
 0/8] KVM PCIe/MSI passthrough on ARM/ARM64 (Alt II))
In-Reply-To: <20161108024559.GA20591@arm.com>
References: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
 <20161103220205.37715b49@t450s.home>
 <20161108024559.GA20591@arm.com>
Message-ID: <20161108202922.GC15676@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Nov 08, 2016 at 02:45:59AM +0000, Will Deacon wrote:
> Hi all,
> 
> I figured this was a reasonable post to piggy-back on for the LPC minutes
> relating to guest MSIs on arm64.
> 
> On Thu, Nov 03, 2016 at 10:02:05PM -0600, Alex Williamson wrote:
> > We can always have QEMU reject hot-adding the device if the reserved
> > region overlaps existing guest RAM, but I don't even really see how we
> > advise users to give them a reasonable chance of avoiding that
> > possibility.  Apparently there are also ARM platforms where MSI pages
> > cannot be remapped to support the previous programmable user/VM
> > address, is it even worthwhile to support those platforms?  Does that
> > decision influence whether user programmable MSI reserved regions are
> > really a second class citizen to fixed reserved regions?  I expect
> > we'll be talking about this tomorrow morning, but I certainly haven't
> > come up with any viable solutions to this.  Thanks,
> 
> At LPC last week, we discussed guest MSIs on arm64 as part of the PCI
> microconference. I presented some slides to illustrate some of the issues
> we're trying to solve:
> 
>   http://www.willdeacon.ukfsn.org/bitbucket/lpc-16/msi-in-guest-arm64.pdf
> 
> Punit took some notes (thanks!) on the etherpad here:
> 
>   https://etherpad.openstack.org/p/LPC2016_PCI
> 
> although the discussion was pretty lively and jumped about, so I've had
> to go from memory where the notes didn't capture everything that was
> said.
> 
> To summarise, arm64 platforms differ in their handling of MSIs when compared
> to x86:
> 
>   1. The physical memory map is not standardised (Jon pointed out that
>      this is something that was realised late on)
>   2. MSIs are usually treated the same as DMA writes, in that they must be
>      mapped by the SMMU page tables so that they target a physical MSI
>      doorbell
>   3. On some platforms, MSIs bypass the SMMU entirely (e.g. due to an MSI
>      doorbell built into the PCI RC)
>   4. Platforms typically have some set of addresses that abort before
>      reaching the SMMU (e.g. because the PCI identifies them as P2P).
> 
> All of this means that userspace (QEMU) needs to identify the memory
> regions corresponding to points (3) and (4) and ensure that they are
> not allocated in the guest physical (IPA) space. For platforms that can
> remap the MSI doorbell as in (2), then some space also needs to be
> allocated for that.
> 
> Rather than treat these as separate problems, a better interface is to
> tell userspace about a set of reserved regions, and have this include
> the MSI doorbell, irrespective of whether or not it can be remapped.

Is my understanding correct, that you need to tell userspace about the
location of the doorbell (in the IOVA space) in case (2), because even
though the configuration of the device is handled by the (host) kernel
through trapping of the BARs, we have to avoid the VFIO user programming
the device to create other DMA transactions to this particular address,
since that will obviously conflict and either not produce the desired
DMA transactions or result in unintended weird interrupts?

Thanks,
Christoffer
