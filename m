From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 11 May 2018 14:16:56 +0100
Subject: [PATCH v2 1/2] ARM: dts: vexpress: use standard gpio bindings for
 sys_{led,mci,flash}
In-Reply-To: <CAL_JsqKsGV8rrox2hSioASD+96ws9JLTo_DLw9nKwAgr5uZ_3g@mail.gmail.com>
References: <1525884482-19855-1-git-send-email-sudeep.holla@arm.com>
 <1526034208-9690-1-git-send-email-sudeep.holla@arm.com>
 <CAL_JsqKsGV8rrox2hSioASD+96ws9JLTo_DLw9nKwAgr5uZ_3g@mail.gmail.com>
Message-ID: <60e76b54-468a-f0ae-790d-3fc6bb4b55ed@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/05/18 13:10, Rob Herring wrote:
> On Fri, May 11, 2018 at 5:23 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Commit 2cff6dba57b7 ("ARM: dts: vexpress: fix node name unit-address presence warnings")
>> removed the unit address as there was no associated reg property in
>> these sysreg nodes.
>>
>> Also the latest DTC throws warnings for character '_' in the node names.
>>
>> Warning (node_name_chars_strict): /sysreg at 10000/sys_led: Character '_' not recommended in node name
>> Warning (node_name_chars_strict): /sysreg at 10000/sys_mci: Character '_' not recommended in node name
>> Warning (node_name_chars_strict): /sysreg at 10000/sys_flash: Character '_' not recommended in node name
>>
>> The correct way to fix this as well as the original unit-address presence
>> warnings is to use the standard gpio controller binding and specify the
>> reg properties as per the hardware as it was before.
>>
>> However note that Vexpress sysreg MFD driver will still continue to use
>> the hardcoded values for compatibility reasons.
>>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  arch/arm/boot/dts/vexpress-v2m-rs1.dtsi | 11 ++++++++---
>>  arch/arm/boot/dts/vexpress-v2m.dtsi     | 11 ++++++++---
>>  2 files changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>> index 7b8ff5b3b912..a8586a0b957d 100644
>> --- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>> +++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
>> @@ -76,21 +76,26 @@
>>                                 v2m_sysreg: sysreg at 10000 {
>>                                         compatible = "arm,vexpress-sysreg";
>>                                         reg = <0x010000 0x1000>;
>> +                                       #address-cells = <1>;
>> +                                       #size-cells = <1>;
> 
> You need a ranges here and below to translate from 0-0x10000 range.
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Thanks, I have appended it with below change

Regards,
Sudeep

--

diff --git c/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
w/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index a8586a0b957d..4488c8fe213a 100644
--- c/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ w/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -78,6 +78,7 @@
                                        reg = <0x010000 0x1000>;
                                        #address-cells = <1>;
                                        #size-cells = <1>;
+                                       ranges = <0 0x10000 0x1000>;
                                        v2m_led_gpios: gpio at 8 {
                                                compatible =
"arm,vexpress-sysreg,sys_led";
diff --git c/arch/arm/boot/dts/vexpress-v2m.dtsi
w/arch/arm/boot/dts/vexpress-v2m.dtsi
index 37ecccebd937..4db42f6326a3 100644
--- c/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ w/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -78,6 +78,7 @@
                                        reg = <0x00000 0x1000>;
                                        #address-cells = <1>;
                                        #size-cells = <1>;
+                                       ranges = <0 0 0x1000>;
                                        v2m_led_gpios: gpio at 8 {
                                                compatible =
"arm,vexpress-sysreg,sys_led";
