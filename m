From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 14 Jun 2016 09:37:47 +0200
Subject: anatop_regulator probe returns -EINVAL if regulator is set to
 bypass mode
In-Reply-To: <CACE3x1OUrK8ea78VDxf0bYxNnxBRrcH3xFE0amMsv2jYErRLmQ@mail.gmail.com>
References: <CACE3x1OUrK8ea78VDxf0bYxNnxBRrcH3xFE0amMsv2jYErRLmQ@mail.gmail.com>
Message-ID: <1879329.hU2uRcWFRn@galactica.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mika,

On 2016 M06 6, Mon 17:24:49 CEST Mika B?tsman wrote:
> Hi Philipp, hi Markus,
> 
> there's a problem with anatop regulator driver that relates to
> functionality you have worked on. The related commits:
> da0607c8 regulator: anatop: Fail on invalid voltage selector
> d38018f2 regulator: anatop: Add bypass support to digital LDOs
> 
> 
> So in case bootloader set the regulator to bypass mode sreg->sel gets set
> to 0
>         sreg->sel = (val & rdesc->vsel_mask) >> sreg->vol_bit_shift;
>         if (sreg->sel == LDO_FET_FULL_ON) {
>             sreg->sel = 0;
>             sreg->bypass = true;
>         }
> 
> and a little bit later it's causing EINVAL to be returned.
>         if (!sreg->sel) {
>             dev_err(&pdev->dev, "Failed to read a valid default voltage
> selector.\n");
>             return -EINVAL;
>         }
> 
> Resulting in:
> anatop_regulator 20c8000.anatop:regulator-vddcore at 140: Failed to read a
> valid default voltage selector.
> anatop_regulator: probe of 20c8000.anatop:regulator-vddcore at 140 failed with
> error -22
> anatop_regulator 20c8000.anatop:regulator-vddsoc at 140: Failed to read a
> valid default voltage selector.
> anatop_regulator: probe of 20c8000.anatop:regulator-vddsoc at 140 failed with
> error -22
> 
> Is that really the expected behaviour or should sreg->bypass be taken into
> account before returning EINVAL? Like this:
> 
>         if (!sreg->bypass && !sreg->sel) {

Thanks for spotting this. This condition seems better. A EINVAL error was not 
intended for the bypass mode.

Best Regards,

Markus

>             dev_err(&pdev->dev, "Failed to read a valid default voltage
> selector.\n");
>             return -EINVAL;
>         }
> 
> 
> Regards,
> Mika

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160614/8be279ee/attachment.sig>
