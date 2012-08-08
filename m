From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 08 Aug 2012 15:43:29 +0300
Subject: [PATCH 04/11] MFD: twl4030-audio: Add DT support
In-Reply-To: <5022529D.3090406@ti.com>
References: <1344418887-5262-1-git-send-email-peter.ujfalusi@ti.com>
 <1344418887-5262-5-git-send-email-peter.ujfalusi@ti.com>
 <5022529D.3090406@ti.com>
Message-ID: <50225EF1.4010203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On 08/08/2012 02:50 PM, Benoit Cousson wrote:
>> +Required properties:
>> +- compatible : must be "ti,twl4030-audio"
>> +- ti,audio_mclk: Master clock frequency used on the board. Supported
>> +	         frequencies: 19200000, 26000000 and 38400000
> 
> Since you care about the frequency only you can use the generic
> attribute: clock-frequency (in your example, I2C is using it).

I see, I'll use replace the property with clock-frequency.

> That being said, since we do have the clock binding now, maybe we should
> create a clock provider at board level for the sys_clk and thus you will
> just have to create a phandle to it in your audio description.
> 
> In theory OMAP and other components will thus have to use that sys_clock
> reference as well.

And in the driver I would need to do for example:
clkp = clk_get(NULL, "audio_mclk");
clk_rate = clk_get_rate(clkp);
clk_put(clkp);

to get the frequency in this way?
Note that the twl4030-audio stack itself does not handle clocks at the moment
since the clock needed for the audio module is always running (HFCLKIN ->
HFCLKOUT -> AUDIO_MCLK (USB_MCLK)). All of this is within twl4030. Do we
really want to model this?

-- 
P?ter
