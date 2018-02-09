From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 09 Feb 2018 16:36:50 +0900
Subject: [PATCH 2/3] clk: exynos5433: Allow audio subsystem clock rate
 propagation
In-Reply-To: <3fcfad37-4c8f-7375-b2c2-5154607aa47a@samsung.com>
References: <20180205142230.9755-1-s.nawrocki@samsung.com>
 <CGME20180205142308epcas2p376f8656f7e421f8474938de788cea8db@epcas2p3.samsung.com>
 <20180205142230.9755-2-s.nawrocki@samsung.com>
 <5A7929C1.8040706@samsung.com>
 <3fcfad37-4c8f-7375-b2c2-5154607aa47a@samsung.com>
Message-ID: <5A7D4F92.100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 2018? 02? 08? 00:18, Sylwester Nawrocki wrote:
> Hi Chanwoo,
> 
> On 02/06/2018 05:06 AM, Chanwoo Choi wrote:
>>>  drivers/clk/samsung/clk-exynos5433.c | 22 +++++++++++-----------
>>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
>>> index 74b70ddab4d6..d74361736e64 100644
>>> --- a/drivers/clk/samsung/clk-exynos5433.c
>>> +++ b/drivers/clk/samsung/clk-exynos5433.c
>>> @@ -246,14 +246,14 @@ static const struct samsung_fixed_rate_clock top_fixed_clks[] __initconst = {
>>>  
>>>  static const struct samsung_mux_clock top_mux_clks[] __initconst = {
>>>  	/* MUX_SEL_TOP0 */
>>> -	MUX(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
>>> -			4, 1),
>>> +	MUX_F(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
>>> +	      4, 1, CLK_SET_RATE_PARENT, 0),
>>
>> If you add CLK_SET_RATE_PARENT to 'mout_aud_pll' and mout_aud_pll changes the rate,
>> fout_aud_pll's rate will be changed. But, fout_aud_pll is also the parent
>> of 'mout_aud_pll_user'. It might change the rate of children of mout_aud_pll_user.
>> mout_aud_pll_user would not want to change the parent's clock.
>>
>>     fout_aud_pll                          2            2   196608009          0 0  
>>        mout_aud_pll_user                  1            1   196608009          0 0  
>>        mout_aud_pll                       0            0   196608009          0 0  
> 
> I'd say the range of changes is such that the consumers of the affected child 
> clocks can cope and could adjust to the changed frequencies. Those consumer 
> devices are all components/peripherals of the audio subsystem (LPASS) and, 

The mout_aud_pll_user has the child clock of serial_3.
serial_3 was used for bluetooth on TM2. If you change the aud_pll
with CLK_SET_RATE_PARENT, it might affect the bluetooth operation.
The bluetooth is only used for transfering the data.

Actually, I'm not sure that this patch might affect bluetooth operation or not.

> for example, in case of TM2 there is no issues at all with varying the AUD PLL
> frequency depending on the HDMI audio sample rate. The other audio path uses
> the audio CODEC's internal PLL as the root clock source. The AUD PLL frequency
> will need to be adjusted somehow anyway, we could also get the PLL clock 
> directly and set it's rate, instead of relying on that rate propagation 
> algorithm.  I think we could also export a function from the exynos-lpass mfd 
> driver for setting the PLL's rate directly, after listing the AUD PLL clock 
> in the lpass DT node. That would be more flexible API, easier to adopt for 
> various use cases/boards, now we have only TM2. I can't list the PLL clock 
> in the sound node, that would not have passed the DT maintainters' review. 
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
