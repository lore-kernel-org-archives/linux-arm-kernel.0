From: djw@t-chip.com.cn (Levin Du)
Date: Wed, 23 May 2018 10:02:15 +0800
Subject: [PATCH v2 2/5] gpio: syscon: Add gpio-syscon for rockchip
In-Reply-To: <20180522180238.GA7328@rob-hp-laptop>
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn>
 <1526615528-9707-1-git-send-email-djw@t-chip.com.cn>
 <1526615528-9707-2-git-send-email-djw@t-chip.com.cn>
 <20180522180238.GA7328@rob-hp-laptop>
Message-ID: <6ffb43dc-55a5-14eb-eb18-3a731cdaf424@t-chip.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-05-23 2:02 AM, Rob Herring wrote:
> On Fri, May 18, 2018 at 11:52:05AM +0800, djw at t-chip.com.cn wrote:
>> From: Levin Du <djw@t-chip.com.cn>
>>
>> Some GPIOs sit in the GRF_SOC_CON registers of Rockchip SoCs,
>> which do not belong to the general pinctrl.
>>
>> Adding gpio-syscon support makes controlling regulator or
>> LED using these special pins very easy by reusing existing
>> drivers, such as gpio-regulator and led-gpio.
>>
>> Signed-off-by: Levin Du <djw@t-chip.com.cn>
>>
>> ---
>>
>> Changes in v2:
>> - Rename gpio_syscon10 to gpio_mute in doc
>>
>> Changes in v1:
>> - Refactured for general gpio-syscon usage for Rockchip SoCs.
>> - Add doc rockchip,gpio-syscon.txt
>>
>>   .../bindings/gpio/rockchip,gpio-syscon.txt         | 41 ++++++++++++++++++++++
>>   drivers/gpio/gpio-syscon.c                         | 30 ++++++++++++++++
>>   2 files changed, 71 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>> new file mode 100644
>> index 0000000..b1b2a67
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/rockchip,gpio-syscon.txt
>> @@ -0,0 +1,41 @@
>> +* Rockchip GPIO support for GRF_SOC_CON registers
>> +
>> +Required properties:
>> +- compatible: Should contain "rockchip,gpio-syscon".
>> +- gpio-controller: Marks the device node as a gpio controller.
>> +- #gpio-cells: Should be two. The first cell is the pin number and
>> +  the second cell is used to specify the gpio polarity:
>> +    0 = Active high,
>> +    1 = Active low.
> There's no need for this child node. Just make the parent node a gpio
> controller.
>
> Rob
Hi Rob, it is not clear to me. Do you suggest that the grf node should 
be a gpio controller,
like below?

+??? grf: syscon at ff100000 {
+??? ??? compatible = "rockchip,gpio-syscon", "rockchip,rk3328-grf", 
"syscon", "simple-mfd";
+??? ??? //...
+??? ??? gpio-controller;
+??? ??? #gpio-cells = <2>;
+??? ??? gpio,syscon-dev = <&grf 0x0428 0>;
+??? };

or just reserve the following case in the doc?

+??? grf: syscon at ff100000 {
+??? ??? compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
+??? ??? //...
+??? };
+
+??? gpio_mute: gpio-mute {
+??? ??? compatible = "rockchip,gpio-syscon";
+??? ??? gpio-controller;
+??? ??? #gpio-cells = <2>;
+??? ??? gpio,syscon-dev = <&grf 0x0428 0>;
+??? };


Thanks
Levin
