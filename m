From: joshc@codeaurora.org (Josh Cartwright)
Date: Fri, 19 Sep 2014 10:09:14 -0500
Subject: [PATCH] pinctrl: qcom: use restart_notifier mechanism for ps_hold
In-Reply-To: <541B9ADA.2070107@roeck-us.net>
References: <1411079579-10172-1-git-send-email-joshc@codeaurora.org>
 <541B9ADA.2070107@roeck-us.net>
Message-ID: <20140919150914.GG3749@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 07:54:18PM -0700, Guenter Roeck wrote:
> On 09/18/2014 03:32 PM, Josh Cartwright wrote:
> >By converting to the restart_notifier mechanism for restart, we allow
> >for other mechanisms, like the watchdog, to be used for restart in the
> >case where PS_HOLD has failed to reset the chip.
> >
> >Choose priority 128, as according to documentation, this mechanism "is
> >sufficient to restart the entire system".
> >
> >Cc: Pramod Gurav <pramod.gurav@smartplayin.com>
> >Cc: Guenter Roeck <linux@roeck-us.net>
> >Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> >---
[..]
> >
> >-#ifdef CONFIG_ARM
> 
> Unrelated to this patch, but is this going to be executed (and potentially used)
> on any non-arm architectures ?

No.  Not for now.  The only other conceivable platform that could make
use of this would be hexagon, but I think there would be other hurdles
to getting this driver working before even tackling the restart handler.

[..]
> >+static int msm_ps_hold_restart(struct notifier_block *nb, unsigned long action,
> >+			       void *data)
> >  {
> >-	writel(0, msm_ps_hold);
> >+	struct msm_pinctrl *pctrl = container_of(nb, struct msm_pinctrl, restart_nb);
> >+
> >+	writel(0, pctrl->regs + PS_HOLD_OFFSET);
> >  	mdelay(10000);
> 
> Sure you still want to wait for 10 seconds here ?
> Would it make sense to choose a more reasonable timeout ?

Yeah, 10s is a bit extreme.  I don't quite know what a reasonable
timeout is, so I'll do some rough measurements, and shorten it down in
v2.

Thanks again,
  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
