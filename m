From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 16 Jul 2015 14:24:54 -0400
Subject: arm: dts: update for 4.2-rcx
In-Reply-To: <55A7E1F2.7000100@oracle.com>
References: <55A7C561.9020406@ti.com> <55A7DE91.7050003@oracle.com>
 <55A7E0D0.9070104@ti.com> <55A7E1F2.7000100@oracle.com>
Message-ID: <55A7F6F6.40202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2015 12:55 PM, santosh shilimkar wrote:
> On 7/16/2015 9:50 AM, Murali Karicheri wrote:
>> On 07/16/2015 12:40 PM, santosh shilimkar wrote:
>>> On 7/16/2015 7:53 AM, Murali Karicheri wrote:
>>>> Santosh,
>>>>
>>>> Do you have my patch for https://lkml.org/lkml/2015/7/15/879 ?
>>>> This one should be applied to v4.2-rc kernel with priority.
>>>> Please review and do the needful.
>>>>
>>> Yes I have it for next merge window. It won't be qualified as a
>>> fix rather more of enhancement. Do you have also patches for
>>> board DTS files which enables PCIE. I can queue them together
>>> for next merge window.
>> No this is a fix for v4.2-rc. PCIe driver is not complete without having
>> a SerDes driver. Currently the version we send is not accepted since the
>> config blobs are used. On K2E EVM, this causes problem since the EVM has
>> Marvell SATA controller present and with default values in the SerDes
>> register, it seems to pass the PCIe link check, but causes issues since
>> the configuration is not correct. The manifestation is that when EVM is
>> booted with NFS rootfs, the boot hangs. We can't enable PCIe on this EVM
>> since to work, SerDes driver has to be present as well. So by default,
>> the PCIe DT binding should be disabled in SoC specific DTS. It can be
>> enabled in the board specific DTS when the SerDes device driver is also
>> present. We plan to upstream a common SerDes driver soon. But at this
>> point this has to be disabled by default.
>>
> Please add this information and respin the patch. Thanks for explaining
> it.
>
>> I can provide more details if needed in the patch commit description,
>> but I though it is not correct to keep the PCIe DT bindings to be
>> enabled in the SoC specific DTS to begin with. So this is a fix for
>> v4.2-rc.
>>
> Please do. It wasn't clear from the patch description. With above added
> description its a legitimate fix which I can queue it up for rc's.
>
Ok. Will do. Need an additional patch to rename the PCI nodes such that 
status can be overridden in a board specific DTS.

+
+&pcie1 {
+       status = "okay";
+};
diff --git a/arch/arm/boot/dts/k2e.dtsi b/arch/arm/boot/dts/k2e.dtsi
index 71e2b1c..0055477 100644
--- a/arch/arm/boot/dts/k2e.dtsi
+++ b/arch/arm/boot/dts/k2e.dtsi
@@ -94,7 +94,7 @@
                         status = "disabled";
                 };

-               pcie at 21020000 {
+               pcie1: pcie at 21020000 {
                         compatible = "ti,keystone-pcie","snps,dw-pcie";
                         clocks = <&clkpcie1>;
                         clock-names = "pcie";


Same for pcie0 in keystone.dtsi. Do you prefer to put both in the same 
patch or a separate one for this?

Murali
> Regards,
> Santosh
>
>


-- 
Murali Karicheri
Linux Kernel, Keystone
