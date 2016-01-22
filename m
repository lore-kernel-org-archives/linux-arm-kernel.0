From: zhengxing@rock-chips.com (Xing Zheng)
Date: Fri, 22 Jan 2016 15:49:08 +0800
Subject: [PATCH] clk: rockchip: rk3036: Add apll as the critical clock
In-Reply-To: <7538210.fX6mmzZ75v@phil>
References: <1453279037-23971-1-git-send-email-zhengxing@rock-chips.com>
 <7538210.fX6mmzZ75v@phil>
Message-ID: <56A1DEF4.2070409@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 2016?01?21? 17:21, Heiko Stuebner wrote:
> Hi Xing,
>
> Am Mittwoch, 20. Januar 2016, 16:37:17 schrieb Xing Zheng:
>> The apll may be closed if there are some child clock nodes below
>> it when the device startup. Therefore, the apll should be keep
>> critical.
>>
>> The apll tree like this:
>>      pll_apll
>>         apll
>>            armclk
>>               pclk_dbg
>>               aclk_core_pre
>>            aclk_hvec
>>            uart_pll_clk
>>               uart2_src
>>                  uart2_frac
>>               uart1_src
>>                  uart1_frac
>>               uart0_src
>>                  uart0_frac
> can you find out which of those clocks does cause your hang?
> Because things like the uart-clocks for example should be handled by their
> driver already, at the time the clk_disable_unused runs(). So I'd really
> like the critical clock to be the actually needed clock.
>
> Thanks
> Heiko

It looks like that we call the rockchip_rk3036_pll_disable cause the 
apll is diabled.
I think the diabled tracing like this:
1. All of uart0_frac~uart2_frac are branch_fraction_divider type, they 
have CLK_SET_RATE_UNGATE flag,
2. I enable cpufreq configs on the rk3036_defconfig, the default cpu 
freq is 600MHz durning loader, when startup it is 816MHz with default DTS.
Therefore, cpu freq will be change rate 600MHz to 816MHz then call 
clk_change_rate.
3. With the flag CLK_SET_RATE_UNGATE, triggering call clk_core_disable. 
In here, it will recursively close all of uart gates, finally, to call 
the root
parent diable callback that is rockchip_rk3036_pll_disable.

The disble log:
[ 1.074186] clk_change_rate -- CLK_SET_RATE_UNGATE name: uart2_frac, 
parent: uart2_src, core->flags = 0x00000424
[ 1.105722] clk_gate_endisable -- name: uart2_frac, parent: uart2_src, 
enable = 0
[ 1.110125] clk_gate_endisable -- name: uart2_src, parent: uart_pll_clk, 
enable = 0
[ 2.604445] rockchip_rk3036_pll_disable -- name: pll_apll, parent: xin24m

Therefore, I am considering uart_pll_clk hang onto gpll, or add it into 
the critical clock replace using apll...

If there are some mistake, please correct me. :-)

Thanks.

>
>
>> Signed-off-by: Xing Zheng<zhengxing@rock-chips.com>
>> ---
>>
>>   drivers/clk/rockchip/clk-rk3036.c |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/rockchip/clk-rk3036.c
>> b/drivers/clk/rockchip/clk-rk3036.c index ebce980..483913b 100644
>> --- a/drivers/clk/rockchip/clk-rk3036.c
>> +++ b/drivers/clk/rockchip/clk-rk3036.c
>> @@ -425,6 +425,7 @@ static struct rockchip_clk_branch
>> rk3036_clk_branches[] __initdata = { };
>>
>>   static const char *const rk3036_critical_clocks[] __initconst = {
>> +	"apll",
>>   	"aclk_cpu",
>>   	"aclk_peri",
>>   	"hclk_peri",
>
>
>
