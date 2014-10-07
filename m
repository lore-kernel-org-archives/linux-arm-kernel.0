From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 7 Oct 2014 13:06:59 +0100
Subject: [RFC 2/4] PCI: generic: Add support for ARM64 and MSI(x)
In-Reply-To: <3256560.C0cZnIlnAv@wuerfel>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
 <2430078.s4snyh5OoF@wuerfel>
 <20141001084626.GZ841@e106497-lin.cambridge.arm.com>
 <3256560.C0cZnIlnAv@wuerfel>
Message-ID: <20141007120659.GA30590@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 10:38:45AM +0100, Arnd Bergmann wrote:

[...]

> pci_mmap_page_range could either get generalized some more in an attempt
> to have a __weak default implementation that works on ARM, or it could
> be changed to lose the dependency on pci_sys_data instead. In either
> case, the change would involve using the generic pci_host_bridge_window
> list.

On ARM pci_mmap_page_range requires pci_sys_data to retrieve its
mem_offset parameter. I had a look, and I do not understand *why*
it is required in that function, so I am asking. That function
is basically used to map PCI resources to userspace, IIUC, through
/proc or /sysfs file mappings. As far as I understand those mappings
expect VMA pgoff to be the CPU address when files representing resources
are mmapped from /proc and 0 when mmapped from /sys (I mean from
userspace, then VMA pgoff should be updated by the kernel to map the
resource).

Question is: why pci_mmap_page_range() should apply an additional
shift to the VMA pgoff based on pci_sys_data.mem_offset, which represents
the offset from cpu->bus offset. I do not understand that. PowerPC
does not seem to apply that fix-up (in PowerPC __pci_mmap_make_offset there
is commented out code which prevents the pci_mem_offset shift to be
applied). I think it all boils down to what the userspace interface is
expecting when the memory areas are mmapped, if anyone has comments on
this that is appreciated.

Thanks,
Lorenzo
