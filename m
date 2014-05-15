From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 15 May 2014 09:44:55 +0100
Subject: [PATCH v4 2/6] dt-bindings: add mtk-timer bindings
In-Reply-To: <cebe44ba-c543-4f4a-9aeb-810156fe8250@BN1AFFO11FD036.protection.gbl>
References: <1400087579-4250-1-git-send-email-matthias.bgg@gmail.com>
 <1400087579-4250-3-git-send-email-matthias.bgg@gmail.com>
 <cebe44ba-c543-4f4a-9aeb-810156fe8250@BN1AFFO11FD036.protection.gbl>
Message-ID: <CABuKBeL7yeXbxmBE=+ar3dsHRNs1oscYDSPPs+RnGsM8eJs5PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I did not realize that Android gmail app sends HTML mails.
So I send the comments below accidentally as HTML mail yesterday.
Sorry for that.

2014-05-14 18:44 GMT+01:00 S?ren Brinkmann <soren.brinkmann@xilinx.com>:
> Hi Matthias,
>
> On Wed, 2014-05-14 at 07:12PM +0200, Matthias Brugger wrote:
>> Add binding documentation for the General Porpose Timer driver of
>> the Mediatek SoCs.
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>  .../devicetree/bindings/timer/mediatek,mtk-timer.txt   | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>>
>> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> new file mode 100644
>> index 0000000..938adf6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
>> @@ -0,0 +1,18 @@
>> +Mediatek MT6589, MT6577 and MT6572 Timers
>> +---------------------------------------
>> +
>> +Required properties:
>> +- compatible: Should be "mediatek,mtk6589-timer"
>
> Don't you want compatible strings for the other supported SOCs too?

I'm not sure if it makes sense to define the compatible strings for
all the SoCs that have this timer as it's actually totally the same
IP.

In other cases e.g. the arm gic, not all compatible strings are
defined, that's why I use cortex-a15-gic in the dtsi although I'm
using a cortex A7 SoC.

I would instead say, that the SoC version of the compatible string,
mt6589, is something arbitrary. So I propose to use the first known
SoC which uses the timer. That would be AFAIK mt6577.

>
>> +- reg: Should contain location and length for timers register.
>> +- clocks: Clocks driving the timer hardware. This list shoud include two
>> +     clocks. The order is system clock and as second clock the RTC clock.
>
> Sorry for being pedantic, but we had so many ugly bindings in our vendor
> tree. I'm still getting caught up on the clocks. I have the feeling the SOC
> has two clocks (system and rtc) which are used to drive this timer,
> while the timer probably refers differently to its clock inputs.
> If this was the case, the names 'rtc' and 'system' clock are SOC specific
> names/implementation details. From the timer perspective it is probably
> just important that it receives two clock inputs. Since the timer is
> described here and not the SOC, these SOC specific names should
> disappear and be replaced with the names the timer IP uses for its input
> clocks.

The timer is exactly identically described in the three SoC
datasheets. In the description the clocks are called system and RTC,
so I think we are on the safe side here. :)

>
> The clock-names should be listed too, probably as optional properties.

This will lead to a problem, as the clock-names description includes
the order of the clocks. If we make this property optional, it can be
easily missunderstood. So I propose to do it the way other drivers in
the kernel (e.g. arm,sp804) do it and leave the clock-names property
as it is.

>
>> +
>> +Examples:
>> +
>> +     timer {
>> +             compatible = "mediatek,mtk6589-timer";
>> +             reg = <0x10008000 0x80>;
>> +             interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
>> +             clocks = <&system_clk>, <&rtc_clk>;
>> +             clock-names = "system-clk", "rtc-clk";
>
>
>         S?ren



-- 
motzblog.wordpress.com
