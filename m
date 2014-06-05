From: Ranjani.Vaidyanathan@freescale.com (Ranjani.Vaidyanathan at freescale.com)
Date: Thu, 5 Jun 2014 16:26:26 +0000
Subject: [PATCH] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <538F5C26.1000505@gmail.com>
References: <1397044538-12676-1-git-send-email-festevam@gmail.com>
 <538F4B43.6070804@gmail.com>
 <5f0cb6161f5146cbbc778149015249ce@BY2PR03MB379.namprd03.prod.outlook.com>
 <538F5C26.1000505@gmail.com>
Message-ID: <86ba99b9d58e4235a7a131639c2a0694@BY2PR03MB379.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dirk,

Response below.

Ranjani

-----Original Message-----
From: Dirk Behme [mailto:dirk.behme at gmail.com] 
Sent: Wednesday, June 04, 2014 12:49 PM
To: Vaidyanathan Ranjani-RA5478; Estevam Fabio-R49496
Cc: Fabio Estevam; Guo Shawn-R65073; christian.gmeiner at gmail.com; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH] ARM: imx6: Fix procedure to switch the parent of LDB_DI_CLK

On 04.06.2014 19:29, Ranjani.Vaidyanathan at freescale.com wrote:
> Hi Dirk,
>
> Responses below.
>
> Thanks,
> Ranjani
>
> -----Original Message-----
> From: Dirk Behme [mailto:dirk.behme at gmail.com]
> Sent: Wednesday, June 04, 2014 11:37 AM
> To: Vaidyanathan Ranjani-RA5478; Estevam Fabio-R49496
> Cc: Fabio Estevam; Guo Shawn-R65073; christian.gmeiner at gmail.com; 
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: imx6: Fix procedure to switch the parent of 
> LDB_DI_CLK
>
> On 09.04.2014 13:55, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Due to incorrect placement of the clock gate cell in the 
>> ldb_di[x]_clk tree, the glitchy parent mux of ldb_di[x]_clk can cause 
>> a glitch to enter the ldb_di_ipu_div divider. If the divider gets 
>> locked up, no ldb_di[x]_clk is generated, and the LVDS display will 
>> hang when the ipu_di_clk is sourced from ldb_di_clk.
>>
>> To fix the problem, both the new and current parent of the ldb_di_clk 
>> should be disabled before the switch. This patch ensures that correct 
>> steps are followed when ldb_di_clk parent is switched in the beginning of boot.
>>
>> Signed-off-by: Ranjani Vaidyanathan
>> <Ranjani.Vaidyanathan@freescale.com>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>>    arch/arm/mach-imx/clk-imx6q.c | 125 ++++++++++++++++++++++++++++++++++++++++--
>>    1 file changed, 121 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/clk-imx6q.c 
>> b/arch/arm/mach-imx/clk-imx6q.c index 20ad0d1..3ee45f4 100644
>> --- a/arch/arm/mach-imx/clk-imx6q.c
>> +++ b/arch/arm/mach-imx/clk-imx6q.c
> ....
>> +static void disable_anatop_clocks(void __iomem *anatop_base) {
>> +	unsigned int reg;
>> +
>> +	/* Make sure PFDs are disabled at boot. */
>> +	reg = readl_relaxed(anatop_base + 0x100);
>> +	/* Cannot disable pll2_pfd2_396M, as it is the MMDC clock in iMX6DL */
>> +	if (cpu_is_imx6dl())
>> +		reg |= 0x80008080;
>> +	else
>> +		reg |= 0x80808080;
>
> There are two issues with this code section:
>
> 1) You want to know here if pll2_pfd2_396M is used as MMDC clock. This is independent of IMX6DL. Even a Quad/Dual could use pll2_pfd2_396M as MMDC clock. You better should check what you are really looking for:
>
> if (MMDC clock == pll2_pfd2_396M)
> ...
> [RV] Yes, you are perfectly correct. We need to check MMDC parent clock.

Just an additional question:

Do we really need that check here? Why wouldn't it be sufficent to just do

reg |= 0x00008080;

?

Independent if pll2_pfd2_396M is used as MMDC clock or not? Or if we are on a DualLite or Quad/Dual?
 
[RV] For mx6q, if mmdc is not from pll2_pfd2_396M, I would prefer we gate it at boot. That way the clock use count is maintained. And we don't want pll2_pfd2_396M to be an always-on clock. 
On mx6dl, there is no option, MMDC_CLK can only come from ppl2_pfd2. Since its possible that MX6Q can use pll2_pfd2, we should check the source of mmdc.
 
Best regards

Dirk
