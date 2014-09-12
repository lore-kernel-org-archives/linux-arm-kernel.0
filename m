From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 12 Sep 2014 10:10:25 +0800
Subject: [PATCH 6/7] ARM: dts: sun6i: Add required ahb1 clock parent and
 rates for dma controller
In-Reply-To: <20140911211531.GN31276@lukather>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
 <1410000448-9999-7-git-send-email-wens@csie.org>
 <20140911211531.GN31276@lukather>
Message-ID: <CAGb2v64+RxJ52DzawhAtYCn=sw+28e4Q11jzG02KQE=8hxa0tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 5:15 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Sep 06, 2014 at 06:47:27PM +0800, Chen-Yu Tsai wrote:
>> The DMA controller requires AHB1 bus clock to be clocked from PLL6.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sun6i-a31.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
>> index 8eb2c6d..1117989 100644
>> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
>> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
>> @@ -317,6 +317,11 @@
>>                       clocks = <&ahb1_gates 6>;
>>                       resets = <&ahb1_rst 6>;
>>                       #dma-cells = <1>;
>> +
>> +                     /* DMA controller requires AHB1 clocked from PLL6 */
>> +                     assigned-clocks = <&ahb1>;
>> +                     assigned-clock-parents = <&pll6>;
>> +                     assigned-clock-rates = <200000000>;
>
> Where did you get that from?
>
> The user manual says that it should be clocked at 600MHz, and I'm not
> sure it should be enforced there either.

The bindings mean that ahb1 should be clocked from pll6 and at 200 MHz,
not "pll6 should be 200 MHz". I assume you were misled by them.

Clocking ahb1 from pll6 and at 200 MHz with the /3 pre-divider is the
vendor BSP default:

On sun6i, the clock init code calls aw_ccu_switch_ahb_2_pll6(), which muxes
ahb1 from pll6 with the highest dividers, then sets the rate for ahb1 to
pll6, which sets pre-divider to /3 and divider to /1.

Hope this clears it up. :)


Cheers
ChenYu
