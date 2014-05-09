From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 09 May 2014 07:02:45 +0200
Subject: [PATCHv4 7/7] ARM: dts: Add device tree sources for Exynos3250
In-Reply-To: <536C2A1C.6030807@samsung.com>
References: <1398388572-30239-1-git-send-email-cw00.choi@samsung.com>
 <1398388572-30239-8-git-send-email-cw00.choi@samsung.com>
 <535B0324.50705@gmail.com> <536C2A1C.6030807@samsung.com>
Message-ID: <536C6175.5000302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 09.05.2014 03:06, Chanwoo Choi wrote:
> On 04/26/2014 09:51 AM, Tomasz Figa wrote:
>> On 25.04.2014 03:16, Chanwoo Choi wrote:

[snip]

>>> +    cpus {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        cpu at 0 {
>>> +            device_type = "cpu";
>>> +            compatible = "arm,cortex-a7";
>>> +            reg = <0>;
>>> +            clock-frequency = <1000000000>;
>>> +        };
>>
>> Why only one CPU? I believe Exynos3250 is dual core.
>
> I'll add cpu1 information.
>
>> Also are physical IDs of the cores really 0 and 1? On Exynos4210 for example they are 0x900 and 0x901, while on Exynos4212 they are 0xa00 and 0xa01. Please check this.
>
> The 'reg' property means only hardware id(hwid) of CPU.
> You can check it on arm_dt_init_cpu_maps() in arch/arm/kernel/devtree.c.h.
> or Documentation/devicetree/bindings/arm/cpus.txt.
>

Well, as described in Documentation/devicetree/bindings/arm/cpus.txt, on 
32-bit ARM v7 or later CPUs the "reg" property should be equal to the 
lower 24-bits of MPIDR value of given CPU, which in addition to core ID 
includes also cluster ID, which can be non-zero, even on single cluster 
SoCs (like it is on Exynos4210 and 4x12).

>>> +    };
>>> +
>>> +    fixed-rate-clocks {
>>> +        compatible = "simple-bus";
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;

[snip]

>>> +    cmu: clock-controller at 10030000 {
>>> +        compatible = "samsung,exynos3250-cmu";
>>> +        reg = <0x10030000 0x20000>;
>>> +        #clock-cells = <1>;
>>> +    };
>>> +
>>> +    rtc at 10070000 {
>>
>> Please add label to the node, so it can be referenced from board dts files added later (using the method I explained above).
>
> OK, I'll add lable as following:
>
> 	rtc_0: rtc at 10070000 {

There is no need to suffix the RTC with _0, as there is just one RTC in 
the SoC. So in this case rtc: rtc at 10070000 will be enough.

>
>>
>>> +        compatible = "samsung,s3c6410-rtc";
>>> +        reg = <0x10070000 0x100>;
>>> +        interrupts = <0 73 0>, <0 74 0>;
>>> +        status = "disabled";
>>> +    };

[snip]

>>> +    adc: adc at 126C0000 {
>>> +        compatible = "samsung,exynos-adc-v3";
>>> +        reg = <0x126C0000 0x100>, <0x10020718 0x4>;
>>> +        interrupts = <0 137 0>;
>>> +        clock-names = "adc", "sclk_tsadc";
>>> +        clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
>>> +        #io-channel-cells = <1>;
>>> +        io-channel-ranges;
>>> +        status = "disabled";
>>> +    };
>>> +
>>> +    serial at 13800000 {
>>
>> Please add label.
>
> OK, I'll add lable as following:
>
> 	serial_0: serial at 13800000 {
>

OK. In this case there are multiple instances of serial controller 
available so the _0 suffix is fine.

>>
>>> +        compatible = "samsung,exynos4210-uart";
>>> +        reg = <0x13800000 0x100>;
>>> +        interrupts = <0 109 0>;
>>> +        clocks = <&cmu CLK_UART0>, <&cmu CLK_SCLK_UART0>;
>>> +        clock-names = "uart", "clk_uart_baud0";
>>> +        status = "disabled";
>>> +    };
>>> +
>>> +    serial at 13810000 {
>
> OK, I'll add lable as following:
>
> 	serial_1: serial at 13800000 {
>

OK.

>
> Thanks for your review.

You're welcome. Thanks for addressing my comments.

Best regards,
Tomasz
