From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 26 May 2014 12:36:38 +0800
Subject: [PATCH 17/22] mfd: sun6i-prcm: Add support for Allwinner A23 PRCM
In-Reply-To: <20140525191434.GX10768@lukather>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-18-git-send-email-wens@csie.org>
 <20140525191434.GX10768@lukather>
Message-ID: <CAGb2v66cV_nRpHhrtDUYzncO5wimx+vRBW6BFcU0Kz=bKkNs+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 3:14 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, May 23, 2014 at 03:51:20PM +0800, Chen-Yu Tsai wrote:
>> The Allwinner A23 SoC has a PRCM unit like the previous A31 SoC.
>> The differences are the AR100 clock can no longer be modified,
>> and the APB0 clock has different divisors.
>>
>> This patch adds a compatible with a modified subdevice list for
>> the A23.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  .../devicetree/bindings/mfd/sun6i-prcm.txt         |  2 +-
>>  drivers/mfd/sun6i-prcm.c                           | 30 ++++++++++++++++++++++
>>  2 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
>> index 1f5a31f..03c5a55 100644
>> --- a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
>> +++ b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
>> @@ -4,7 +4,7 @@ PRCM is an MFD device exposing several Power Management related devices
>>  (like clks and reset controllers).
>>
>>  Required properties:
>> - - compatible: "allwinner,sun6i-a31-prcm"
>> + - compatible: "allwinner,sun6i-a31-prcm" or "allwinner,sun8i-a23-prcm"
>>   - reg: The PRCM registers range
>>
>>  The prcm node may contain several subdevices definitions:
>> diff --git a/drivers/mfd/sun6i-prcm.c b/drivers/mfd/sun6i-prcm.c
>> index 718fc4d..c96bb6c 100644
>> --- a/drivers/mfd/sun6i-prcm.c
>> +++ b/drivers/mfd/sun6i-prcm.c
>> @@ -76,16 +76,46 @@ static const struct mfd_cell sun6i_a31_prcm_subdevs[] = {
>>       },
>>  };
>>
>> +static const struct mfd_cell sun8i_a23_prcm_subdevs[] = {
>> +     {
>> +             .name = "sun6i-a31-apb0-clk",
>> +             .of_compatible = "allwinner,sun8i-a23-apb0-clk",
>> +             .num_resources = ARRAY_SIZE(sun6i_a31_apb0_clk_res),
>> +             .resources = sun6i_a31_apb0_clk_res,
>> +     },
>> +     {
>> +             .name = "sun6i-a31-apb0-gates-clk",
>> +             .of_compatible = "allwinner,sun6i-a31-apb0-gates-clk",
>> +             .num_resources = ARRAY_SIZE(sun6i_a31_apb0_gates_clk_res),
>> +             .resources = sun6i_a31_apb0_gates_clk_res,
>> +     },
>
> Did I just have a brainfart, or didn't you just introduced an
> sun8i-a23-apb0-gates-clk driver?

My bad, I missed this one. The one in the DT is correct.
It actually works, so I'm a bit confused here.
Which one does the driver core actually use?

> And there's no ar100 and ahb0 clocks ?

The ahb0 is a fixed-factor (1:1) clock. There are no controls for it.
The ar100 clock on the A23 has no controls either, so fixed-factor
clock again.


Thanks,
ChenYu
