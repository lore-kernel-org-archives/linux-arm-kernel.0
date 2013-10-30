From: joshc@codeaurora.org (Josh Cartwright)
Date: Wed, 30 Oct 2013 14:17:25 -0500
Subject: [PATCH v3 04/10] spmi: Add MSM PMIC Arbiter SPMI controller
In-Reply-To: <20131030180536.GI21983@codeaurora.org>
References: <cover.1382985169.git.joshc@codeaurora.org>
 <7467ed718314cb98c9e40f135e9926cf14ed218b.1382985169.git.joshc@codeaurora.org>
 <20131030180536.GI21983@codeaurora.org>
Message-ID: <20131030191725.GO20207@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 11:05:36AM -0700, Stephen Boyd wrote:
> On 10/28, Josh Cartwright wrote:
> > +
> > +/**
> > + * pa_write_data: write 1..4 bytes from buf to pmic-arb's register
> > + * @bc byte-count -1. range: 0..3
> > + * @reg register's address
> > + * @buf buffer to write. length must be bc+1
> 
> Missing colon between variable and description.

I'll clean the documentation up a bit and push it all to the
implementation (as suggested in a previous review).

[..]
> > +	if (bc >= PMIC_ARB_MAX_TRANS_BYTES) {
> > +		dev_err(&ctrl->dev,
> > +			"pmic-arb supports 1..%d bytes per trans, but:%d requested",
> 
> Nitpick: Please replace the colon between but and %d with a space.
> 
> > +			PMIC_ARB_MAX_TRANS_BYTES, bc+1);
> 
> Space around that '+' please.

Sure.

> > +		return  -EINVAL;
> > +	}
> > +	dev_dbg(&ctrl->dev,
> > +		"op:0x%x sid:%d bc:%d addr:0x%x\n", opc, sid, bc, addr);
> > +
> > +	/* Check the opcode */
> > +	if (opc >= 0x60 && opc <= 0x7F)
> > +		opc = PMIC_ARB_OP_READ;
> > +	else if (opc >= 0x20 && opc <= 0x2F)
> > +		opc = PMIC_ARB_OP_EXT_READ;
> > +	else if (opc >= 0x38 && opc <= 0x3F)
> > +		opc = PMIC_ARB_OP_EXT_READL;
> > +	else
> > +		return -EINVAL;
> > +
> > +	cmd = (opc << 27) | ((sid & 0xf) << 20) | (addr << 4) | (bc & 0x7);
> > +
> > +	spin_lock_irqsave(&pmic_arb->lock, flags);
> > +	pmic_arb_base_write(pmic_arb, PMIC_ARB_CMD(pmic_arb->channel), cmd);
> > +	rc = pmic_arb_wait_for_done(ctrl);
> > +	if (rc)
> > +		goto done;
> > +
> > +	/* Read from FIFO, note 'bc' is actually number of bytes minus 1 */
> > +	pa_read_data(pmic_arb, buf, PMIC_ARB_RDATA0(pmic_arb->channel)
> > +							, min_t(u8, bc, 3));
>
> Nitpick: Weird comma starting a line here.

Okay.

[..]
> > +static int __exit spmi_pmic_arb_remove(struct platform_device *pdev)
> 
> __exit shouldn't be here. We want this function in modules.
> 
> > +{
> > +	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
> > +	spmi_controller_remove(ctrl);
> > +	return 0;
> > +}
> > +
> > +static struct of_device_id spmi_pmic_arb_match_table[] = {
> > +	{	.compatible = "qcom,spmi-pmic-arb", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, spmi_pmic_arb_match_table);
> > +
> > +static struct platform_driver spmi_pmic_arb_driver = {
> > +	.probe		= spmi_pmic_arb_probe,
> > +	.remove		= __exit_p(spmi_pmic_arb_remove),
> 
> Please drop this __exit_p() usage as well.
> 
> > +	.driver		= {
> > +		.name	= "spmi_pmic_arb",
> > +		.owner	= THIS_MODULE,
> > +		.of_match_table = spmi_pmic_arb_match_table,
> > +	},
> > +};
> > +module_platform_driver(spmi_pmic_arb_driver);
> 
> MODULE_LICENSE()
> MODULE_ALIAS()

Yep,  will re-add.  Not sure why I dropped these...

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
