From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Dec 2013 11:03:41 +0100
Subject: [PATCH v8 1/2] PWM: atmel-pwm: add PWM controller driver
In-Reply-To: <529E9AA2.8020400@atmel.com>
References: <1384766002-2852-1-git-send-email-voice.shen@atmel.com>
 <20131202105957.GD18060@ulmo.nvidia.com>
 <529D4B58.9020700@atmel.com>
 <20131203094326.GB21178@ulmo.nvidia.com>
 <529E9AA2.8020400@atmel.com>
Message-ID: <20131204100340.GU19943@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 10:59:46AM +0800, Bo Shen wrote:
> Hi Thierry,
> 
> On 12/03/2013 05:43 PM, Thierry Reding wrote:
> >On Tue, Dec 03, 2013 at 11:09:12AM +0800, Bo Shen wrote:
> >>On 12/02/2013 06:59 PM, Thierry Reding wrote:
> >>>On Mon, Nov 18, 2013 at 05:13:21PM +0800, Bo Shen wrote:
> >[...]
> >>>>diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> >[...]
> >>>>+	/* Calculate the period cycles */
> >>>>+	while (div > PWM_MAX_PRD) {
> >>>>+		div = clk_rate / (1 << pres);
> >>>>+		div = div * period_ns;
> >>>>+		/* 1/Hz = 100000000 ns */
> >>>
> >>>I don't think that comment is needed.
> >>
> >>This is asked to be added.
> >>And, I think keep it and it won't hurt, what do you think?
> >
> >I think it's obvious that you're converting from nanoseconds because of
> >the _ns prefix in period_ns. But if somebody requested this and everyone
> >else thinks it's useful, I'm okay with keeping it.
> >
> >>>>+	if (test_bit(PWMF_ENABLED, &pwm->flags)) {
> >>>>+		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CDTYUPD, dty);
> >>>>+	} else {
> >>>>+		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CDTY, dty);
> >>>>+		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CPRD, prd);
> >>>>+	}
> >>>>+}
> >>>
> >>>Neither version 1 nor version 2 seem to be able to change the period
> >>>while the channel is enabled. Perhaps that should be checked for in
> >>>atmel_pwm_config() and an error (-EBUSY) returned?
> >>
> >>The period is configured in dt in device tree, or platform data in non
> >>device tree. Nowhere will update period. So, not code to update period.
> >>Am I right? If not, please figure out.
> >
> >The .config() operation allows the period to be specified. Just because
> >nobody currently changes it at runtime doesn't mean it can't be done.
> >
> >It is also possible that whoever wrote the device tree or platform data
> >didn't know that the period must be the same for all PWM channels and
> >therefore might use different values. If you check for this, at least
> >they'll notice. If you don't check for it, then they may end up having
> >the period reconfigured behind their backs, which may cause parts of
> >their setup to behave unexpectedly.
> 
> Thanks for this information.
> I will add code for changing period.

Just to clarify: I wouldn't want this code to allow changing the period
but rather reject incompatible changes to the period with an error code.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/54388f8a/attachment.sig>
