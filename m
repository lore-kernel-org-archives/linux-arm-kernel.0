From: alexandre.torgue@gmail.com (Alexandre Torgue)
Date: Wed, 24 Feb 2016 09:40:55 +0100
Subject: [PATCH v2 2/4] Documentation: Bindings: Add STM32 DWMAC glue
In-Reply-To: <CAGhQ9VwsSb-Nb4nQ4Q9=b-Dj_8EhSi=LOK-r4JbKcE=nfODufw@mail.gmail.com>
References: <1456240244-10275-1-git-send-email-alexandre.torgue@gmail.com>
 <1456240244-10275-3-git-send-email-alexandre.torgue@gmail.com>
 <CAGhQ9VwsSb-Nb4nQ4Q9=b-Dj_8EhSi=LOK-r4JbKcE=nfODufw@mail.gmail.com>
Message-ID: <CAJgp7zzrJWuJBQyjRdyU5qg=emCjqWfSPVRhT-D6G6Ho=hJzVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-02-23 23:37 GMT+01:00 Joachim  Eastwood <manabian@gmail.com>:
> Hi Alexandre,
>
> You should copy 'devicetree at vger.kernel.org' on bindings doc. Adding cc here.
>
> On 23 February 2016 at 16:10, Alexandre TORGUE
> <alexandre.torgue@gmail.com> wrote:
>> Signed-off-by: Alexandre TORGUE <alexandre.torgue@gmail.com>
>>
>> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.txt b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
>> new file mode 100644
>> index 0000000..18734b3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.txt
>> @@ -0,0 +1,41 @@
>> +STMicroelectronics STM32 / MCU DWMAC glue layer controller
>> +
>> +This file documents platform glue layer for stmmac.
>> +Please see stmmac.txt for the other unchanged properties.
>> +
>> +The device node has following properties.
>> +
>> +Required properties:
>> +- compatible:  Should be "st,stm32-dwmac" to select glue, and
>> +              "snps,dwmac-3.50a" to select IP vesrion.
>> +- clocks: Should contain the GMAC main clock, and tx clock
>> +- compatible:  Should be "st,stm32-dwmac" to select glue and
>> +              "snps,dwmac-3.50a" to select IP version.
>> +- clocks: Should contain the MAC main clock
>> +- clock-names: Should contain the clock names "stmmaceth".
>> +- st,syscon : Should be phandle/offset pair. The phandle to the syscon node which
>> +             encompases the glue register, and the offset of the control register.
>> +
>> +Optional properties:
>> +- clocks: Could contain:
>> +       - the tx clock,
>> +       - the rx clock
>> +- clock-names: Could contain the clock names "tx-clk", "rx-clk"
>> +
>> +Example:
>> +
>> +               ethernet0: dwmac at 40028000 {
>> +                       device_type = "network";
>
> What is this 'device_type = "network"' for?
> It seems to used in a lot of powerpc DTs, but only a couple of arm DTs.
>
> Maybe Rob could enlighten us?
>
>> +                       compatible = "st,stm32-dwmac", "snps,dwmac-3.50a";
>> +                       status = "disabled";
>> +                       reg = <0x40028000 0x8000>;
>> +                       reg-names = "stmmaceth";
>> +                       interrupts = <0 61 0>, <0 62 0>;
>> +                       interrupt-names = "macirq", "eth_wake_irq";
>> +                       clock-names = "stmmaceth", "tx-clk", "rx-clk";
>> +                       clocks = <&rcc 0 25>, <&rcc 0 26>, <&rcc 0 27>;
>> +                       st,syscon = <&syscfg 0x4>;
>> +                       snps,pbl = <32>;
>
> Regarding snps,pbl; using 32 here might not give you what you would except.
> See comment in dwmac1000_dma_init().
>
> The driver is hard coded to use PBL4X/PBL8X mode. Just a heads up.
>
Hi Joachim,

My fault, It is not working with 32. I will modify it (should be 8 for example)

Regards

Alexandre

>
> regards,
> Joachim Eastwood
