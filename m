From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Wed, 18 Dec 2013 22:04:10 -0600
Subject: [RESEND LIST PATCHv7 1/4] clk: socfpga: Add a clk-phase property
 to the "altr, socfpga-gate-clk"
In-Reply-To: <201312182221.46506.arnd@arndb.de>
References: <1387213476-22122-1-git-send-email-dinguyen@altera.com>
 <1387213476-22122-2-git-send-email-dinguyen@altera.com>
 <20131218205636.23538.50735@quantum> <201312182221.46506.arnd@arndb.de>
Message-ID: <52B2703A.8090001@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/18/13 3:21 PM, Arnd Bergmann wrote:
> On Wednesday 18 December 2013, Mike Turquette wrote:
>>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>>> index f936476..616d9ee 100644
>>> --- a/arch/arm/boot/dts/socfpga.dtsi
>>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>>> @@ -413,6 +413,7 @@
>>>                                                 compatible = "altr,socfpga-gate-clk";
>>>                                                 clocks = <&f2s_periph_ref_clk>, <&main_nand_sdmmc_clk>, <&per_nand_mmc_clk>;
>>>                                                 clk-gate = <0xa0 8>;
>>> +                                               clk-phase = <0 3>;
>> Looking at this again, I have a hard time understanding the values in
>> the clk-phase property. You reference some functions in the property
>> definition above, but they are not obvious to me.
>>
>> Additionally I wonder if the binding would better if the clock-phase
>> property was simply the value in degrees. E.g:
>>
>>         clk-phase = <315>;    // 315 degrees
> I would definitely prefer using degrees over an arbitrary enumeration that
> might work on some platforms but not on others.
>
> I'm also a bit skeptical about the idea of putting the phase into the clock
> provider rather than the consumer, given the comments about the
> clk_set_phase() interface earlier. Generally we try to avoid having
> consumer-specific settings in a provider node (for any DT binding,
> not just clocks). Can't you have the same numbers in the dw-mshc
> node instead and let the mmc driver call clk_set_phase instead?
> If every clock has a fixed phase for a given piece of hardware, it
> could even be set automatically by making the common clk code read
> the clk-phase attribute at the time a driver calls clk_get.

So I think this is what you're suggesting:
clocks = <&sdmmc_clk 0 135>, this would specify 0 and 135 degrees phase.

The clock-bindings document is stating that the integer in the clocks
property is
specifying the output number of the clock. Would this approach cause a
conflict and would
need an update to that document/approach?

Dinh

>
> 	Arnd
