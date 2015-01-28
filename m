From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 27 Jan 2015 19:11:50 -0800
Subject: [PATCH 1/6] soc: qcom: gsbi: Add support for ADM CRCI muxing
In-Reply-To: <1422396644-21714-2-git-send-email-agross@codeaurora.org>
References: <1422396644-21714-1-git-send-email-agross@codeaurora.org>
 <1422396644-21714-2-git-send-email-agross@codeaurora.org>
Message-ID: <20150128031149.GM11960@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 27 Jan 14:10 PST 2015, Andy Gross wrote:

This solution looks good, just some style things.

> diff --git a/drivers/soc/qcom/qcom_gsbi.c b/drivers/soc/qcom/qcom_gsbi.c
[..]
> +#define MAX_GSBI		12
> +
> +#define TCSR_ADM_CRCI_BASE	0x70
> +
> +struct crci_config {
> +	u32 num_rows;
> +	const u32 *array;

Making this:
 const u32 (*array)[MAX_GSBI];

> +};
> +
> +static const u32 crci_ipq8064[][MAX_GSBI] = {
> +	{
> +		0x000003, 0x00000c, 0x000030, 0x0000c0,
> +		0x000300, 0x000c00, 0x003000, 0x00c000,
> +		0x030000, 0x0c0000, 0x300000, 0xc00000
> +	},
> +	{
> +		0x000003, 0x00000c, 0x000030, 0x0000c0,
> +		0x000300, 0x000c00, 0x003000, 0x00c000,
> +		0x030000, 0x0c0000, 0x300000, 0xc00000
> +	},
> +};
> +
> +static const struct crci_config config_ipq8064 = {
> +	.num_rows = ARRAY_SIZE(crci_ipq8064),
> +	.array = crci_ipq8064[0],

...so that you can make this:
 .array = crci_ipq8064,

> +};
[..]
> @@ -45,6 +152,20 @@ static int gsbi_probe(struct platform_device *pdev)
[..]
> +	if (config)
> +		for (i = 0; i < config->num_rows; i++) {
> +			if (gsbi->mode == GSBI_PROT_SPI)
> +				val = config->array[i*MAX_GSBI + gsbi_num - 1];

...will give you:
 config->array[i][gsbi_num - 1];

> +			else
> +				val = 0;
> +
> +			regmap_update_bits(gsbi->tcsr,
> +				TCSR_ADM_CRCI_BASE + 0x4*i,
> +				config->array[i*MAX_GSBI + gsbi_num - 1], val);

To me this would be cleaner:

mask = config->array[i][gsbi_num - 1];
if (gsbi->mode == GSBI_PRO_SPI)
	regmap_update_bits(gsbi->tcsr, TCSR_ADM_CRCI_BASE + i * 4, mask, mask);
else
	regmap_update_bits(gsbi->tcsr, TCSR_ADM_CRCI_BASE + i * 4, mask, 0);

> +		}
> +
There should be an extra set of {} around the if statment body.

Regards,
Bjorn
