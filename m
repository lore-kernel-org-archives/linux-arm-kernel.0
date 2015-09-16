From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Wed, 16 Sep 2015 11:24:31 +0800
Subject: [PATCH v9 5/6] Documentation: DT: Add HiSilicon PCIe host binding
In-Reply-To: <55F8D12D.50107@kernel.org>
References: <1442321361-174300-1-git-send-email-wangzhou1@hisilicon.com>
 <1442321361-174300-6-git-send-email-wangzhou1@hisilicon.com>
 <55F874F9.1060804@kernel.org> <55F8C268.2020809@hisilicon.com>
 <55F8D12D.50107@kernel.org>
Message-ID: <55F8E0EF.3040900@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/9/16 10:17, Rob Herring wrote:
> On 09/15/2015 08:14 PM, Zhou Wang wrote:
>> On 2015/9/16 3:43, Rob Herring wrote:
>>> On 09/15/2015 07:49 AM, Zhou Wang wrote:
>>>> This patch adds related DTS binding document for HiSilicon PCIe host driver.
>>>>
>>>> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>>>> ---
>>>>  .../devicetree/bindings/pci/hisilicon-pcie.txt     | 46 ++++++++++++++++++++++
>>>>  1 file changed, 46 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>>>> new file mode 100644
>>>> index 0000000..2afc9d1
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
>>>> @@ -0,0 +1,46 @@
>>>> +HiSilicon PCIe host bridge DT description
>>>> +
>>>> +HiSilicon PCIe host controller is based on Designware PCI core.
>>>> +It shares common functions with PCIe Designware core driver and inherits
>>>> +common properties defined in
>>>> +Documentation/devicetree/bindings/pci/designware-pci.txt.
>>>> +
>>>> +Additional properties are described here:
>>>> +
>>>> +Required properties:
>>>> +- compatible: Should contain "hisilicon,hip05-pcie".
>>>> +- reg: Should contain rc_dbi, subctrl, config registers location and length.
>>>> +- reg-names: Must include the following entries:
>>>> +  "rc_dbi": controller configuration registers;
>>>> +  "subctrl": whole PCIe hosts configuration registers;
>>>> +  "config": PCIe configuration space registers.
>>>> +- msi-parent: Should be its_pcie which is an ITS receiving MSI interrupts.
>>>> +- port-id: Should be 0, 1, 2 or 3.
>>>
>>> What is port-id for? Use of instance indexes need to have good reason.
>>>
>>> Rob
>>
>> There are four PCIe controllers in HiSilicon Hip05 SoC, port-id just indicates
>> which one we use. And we will use port-id to locate related registers in driver.
> 
> Just having multiple instances is not a reason. So looking at the
> driver, port-id is used to calculate register addresses for these registers:
> 
> #define PCIE_SUBCTRL_MODE_REG                           0x2800
> #define PCIE_SUBCTRL_SYS_STATE4_REG                     0x6818
> 
> Is the base address of subctrl the same on all 4 ports? If so, you

Yes, same subctrl address for 4 ports. Will use syscon to access subctrl
registers in next version.

Many thanks for pointing this,
Zhou

> should not have overlapping resources in the DT. Either split these 2
> registers into 2 reg regions (for each register) or use syscon to
> provide access to the region.
> 
> Rob
> 
> 
> .
> 
