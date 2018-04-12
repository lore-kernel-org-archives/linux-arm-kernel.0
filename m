From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Wed, 11 Apr 2018 19:11:22 -0700
Subject: [PATCH v3 04/10] Documentations: dt-bindings: Add a document of
 PECI adapter driver for Aspeed AST24xx/25xx SoCs
In-Reply-To: <CACPK8XcfrheC+UDB7mLPkgPRCuk8f+P830NG+cy2v6F_PJvUTw@mail.gmail.com>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-5-jae.hyun.yoo@linux.intel.com>
 <CACPK8XcfrheC+UDB7mLPkgPRCuk8f+P830NG+cy2v6F_PJvUTw@mail.gmail.com>
Message-ID: <2c5f7636-169c-f58f-1c45-2e9950be72f3@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joel,

On 4/11/2018 4:52 AM, Joel Stanley wrote:
> On 11 April 2018 at 04:02, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>> This commit adds a dt-bindings document of PECI adapter driver for Aspeed
> 
> We try to capitalise ASPEED.
> 

Got it. Will capitalize all Aspeed words.

>> AST24xx/25xx SoCs.
>> ---
>>   .../devicetree/bindings/peci/peci-aspeed.txt       | 60 ++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
>>
>> diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> new file mode 100644
>> index 000000000000..4598bb8c20fa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
>> @@ -0,0 +1,60 @@
>> +Device tree configuration for PECI buses on the AST24XX and AST25XX SoCs.
>> +
>> +Required properties:
>> +- compatible        : Should be "aspeed,ast2400-peci" or "aspeed,ast2500-peci"
>> +                     - aspeed,ast2400-peci: Aspeed AST2400 family PECI
>> +                                            controller
>> +                     - aspeed,ast2500-peci: Aspeed AST2500 family PECI
>> +                                            controller
>> +- reg               : Should contain PECI controller registers location and
>> +                     length.
>> +- #address-cells    : Should be <1>.
>> +- #size-cells       : Should be <0>.
>> +- interrupts        : Should contain PECI controller interrupt.
>> +- clocks            : Should contain clock source for PECI controller.
>> +                     Should reference clkin.
> 
> Are you sure that this is driven by clkin? Most peripherals on the
> Aspeed are attached to the apb, so should reference that clock.
> 

According to the datasheet, PECI controller module is attached to apb 
but its clock source is the 24MHz external clock.

>> +- clock_frequency   : Should contain the operation frequency of PECI controller
>> +                     in units of Hz.
>> +                     187500 ~ 24000000
> 
> Can you explain why you need both the parent clock and this frequency
> to be specified?
> 

Based on this setting, driver code makes clock divisor value to set 
operation clock of PECI controller which is adjustable.

>> +
>> +Optional properties:
>> +- msg-timing-nego   : Message timing negotiation period. This value will
> 
> Perhaps msg-timing-period? Or just msg-timing?
> 

Will use msg-timing instead.

>> +                     determine the period of message timing negotiation to be
>> +                     issued by PECI controller. The unit of the programmed
>> +                     value is four times of PECI clock period.
>> +                     0 ~ 255 (default: 1)
>> +- addr-timing-nego  : Address timing negotiation period. This value will
>> +                     determine the period of address timing negotiation to be
>> +                     issued by PECI controller. The unit of the programmed
>> +                     value is four times of PECI clock period.
>> +                     0 ~ 255 (default: 1)
>> +- rd-sampling-point : Read sampling point selection. The whole period of a bit
>> +                     time will be divided into 16 time frames. This value will
>> +                     determine the time frame in which the controller will
>> +                     sample PECI signal for data read back. Usually in the
>> +                     middle of a bit time is the best.
>> +                     0 ~ 15 (default: 8)
>> +- cmd_timeout_ms    : Command timeout in units of ms.
>> +                     1 ~ 60000 (default: 1000)
>> +
>> +Example:
>> +       peci: peci at 1e78b000 {
>> +               compatible = "simple-bus";
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               ranges = <0x0 0x1e78b000 0x60>;
>> +
>> +               peci0: peci-bus at 0 {
>> +                       compatible = "aspeed,ast2500-peci";
>> +                       reg = <0x0 0x60>;
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       interrupts = <15>;
>> +                       clocks = <&clk_clkin>;
>> +                       clock-frequency = <24000000>;
>> +                       msg-timing-nego = <1>;
>> +                       addr-timing-nego = <1>;
>> +                       rd-sampling-point = <8>;
>> +                       cmd-timeout-ms = <1000>;
>> +               };
>> +       };
>> --
>> 2.16.2
>>
