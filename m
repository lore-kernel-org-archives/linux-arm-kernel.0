From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Tue, 17 Jun 2014 19:59:35 +0300
Subject: [RFC PATCH 1/4] memory: tegra124-emc: Add EMC driver
In-Reply-To: <53A069B6.6070902@wwwdotorg.org>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1402925713-25426-2-git-send-email-tomeu.vizoso@collabora.com>
 <539F4D44.3070309@wwwdotorg.org> <53A03186.3040703@collabora.com>
 <53A069B6.6070902@wwwdotorg.org>
Message-ID: <53A073F7.20700@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2014 07:15 PM, Stephen Warren wrote:
> On 06/17/2014 06:16 AM, Tomeu Vizoso wrote:
>> On 06/16/2014 10:02 PM, Stephen Warren wrote:
>>> On 06/16/2014 07:35 AM, Tomeu Vizoso wrote:
>
>>> This binding looks quite anaemic vs.
>>> Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt; I
>>> would expect that this binding needs all the EMC register data from the
>>> tegra20-emc binding too. Can the two bindings be identical?
>>
>> There's even less stuff needed right now, as all what ultimately the EMC
>> driver does is call clk_set_rate on the EMC clock. As the T124 EMC
>> driver gains more features, they should get more similar.
>
> IIRC, even changing the EMC clock rate requires modifying the memory
> controller's programming (e.g. delays/taps/tuning etc.). That's exactly
> what the more complex stuff in the nvidia,tegra20-emc.txt is all about.
> I not convinced that a driver that just modifies the clock rate without
> adjusting the EMC programming will work reliably.

Indeed, changing the EMC clock rate is a somewhat complicated sequence 
of ~10 steps. The kernel even won't let one the rate be change directly, 
as the change would be propagated to PLL_M which cannot have its rate 
changed while it is enabled. I suppose the sequence should be hidden in 
the EMC clk's set_rate implementation, which I guess would leave just 
the rate policy to this driver.
