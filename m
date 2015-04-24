From: jbe@pengutronix.de (Juergen Borleis)
Date: Fri, 24 Apr 2015 12:24:02 +0200
Subject: [rtc-linux] [PATCH 2/5] RTC/i.MX/DryIce: add the unit recovery
 code
In-Reply-To: <20150421231411.GC8539@piout.net>
References: <1429002716-19821-1-git-send-email-jbe@pengutronix.de>
 <1429002716-19821-3-git-send-email-jbe@pengutronix.de>
 <20150421231411.GC8539@piout.net>
Message-ID: <201504241224.02705.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Wednesday 22 April 2015 01:14:11 Alexandre Belloni wrote:
> On 14/04/2015 at 11:11:53 +0200, Juergen Borleis wrote :
> > This code is requiered to recover the unit from a security violation.
>
>       required ^

Sure :)

> > [...]
> > +/* do a write into the unit without interrupt support */
> > +static void di_write_busy_wait(const struct imxdi_dev *imxdi, u32 val,
> > +								unsigned reg)
>
> Alignment should match the open parenthesis, please fix all occurrences
> in your patch.

Okay.

> > +{
> > +	/* do the register write */
> > +	__raw_writel(val, imxdi->ioaddr + reg);
> > +
> > +	/*
> > +	 * now it takes four 32,768 kHz clock cycles to take
> > +	 * the change into effect = 122 us
> > +	 */
> > +	udelay(200);
>
> As the requirement is not that critical, you may want to use usleep_range()

Good point. Will change it.

> > +}
> > +
> > +static void di_report_tamper_info(struct imxdi_dev *imxdi,  u32 dsr)
> > +{
> > +	u32 dtcr;
> > +
> > +	dtcr = __raw_readl(imxdi->ioaddr + DTCR);
> > +
> > +	dev_emerg(&imxdi->pdev->dev, "!! DryIce tamper event detected !!\n");
> > +	/* the following flags force a transition into the "FAILURE STATE" */
> > +	if (dsr & DSR_VTD) {
> > +		dev_emerg(&imxdi->pdev->dev, "!! Voltage Tamper event\n");
> > +		if (!(dtcr & DTCR_VTE))
> > +			dev_emerg(&imxdi->pdev->dev,
> > +				"!! But Voltage Tamper detection wasn't enabled. False positive?\n");
>
> I'm not sure about prefixing all the messages with "!! ". dev_emerg()
> seems important enough to be noticed.
> I would remove " False positive?". What about
> 		dev_emerg(&imxdi->pdev->dev,
> 			  "%sVoltage Tamper event\n",
> 			  (dtcr & DTCR_VTE) ? "" : "Spurious ");

"spurious" sounds better. And I will change the messages.

> [...]
> > +static void di_what_is_to_be_done(struct imxdi_dev *imxdi,
> > +						const char *power_supply)
> > +{
> > +	dev_emerg(&imxdi->pdev->dev, " Please cycle the %s power supply in order to get the DryIce unit working again\n",
>
>             remove that heading space ^

Yes.

> I would also explain that the RTC is part of the DryIce unit.

Within this message? Makes sense. Will do so.

> [...]
> > +			sec);
> > +	/*
> > +	 * the timer cannot be set/modified if
> > +	 * - the TCHL or TCSL bit is set in DCR
> > +	 */
> > +	dcr = __raw_readl(imxdi->ioaddr + DCR);
> > +	if (!(dcr & DCR_TCE)) {
> > +		if (dcr & DCR_TCHL) {
> > +			/* we are out of luck */
> > +			di_what_is_to_be_done(imxdi, "battery");
> > +			return -ENODEV;
> > +		}
> > +		if (dcr & DCR_TCSL) {
> > +			di_what_is_to_be_done(imxdi, "main");
> > +			return -ENODEV;
> > +		}
> > +
>
> Unnecessary blank line

Ups. Made accidentally.

> [...]
> > +	/* success? */
> > +	dsr = __raw_readl(imxdi->ioaddr + DSR);
> > +	if (dsr & DSR_SVF) {
> > +		dev_crit(&imxdi->pdev->dev,
> > +			"Cannot clear the security violation flag. We are ending up in an  endless loop!\n");
> > +		/* last resourt */ 
>
>                  resort ^

.oO(note to myself: update dictionary...)

> [...]
> > @@ -498,44 +793,6 @@ static int __init dryice_rtc_probe(struct platform_device *pdev) goto err;
> >  	}
> >
> > -	/* put dryice into valid state */
> > -	if (__raw_readl(imxdi->ioaddr + DSR) & DSR_NVF) {
> > -		rc = di_write_wait(imxdi, DSR_NVF | DSR_SVF, DSR);
>
> Multiple writes have switched from di_write_wait() which is checking
> for a write error to di_write_busy_wait() which is not doing that check
> is waiting 200us enough to ensure that the write has been done?

Each write requires four 32 kHz clock cycles. So the 200 us should be enough.
But I will take a closer look for what have to be really done in the case of
an access error.

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Borleis ? ? ? ? ? ? |
Industrial Linux Solutions               ? ? ?| http://www.pengutronix.de/  |
