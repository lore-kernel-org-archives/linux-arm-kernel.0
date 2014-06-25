From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 25 Jun 2014 12:50:42 +0200
Subject: [PATCH v2 0/4] Add support for Exynos clock output configuration
In-Reply-To: <026001cf9061$5fef9d00$1fced700$@samsung.com>
References: <1403626107-12073-1-git-send-email-t.figa@samsung.com>
 <026001cf9061$5fef9d00$1fced700$@samsung.com>
Message-ID: <53AAA982.9050308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 25.06.2014 12:36, Kukjin Kim wrote:
> Tomasz Figa wrote:
>>
> Hi Tomasz,
> 
>> On all Exynos SoCs there is a dedicated CLKOUT pin that allows many of
>> internal SoC clocks to be output from the SoC. The hardware structure
> 
> Yeah, because the CLKOUT pin is used for measure of the clock for debug on all
> of exynos SoCs commonly.
> 
>> of CLKOUT related clocks looks as follows:
>>
>> 	CMU	|---> clock0 --------->	|	PMU	|
>> 		|			|		|
>>     several	|---> clock1 ---------> |	mux	|
>>     muxes	|			|	+	|---> CLKOUT
>>     dividers	|       ...		|	gate	|
>>     and gates	|			|		|
>> 		|---> clockN ---------> |		|
>>
>> Since the block responsible for handling the pin is PMU, not CMU,
>> a separate driver, that binds to PMU node is required and acquires
>> all input clocks by standard DT clock look-up. This way we don't need
>> any cross-IP block drivers and cross-driver register sharing or
>> nodes for fake devices.
>>
> BTW, upcoming exynos5 SoCs have two muxs for CLKOUT and each mux is controlled
> by CMU and PMU, so
> 
> The mux1 for CLKOUT in CMU is used to decide which clock in each sub-domain
> will be out and the mux2 in PMU is used to decide which sub-domain will be out
> via CLKOUT. So I want you to consider of all of exynos SoCs including upcoming
> SoCs.

Is it something similar to what I implemented for Exynos4 in patch 2/4?
The same has to be done for other Exynos SoCs as well, but i don't have
any board on which I could test this, so I just added a subset of
available inputs of PMU mux in current implementation.

Anyway, anything in CMU can be handled in normal SoC clock driver, so I
don't think this poses any problem for this series.

Best regards,
Tomasz
