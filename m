From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Wed, 27 May 2015 21:56:27 +0800
Subject: [RFC PATCH v1 1/3] PCI: designware: Add ARM64 support
In-Reply-To: <3340422.95mKZ6cYUI@wuerfel>
References: <000001d096a9$27bf43f0$773dcbd0$@com> <5563451B.4050609@st.com>
 <5563DF4F.4080601@hisilicon.com> <3340422.95mKZ6cYUI@wuerfel>
Message-ID: <5565CD0B.6020206@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/5/26 16:02, Arnd Bergmann wrote:
> On Tuesday 26 May 2015 10:49:51 Zhou Wang wrote:
>>
>> I am a little confused that pci_sys_data is still needed as we don't use the code
>> in bios32. What was the problem you met? Could you share me more information? Then
>> let's see how to solve the problem.
>>
> 
> The PCI core code still calls pcibios_align_resource(), which will try to
> use the dev->sysdata pointer as 'struct pci_sys_data'. To solve this, we

Thanks for reminding.

> need to change the pci-mvebu driver and the core code first to let the

It seams that only pci-mvebu implemented align_resource callback in ARM ?

> driver override pcibios_align_resource() through an operation in 
> struct pci_host_bridge.
> 
> The other remaining use of dev->sysdata is the ARM pcibios_msi_controller()
> function that overrides the generic implementation.  To solve this, we need
> to change the five remaining drivers that set hw_pci->msi_ctrl to use
> the new generic method, and remove the ARM specific implementation.

Yes, that is better if we can do like this. But for pcie-designware, can we
just set bus->msi = &dw_pcie_msi_chip and get msi controller using dev->bus->msi
in pci_msi_controller()?

Best Regards,
Zhou

> 
> 	Arnd
> 
> .
> 
