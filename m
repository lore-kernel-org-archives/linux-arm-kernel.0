From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 31 Oct 2016 00:57:17 +0100
Subject: [PATCH v9 1/4] soc: mediatek: Refine scpsys to support multiple
 platform
In-Reply-To: <1477647408.24014.6.camel@mtksdaap41>
References: <1476953798-23263-1-git-send-email-jamesjj.liao@mediatek.com>
 <1476953798-23263-2-git-send-email-jamesjj.liao@mediatek.com>
 <1d5cda95-467a-4f95-1cc9-b8f156271a54@gmail.com>
 <1477647408.24014.6.camel@mtksdaap41>
Message-ID: <b2f411ed-2de4-95aa-d15a-5435a6694410@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/28/2016 11:36 AM, James Liao wrote:
> Hi Matthias,
>
> Sorry for late reply due to our email service.
>
> On Tue, 2016-10-25 at 16:04 +0200, Matthias Brugger wrote:
>> Hi James,
>>
>> On 10/20/2016 10:56 AM, James Liao wrote:
>>> -static int scpsys_probe(struct platform_device *pdev)
>>> +static void init_clks(struct platform_device *pdev, struct clk *clk[CLK_MAX])
>>
>> I prefer struct clk **clk.
>
> Okay.
>
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = CLK_NONE + 1; i < CLK_MAX; i++)
>>> +		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
>>> +}
>>> +
>>> +static struct scp *init_scp(struct platform_device *pdev,
>>> +			const struct scp_domain_data *scp_domain_data, int num)
>>>  {
>>>  	struct genpd_onecell_data *pd_data;
>>>  	struct resource *res;
>>> -	int i, j, ret;
>>> +	int i, j;
>>>  	struct scp *scp;
>>> -	struct clk *clk[MT8173_CLK_MAX];
>>> +	struct clk *clk[CLK_MAX];
>>
>> should be *[CLK_MAX - 1] but I would prefer to define in the enum:
>> CLK_MAX = CLK_VENC_LT,
>
> After init_clks() the clk[] will have valid contents between
> clk[1]..clk[CLK_MAX-1], so it's necessary to declare clk[] with CLK_MAX
> elements.
>
>> If you are ok with it, I can fix both of my comments when applying.
>
> Yes. struct clk **clk can be applied directly. But I think clk[CLK_MAX]
> should be kept in current implementation.
>

Ok, we won't never use clk[0] but it's ok for now.

Applied to v4.9-next/soc

>
> Best regards,
>
> James
>
>
