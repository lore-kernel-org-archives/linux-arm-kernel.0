From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 08 Jul 2014 16:04:17 +0200
Subject: [PATCH v2 0/4] Add support for Exynos clock output configuration
In-Reply-To: <20140703001452.7440.8476@quantum>
References: <1403626107-12073-1-git-send-email-t.figa@samsung.com>
 <026001cf9061$5fef9d00$1fced700$@samsung.com>
 <20140703001452.7440.8476@quantum>
Message-ID: <53BBFA61.1030602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.07.2014 02:14, Mike Turquette wrote:
> Quoting Kukjin Kim (2014-06-25 03:36:51)
>> Tomasz Figa wrote:
>>>
>> Hi Tomasz,
>>
>>> On all Exynos SoCs there is a dedicated CLKOUT pin that allows many of
>>> internal SoC clocks to be output from the SoC. The hardware structure
>>
>> Yeah, because the CLKOUT pin is used for measure of the clock for debug on all
>> of exynos SoCs commonly.
>>
>>> of CLKOUT related clocks looks as follows:
>>>
>>>       CMU     |---> clock0 ---------> |       PMU     |
>>>               |                       |               |
>>>     several   |---> clock1 ---------> |       mux     |
>>>     muxes     |                       |       +       |---> CLKOUT
>>>     dividers  |       ...             |       gate    |
>>>     and gates |                       |               |
>>>               |---> clockN ---------> |               |
>>>
>>> Since the block responsible for handling the pin is PMU, not CMU,
>>> a separate driver, that binds to PMU node is required and acquires
>>> all input clocks by standard DT clock look-up. This way we don't need
>>> any cross-IP block drivers and cross-driver register sharing or
>>> nodes for fake devices.
>>>
>> BTW, upcoming exynos5 SoCs have two muxs for CLKOUT and each mux is controlled
>> by CMU and PMU, so
>>
>> The mux1 for CLKOUT in CMU is used to decide which clock in each sub-domain
>> will be out and the mux2 in PMU is used to decide which sub-domain will be out
>> via CLKOUT. So I want you to consider of all of exynos SoCs including upcoming
>> SoCs.
> 
> clkout for debug is very useful indeed. For SoCs with high speed clocks
> that I have worked with, I have often observed that the clkout logic
> introduces buffers or dividers. This is needed so that you can get a
> (relatively) clean clock signal on your oscilloscope. Otherwise that
> 2GHz ARM clk is just going to be noise ;-)
> 
> These divider values can modeled in the clk framework. Do you know if
> you have such stuff on your chip?

I believe this is what I have already implemented in my series.

The final CLKOUT mux and gates are implemented by separate driver,
because they reside in another IP block, while per-domain CLKOUT
dividers along with muxes and gates are registered by normal SoC clock
driver, because they are part of the clock controller. See patch 2/4
adding the whole hierarchy for Exynos4 SoCs.

I don't have boards to test CLKOUT on Exynos5 SoCs, so they are up to
interested people.

Best regards,
Tomasz
