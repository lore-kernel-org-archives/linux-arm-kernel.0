From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Thu, 27 Mar 2014 08:58:11 +0100
Subject: [PATCH] clk: register fixed-clock only if #clock-cells property
 is present
In-Reply-To: <CAOMZO5AEry8sJW_+0aJS8ush+sYPPWk9LRU0b8RUUGa-hO_G1A@mail.gmail.com>
References: <1395858127-18730-1-git-send-email-s.nawrocki@samsung.com>	<CAOMZO5DJPKvha7A-foktsB2dEw9xGXL_++uBXj_3ScAPTXNOkw@mail.gmail.com>	<53333145.4080903@gmail.com>
 <CAOMZO5AEry8sJW_+0aJS8ush+sYPPWk9LRU0b8RUUGa-hO_G1A@mail.gmail.com>
Message-ID: <5333DA13.2080505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 26/03/2014 21:14, Fabio Estevam a ?crit :
> On Wed, Mar 26, 2014 at 4:57 PM, Sylwester Nawrocki
> <sylvester.nawrocki@gmail.com> wrote:
>
>> Perhaps a change as below helps ?
>>
>>  From 85ee85e4a92b42442354f3f2454be50c173e1c59 Mon Sep 17 00:00:00 2001
>> From: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Date: Wed, 26 Mar 2014 20:54:13 +0100
>> Subject: [PATCH] clk: reverse default clk provider initialization order in
>> of_clk_init()
>>
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>   drivers/clk/clk.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index fb3c40b..d30809c 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -2608,7 +2608,7 @@ void __init of_clk_init(const struct of_device_id
>> *matches)
>>
>>                  parent->clk_init_cb = match->data;
>>                  parent->np = np;
>> -               list_add(&parent->node, &clk_provider_list);
>> +               list_add_tail(&parent->node, &clk_provider_list);
>>          }
>>
>>          while (!list_empty(&clk_provider_list)) {
> Thanks, Sylwester!
>
> This makes my imx6q-wandboard to boot again.
>
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

This solution solve the problem for this specific case because clks are
declared in the correct order in imx DTs.
But, even with your patch I think we could see similar issues by 
reordering DT
nodes...

The real problem here is that imx platform does not declare the CCM clocks
dependencies upon ckil, ckih1 and osc fixed clocks within the DT [1], and
retrieve these clocks when initializing the CCM clocks ([2] and [3]).

We should try to a add these dependencies in the DT and see if it works.

[1] http://lxr.free-electrons.com/source/arch/arm/boot/dts/imx6sl.dtsi#L379
[2] http://lxr.free-electrons.com/source/arch/arm/mach-imx/clk-imx6q.c#L151
[3] http://lxr.free-electrons.com/source/arch/arm/mach-imx/clk.c#L30

Best Regards,

Boris
