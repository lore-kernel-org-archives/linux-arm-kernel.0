From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 28 May 2015 09:02:34 +0200
Subject: [PATCH v3 5/6] doc: dt: add documentation for lpc1850-ccu clk
 driver
In-Reply-To: <20150528034555.22384.65723@quantum>
References: <1431988559-23338-1-git-send-email-manabian@gmail.com>
 <1431988559-23338-6-git-send-email-manabian@gmail.com>
 <20150528034555.22384.65723@quantum>
Message-ID: <CAGhQ9VysK17Qy+LSTr6otz_JFY-GbD6C+D5OszSQiYErcPjMAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 May 2015 at 05:45, Michael Turquette <mturquette@linaro.org> wrote:
> Quoting Joachim Eastwood (2015-05-18 15:35:58)
>> Add DT binding documentation for lpc1850-ccu clk driver.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>>  .../devicetree/bindings/clock/lpc1850-ccu.txt      | 146 +++++++++++++++++++++
>>  1 file changed, 146 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/lpc1850-ccu.txt
>>
>> diff --git a/Documentation/devicetree/bindings/clock/lpc1850-ccu.txt b/Documentation/devicetree/bindings/clock/lpc1850-ccu.txt
>> new file mode 100644
>> index 000000000000..aca46805c10a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/lpc1850-ccu.txt
>> @@ -0,0 +1,146 @@
>> +* NXP LPC1850 Clock Control Unit (CCU)
>> +
>> +Each CGU base clock has several clock branches which can be turned on
>> +or off independently by the Clock Control Units CCU1 or CCU2. The
>> +branch clocks are distributed between CCU1 and CCU2.
>> +
>> + - Above text taken from NXP LPC1850 User Manual.
>> +
>> +This binding uses the common clock binding:
>> +    Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +Required properties:
>> +- compatible:
>> +       Should be "nxp,lpc1850-ccu"
>> +- reg:
>> +       Shall define the base and range of the address space
>> +       containing clock control registers
>> +- #clock-cells:
>> +       Shall have value <1>.  The permitted clock-specifier values
>> +       are the branch clock names defined in table below.
>> +- clocks:
>> +       Shall contain a list of phandles for the base clocks routed
>> +       from the CGU to the specific CCU. See mapping of base clocks
>> +       and CCU in table below.
>> +
>> +Which brach clocks that are available on the CCU depends on the
>> +specific LPC part.
>> +
>> +CCU1 branch clocks:
>> +Base clock     Branch clock            Description
>> +BASE_APB3_CLK  CLK_APB3_BUS            APB3 bus clock.
>> +               CLK_APB3_I2C1           Clock to the I2C1 register interface
>> +                                       and I2C1 peripheral clock.
>
> You don't need to make these explicit here. Just specify that the header
> containing these constants is located at
> nclude/dt-bindings/clock/lpc18xx-ccu.h
>
> (DT people please correct me if this is bad etiquette)

Okey, I'll ditch it for v4 unless someone yells out.

>> +
>> +Not all branch clocks are available on all LPC parts. Check the user
>> +manual for your specific part.
>
> How many varieties of LPC part are there?

Being a micro controller there are a lot of parts with small
variations in peripherals and Flash sizes.
For the clock stuff; the LPC43xx series added 3 base clocks to the CCU
over the LPC18xx series. One of these clocks is only present on the
LPC4370.

So for the CGU base clocks there aren't a whole lot of variants I guess.

>Should these varieties each have their own .dtsi that make it clear
>which branch clocks are available on that part?

Good question.

For now my approach have been to stick everything in one common file
(lpc18xx.dtsi), but this can be changed of course. Right now I think
we should just wait and see which parts that are added to mainline and
then split things as required.

regards,
Joachim Eastwood
