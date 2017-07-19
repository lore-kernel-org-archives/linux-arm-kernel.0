From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 19 Jul 2017 13:49:59 +0000
Subject: [PATCH v6 3/3] clk: stm32h7: Add stm32h743 clock driver
In-Reply-To: <f8d47ea1-446a-f714-94ce-a819ed9256a3@mleia.com>
References: <1500364414-10021-1-git-send-email-gabriel.fernandez@st.com>
 <1500364414-10021-4-git-send-email-gabriel.fernandez@st.com>
 <f8d47ea1-446a-f714-94ce-a819ed9256a3@mleia.com>
Message-ID: <e704140b-8e89-9dd5-e563-6c82ba8acf23@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimi,

Many thanks for the code review

On 07/18/2017 10:19 PM, Vladimir Zapolskiy wrote:
> Hello Gabriel,
>
> On 07/18/2017 10:53 AM, gabriel.fernandez at st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> This patch enables clocks for STM32H743 boards.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>>
>> for MFD changes:
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>
>> for DT-Bindings
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../devicetree/bindings/clock/st,stm32h7-rcc.txt   |   81 ++
>>   drivers/clk/Makefile                               |    1 +
>>   drivers/clk/clk-stm32h7.c                          | 1522 ++++++++++++++++++++
>>   include/dt-bindings/clock/stm32h7-clks.h           |  165 +++
>>   include/dt-bindings/mfd/stm32h7-rcc.h              |  136 ++
>>   5 files changed, 1905 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>>   create mode 100644 drivers/clk/clk-stm32h7.c
>>   create mode 100644 include/dt-bindings/clock/stm32h7-clks.h
>>   create mode 100644 include/dt-bindings/mfd/stm32h7-rcc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt b/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>> new file mode 100644
>> index 0000000..e41e4ac
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/st,stm32h7-rcc.txt
>> @@ -0,0 +1,81 @@
>> +STMicroelectronics STM32H7 Reset and Clock Controller
>> +=====================================================
>> +
>> +The RCC IP is both a reset and a clock controller.
>> +
>> +Please refer to clock-bindings.txt for common clock controller binding usage.
>> +Please also refer to reset.txt for common reset controller binding usage.
>> +
>> +Required properties:
>> +- compatible: Should be:
>> +  "st,stm32h743-rcc"
>> +
>> +- reg: should be register base and length as documented in the
>> +  datasheet
>> +
>> +- #reset-cells: 1, see below
>> +
>> +- #clock-cells : from common clock binding; shall be set to 1
>> +
>> +- clocks: External oscillator clock phandle
>> +  - high speed external clock signal (HSE)
>> +  - low speed external clock signal (LSE)
>> +  - external I2S clock (I2S_CKIN)
>> +
>> +- st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup domain
>> +  write protection (RTC clock).
>> +
> please make a clear decision if "st,syscfg" property is mandatory or not.
>  From the driver code this property is optional, and the clock driver
> is expected to work properly, if the property is omitted. Do I miss
> anything?
You right, in the driver code it's optional.
I will change it in dt binding documentation.

>
>> diff --git a/drivers/clk/clk-stm32h7.c b/drivers/clk/clk-stm32h7.c
>> new file mode 100644
>> index 0000000..2608c40
>> --- /dev/null
>> +++ b/drivers/clk/clk-stm32h7.c
> [snip]
>
>> +static const char * const ltdc_src[] = {"pll3_r"};
>> +
>> +/* Power domain helper */
>> +static inline void disable_power_domain_write_protection(void)
>> +{
>> +	if (pdrm)
>> +		regmap_update_bits(pdrm, 0x00, (1 << 8), (1 << 8));
>> +}
>> +
>> +static inline void enable_power_domain_write_protection(void)
>> +{
>> +	if (pdrm)
>> +		regmap_update_bits(pdrm, 0x00, (1 << 8), (0 << 8));
> (0 << 8) is zero.
ok

>
>> +}
> IMHO a version below is better:
>
> static inline void enable_power_domain_write_protection(bool enable)
> {
> 	if (pdrm)
> 		regmap_update_bits(pdrm, 0x00, BIT(8), enable ? 0x0: BIT(8));
> }
>
>> +
>> +static inline bool is_enable_power_domain_write_protection(void)
> is_enabled_...
ok

>> +{
>> +	if (pdrm) {
>> +		u32 val;
>> +
>> +		regmap_read(pdrm, 0x00, &val);
>> +
>> +		return !(val & 0x100);
>> +	}
>> +	return 0;
>> +}
> Please replace (1 << 8) and 0x100 all above with a macro or@least
> BIT(8).
ok

>> +
>> +/* Gate clock with ready bit and backup domain management */
>> +struct stm32_ready_gate {
>> +	struct	clk_gate gate;
>> +	u8	bit_rdy;
>> +	u8	backup_domain;
>> +};
>> +
>> +#define to_ready_gate_clk(_rgate) container_of(_rgate, struct stm32_ready_gate,\
>> +		gate)
>> +
>> +#define RGATE_TIMEOUT 10000
>> +
>> +static int ready_gate_clk_enable(struct clk_hw *hw)
>> +{
>> +	struct clk_gate *gate = to_clk_gate(hw);
>> +	struct stm32_ready_gate *rgate = to_ready_gate_clk(gate);
>> +	int dbp_status;
>> +	int bit_status;
>> +	unsigned int timeout = RGATE_TIMEOUT;
>> +
>> +	if (clk_gate_ops.is_enabled(hw))
>> +		return 0;
>> +
>> +	dbp_status = is_enable_power_domain_write_protection();
>> +
>> +	if (rgate->backup_domain && dbp_status)
>> +		disable_power_domain_write_protection();
>> +
>> +	clk_gate_ops.enable(hw);
>> +
>> +	/* We can't use readl_poll_timeout() because we can blocked if
>> +	 * someone enables this clock before clocksource changes.
>> +	 * Only jiffies counter is available. Jiffies are incremented by
>> +	 * interruptions and enable op does not allow to be interrupted.
>> +	 */
>> +	do {
>> +		bit_status = !(readl(gate->reg) & BIT(rgate->bit_rdy));
>> +
>> +		if (bit_status)
>> +			udelay(100);
>> +
>> +	} while (bit_status && --timeout);
>> +
>> +	if (rgate->backup_domain && dbp_status)
>> +		enable_power_domain_write_protection();
>> +
>> +	return bit_status;
>> +}
> I'm not convinced that the repetitive lockless pattern
>
> 	dbp_status = is_enable_power_domain_write_protection();
> 	if (dbp_status)
> 		disable_power_domain_write_protection();
>
> 	do_something();
>
> 	if (dbp_status)
> 		enable_power_domain_write_protection();
>
> is correct in a concurrent environment.
>
> You still have a risk of running do_something() *after* a call of
> enable_power_domain_write_protection().

Humm, after long discussion with the hardware ip owner, he recommended
to disable power domain write protection only one time at the init
(don't disable/enable dynamically).

Then i can suppress this code

	dbp_status = is_enable_power_domain_write_protection();
	if (dbp_status)
		disable_power_domain_write_protection()
...

	if (dbp_status)
		enable_power_domain_write_protection();


Best regards

Gabriel

> The best option for you is either to switch to ordinary power domains
> and use their API or to move the driver to use regmaps, and at least
> in the latter case you don't need to wrap your code by CCF code (!),
> and as a result you don't need to export truly internal to CCF function
> clk_gate_is_enabled().
>
> --
> With best wishes,
> Vladimir
