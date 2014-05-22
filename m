From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 22 May 2014 12:34:40 +0200
Subject: [PATCH 3/4] clk: samsung: Add driver to control CLKOUT line on
 Exynos SoCs
In-Reply-To: <537D8788.8030904@linaro.org>
References: <1400604211-9447-1-git-send-email-t.figa@samsung.com>
 <1400604211-9447-4-git-send-email-t.figa@samsung.com>
 <537D8788.8030904@linaro.org>
Message-ID: <537DD2C0.4060802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.05.2014 07:13, Tushar Behera wrote:
> On 05/20/2014 10:13 PM, Tomasz Figa wrote:
>> This patch introduces a driver that handles configuration of CLKOUT pin
>> of Exynos SoCs that can be used to output certain clocks from inside of
>> the SoC to a dedicated output pin.
>>
>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>> ---
>>  .../devicetree/bindings/arm/samsung/pmu.txt        |  30 ++++
>>  drivers/clk/samsung/Makefile                       |   1 +
>>  drivers/clk/samsung/clk-exynos-clkout.c            | 153 +++++++++++++++++++++
>>  3 files changed, 184 insertions(+)
>>  create mode 100644 drivers/clk/samsung/clk-exynos-clkout.c
>>
> 
> [ ... ]
> 
>> +	clkout->clk_table[0] = clk_register_composite(NULL, "clkout",
>> +				parent_names, parent_count, &clkout->mux.hw,
>> +				&clk_mux_ops, NULL, NULL, &clkout->gate.hw,
>> +				&clk_gate_ops, CLK_SET_RATE_PARENT
>> +				| CLK_SET_RATE_NO_REPARENT);
> 
> Would you please remove CLK_SET_RATE_NO_REPARENT flag from here? Let me
> know if you have reservations against this.

The problem with clock reparenting is that there are certain parent
clocks of CLKOUT, rate of which changes at runtime, e.g. clocks derived
from APLL or bus clocks, which can be reconfigured by cpufreq or devfreq.

> 
> With RFC patches, I am able to do a clk_set_rate() on this clock to
> get a 24MHz output to the codec clock. With this flag set, I again have
> to rely on the default value set to this register in bootloader.
> 

This problem should be handled by initializing clocks from DT. I'm not
sure why it hasn't been implemented yet...

Best regards,
Tomasz
