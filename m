From: jchandra@broadcom.com (Jayachandran C.)
Date: Mon, 4 May 2015 10:21:24 +0530
Subject: [RFC PATCH 1/2] PCI: generic: remove dependency on hw_pci
In-Reply-To: <55468DC7.6090003@amd.com>
References: <1430307599-20536-1-git-send-email-jchandra@broadcom.com>
 <6662179.AoBfCMOsxD@wuerfel> <20150429174356.GA20947@red-moon>
 <55468DC7.6090003@amd.com>
Message-ID: <20150504045122.GA24361@jayachandranc.netlogicmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 03, 2015 at 04:06:15PM -0500, Suravee Suthikulpanit wrote:
> 
> 
> On 4/29/15 12:43, Lorenzo Pieralisi wrote:
> >On Wed, Apr 29, 2015 at 01:34:20PM +0100, Arnd Bergmann wrote:
> >>>On Wednesday 29 April 2015 17:09:58 Jayachandran C wrote:
> >>>> >The current code in pci-host-generic.c uses pci_common_init_dev()
> >>>> >from the arch/arm/ to do a part of the PCI initialization, and this
> >>>> >prevents it from being used on arm64.
> >>>> >
> >>>> >The initialization done by pci_common_init_dev() that is really
> >>>> >needed by pci-host-generic.c can be done in the same file without
> >>>> >using the hw_pci API of ARM.
> >>>> >
> >>>> >The ARM platform requires a pci_sys_data as sysdata for the PCI bus,
> >>>> >this is be handled by setting up 'struct gen_pci' to embed a
> >>>> >pci_sys_data variable as the first element on the ARM platform.
> >>>> >
> >>>> >Signed-off-by: Jayachandran C<jchandra@broadcom.com>
> >>>
> >>>This seems very useful
> >Yes, it is getting less awful, waiting for pci_sys_data to disappear.
> >
> 
> Lorenzo,
> 
> A while back, you mentioned here
> (https://lkml.org/lkml/2015/2/16/364) that the ARM32
> pcibios_align_resource() implementation requires
> pci_sys_data, so we _still_ rely on pci_common_init_dev to create one
> for us. Is this still the case?
> 
> I am looking at the arch/arm32/kernel/bios32.c: pcibios_init_hw()
> and see that it setup the pci_sys_data.align_resource to
> hw_pci.align_resource (see here
> http://lxr.free-electrons.com/source/arch/arm/kernel/bios32.c#L471).
> 
> However it seems that the hw_pci.align_resource is never setup in
> the pci-host-generic.c.  Am I missing something here?

ARM32 needs a sysdata because functions like pcibios_align_resource()
will dereference and access members of this structure. However having
an allocated but zeroed sysdata is fine, since the function pointers
in sysdata (as well as things like busnr, msi_ctrl) will be 0/NULL
and pcibios_align_resource will do the default handling.

If this patch needs changes to work on your platform please let me know.

Thanks,
JC.
