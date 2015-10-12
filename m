From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 12 Oct 2015 11:18:55 +0200
Subject: [PATCH] arm: dts: Fix audio card detection on peach boards
In-Reply-To: <561B578E.1050308@samsung.com>
References: <1444631169-19468-1-git-send-email-alim.akhtar@samsung.com>
 <561B578E.1050308@samsung.com>
Message-ID: <561B7AFF.1080707@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/15 08:47, Krzysztof Kozlowski wrote:
>> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> > index 8f4d76c..525a93a 100644
>> > --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> > +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
>> > @@ -1056,5 +1056,10 @@
>> >  	timeout-sec = <32>;
>> >  };
>> >  
>> > +&pmu_system_controller {
>
> Please put the node in alphabetical order.
> 
>> > +	assigned-clocks = <&pmu_system_controller 0>;
>> > +	assigned-clock-parents =  <&clock CLK_FIN_PLL>;
>
> I might be missing something here but isn't the first clock of
> pmu_system_controller already a CLK_FIN_PLL? So you are reparenting the
> FIN_PLL to FIN_PLL?

No, it's not, the first PMU consumer clock is indeed CLK_FIN_PLL,
but pmu_system_controller is also a clock provider.  The first output
clock of pmu_system_controller is CLKOUT, it's a composite mux and
gate clock (registered in drivers/clk/samsung /clk-exynos-clkout.c).
So  the above dts change is selecting an external oscillator input of
the CLKOUT mux, i.e. it will route 24 MHz clock signal from the external
oscillator to the CLKOUT output pin, to which audio CODEC is connected
on peach-pit AFAICS.

-- 
Regards,
Sylwester
