From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 May 2015 17:22:34 -0700
Subject: [PATCHv3 2/4] clk: socfpga: add a clock driver for the Arria
 10 platform
In-Reply-To: <555BC352.4000302@opensource.altera.com>
References: <1431011523-10049-1-git-send-email-dinguyen@opensource.altera.com>
 <1431011523-10049-3-git-send-email-dinguyen@opensource.altera.com>
 <20150516005235.GP31753@codeaurora.org>
 <555B64FE.40104@opensource.altera.com> <555BB016.8000506@codeaurora.org>
 <555BC352.4000302@opensource.altera.com>
Message-ID: <555BD3CA.6000202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/15 16:12, Dinh Nguyen wrote:
>
> On 5/19/15 4:50 PM, Stephen Boyd wrote:
>> On 05/19/15 09:29, Dinh Nguyen wrote:
>>> On 5/15/15 7:52 PM, Stephen Boyd wrote:
>>>> On 05/07, dinguyen at opensource.altera.com wrote:
>>>>> +
>>>>> +static int socfpga_clk_prepare(struct clk_hw *hwclk)
>>>>> +{
>>>>> +	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
>>>>> +	struct regmap *sys_mgr_base_addr;
>>>>> +	int i;
>>>>> +	u32 hs_timing;
>>>>> +	u32 clk_phase[2];
>>>>> +
>>>>> +	if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
>>>>> +		sys_mgr_base_addr = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
>>>>> +		if (IS_ERR(sys_mgr_base_addr)) {
>>>> Is there a reason the syscon is grabbed lazily in prepare? Why
>>>> not get it before registering this clock?
>>> This syscon node is only associated with clocks that have a clk-phase
>>> property, which on the SoCFPGA platform, is the SD/MMC clocks. The way
>>> to implement this went through quite a few rounds of discussion for the
>>> Cyclone5/Arria5 platform before settling to this method.
>>>
>>> The reason why syscon is grabbed here is that the setting of the clock
>>> phase must be done before enabling of the clock, so it seem that prepare
>>> was a good place. Should this be move moved to the socfpga_gate_init()
>>> instead?
>> I was expecting the regmap to be found before the clock is registered
>> and stored away into the  socfpga_gate_clk structure. Getting the regmap
>> during prepare is akin to ioremapping a register region during prepare,
>> which doesn't sound right at all. Maybe there's some good reason in the
>> earlier discussions? Any hints?
>>
> Ah okay, the earlier discussions revolve mainly around moving the regmap
> from the SD/MMC driver into the clock driver. But there weren't any
> issue raised for putting the regmap in the prepare function.
>
> If you're curious, here are the links to the discussion for adding the
> clk-phase to the driver:
>
> http://archive.arm.linux.org.uk/lurker/message/20131212.203042.d37c8ee9.en.html
>
> http://archive.arm.linux.org.uk/lurker/message/20140109.213116.1f13b27a.en.html
>
> But perhaps putting the regmap lookup in the init function is the
> correct way to do this?

Yes that would seem more appropriate. I suspect this lazy approach is
done because syscon isn't ready when of_clk_init() runs though. If this
was written to be a proper device driver with probe defer support this
wouldn't be a problem.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
