From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 May 2015 10:02:29 +0200
Subject: [RFC PATCH v1 1/3] PCI: designware: Add ARM64 support
In-Reply-To: <5563DF4F.4080601@hisilicon.com>
References: <000001d096a9$27bf43f0$773dcbd0$@com> <5563451B.4050609@st.com>
 <5563DF4F.4080601@hisilicon.com>
Message-ID: <3340422.95mKZ6cYUI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 May 2015 10:49:51 Zhou Wang wrote:
> 
> I am a little confused that pci_sys_data is still needed as we don't use the code
> in bios32. What was the problem you met? Could you share me more information? Then
> let's see how to solve the problem.
> 

The PCI core code still calls pcibios_align_resource(), which will try to
use the dev->sysdata pointer as 'struct pci_sys_data'. To solve this, we
need to change the pci-mvebu driver and the core code first to let the
driver override pcibios_align_resource() through an operation in 
struct pci_host_bridge.

The other remaining use of dev->sysdata is the ARM pcibios_msi_controller()
function that overrides the generic implementation.  To solve this, we need
to change the five remaining drivers that set hw_pci->msi_ctrl to use
the new generic method, and remove the ARM specific implementation.

	Arnd
