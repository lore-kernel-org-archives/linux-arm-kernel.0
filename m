From: agross@codeaurora.org (Andy Gross)
Date: Wed, 28 Jan 2015 11:26:21 -0600
Subject: [PATCH 1/6] soc: qcom: gsbi: Add support for ADM CRCI muxing
In-Reply-To: <20150128031149.GM11960@sonymobile.com>
References: <1422396644-21714-1-git-send-email-agross@codeaurora.org>
 <1422396644-21714-2-git-send-email-agross@codeaurora.org>
 <20150128031149.GM11960@sonymobile.com>
Message-ID: <20150128172621.GA17315@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 07:11:50PM -0800, Bjorn Andersson wrote:
> On Tue 27 Jan 14:10 PST 2015, Andy Gross wrote:
> 
> This solution looks good, just some style things.
> 
> > diff --git a/drivers/soc/qcom/qcom_gsbi.c b/drivers/soc/qcom/qcom_gsbi.c
> [..]
> > +#define MAX_GSBI		12
> > +
> > +#define TCSR_ADM_CRCI_BASE	0x70
> > +
> > +struct crci_config {
> > +	u32 num_rows;
> > +	const u32 *array;
> 
> Making this:
>  const u32 (*array)[MAX_GSBI];

ok, i'll switch to do this instead and change the usage down below.

<snip>

> > +			else
> > +				val = 0;
> > +
> > +			regmap_update_bits(gsbi->tcsr,
> > +				TCSR_ADM_CRCI_BASE + 0x4*i,
> > +				config->array[i*MAX_GSBI + gsbi_num - 1], val);
> 
> To me this would be cleaner:
> 
> mask = config->array[i][gsbi_num - 1];
> if (gsbi->mode == GSBI_PRO_SPI)
> 	regmap_update_bits(gsbi->tcsr, TCSR_ADM_CRCI_BASE + i * 4, mask, mask);
> else
> 	regmap_update_bits(gsbi->tcsr, TCSR_ADM_CRCI_BASE + i * 4, mask, 0);

i had considered doing something similar.  It does make it cleaner, so I'll do
this.

> > +		}
> > +
> There should be an extra set of {} around the if statment body.

done


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
