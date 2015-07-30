From: jchandra@broadcom.com (Jayachandran C.)
Date: Thu, 30 Jul 2015 15:43:52 +0530
Subject: [PATCH v3 1/2] PCI: generic: remove dependency on hw_pci
In-Reply-To: <20150730092808.GA4685@red-moon>
References: <1438183681-30519-1-git-send-email-jchandra@broadcom.com>
 <20150730092808.GA4685@red-moon>
Message-ID: <20150730101351.GA31408@jayachandranc.netlogicmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 10:28:08AM +0100, Lorenzo Pieralisi wrote:
> On Wed, Jul 29, 2015 at 04:28:00PM +0100, Jayachandran C wrote:
> > The current code in pci-host-generic.c uses pci_common_init_dev()
> > from ARM platform to do some of the PCI initializations, and this
> > prevents it from being used in ARM64.
> > 
> > The initialization done by pci_common_init_dev() that is needed
> > by pci-host-generic.c is really limited, and can be done easily
> > in the same file without using hw_pci API. The ARM platform
> > requires a pci_sys_data as sysdata for the PCI bus, this can be
> > handled by setting up gen_pci to have a pci_sys_data variable as
> > the first element.
> 
> Ok, I still do not like leaving pci_sys_data there, and to remove
> it there is only one snag (+ one patch to prevent
> resources enablement on ARM64 PROBE_ONLY systems to have a
> consolidated ARM/ARM64 host generic), which consists in removing the
> align_resource pointer from pci_sys_data. A proposed solution (maybe
> not ideal, we can consider it a temporary step to make progress)
> here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/359273.html
> 
> Comments very appreciated on the patch above, I do not have major
> concerns with this patch other than the pci_sys_data hack, because
> that's what it is.

In may opinion, we have to leave ->sysdata on ARM pointing to a valid
pci_sys_data. Leaving it pointing to random stuff and hoping that it
will not be used is pretty bad - so I don't see why such a patch would
make it upstream.

The second issue I have is adding dependencies between patches that
enable basic functionality on arm64 with arm infrastructure cleanup
patches. Given the number of kernel releases the cleanups take [and
factoring in the amount of mess arm has :)], we will end up waiting
a long time for arm64.

BTW, I am not sure why there is a pushback on wrapping a structure in
another, container_of() is the linux way of doing things :)

JC.
