From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 1 Oct 2013 22:34:34 +0200
Subject: [PATCH 01/10] pwm-backlight: Refactor backlight power on/off
In-Reply-To: <524B13BF.7080902@wwwdotorg.org>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <1379972467-11243-2-git-send-email-treding@nvidia.com>
 <524B13BF.7080902@wwwdotorg.org>
Message-ID: <20131001203430.GA9201@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 12:26:07PM -0600, Stephen Warren wrote:
> On 09/23/2013 03:40 PM, Thierry Reding wrote:
> > In preparation for adding an optional regulator and enable GPIO to the
> > driver, split the power on and power off sequences into separate
> > functions to reduce code duplication at the multiple call sites.
> 
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> 
> > +static void pwm_backlight_power_off(struct pwm_bl_data *pb)
> > +{
> > +	pwm_disable(pb->pwm);
> 
> Both the call-sites you're replacing do the following before pwm_disable():
> 
> 		pwm_config(pb->pwm, 0, pb->period);
> 
> While I agree that probably shouldn't be necessary, I think it's at
> least worth mentioning that in the commit description just to make it
> obvious that it was a deliberate change. Splitting that change into a
> separate patch might be reasonable in order to keep refactoring and
> functional changes separate, although perhaps it's not worth it.

Actually I'll add that back. I'm not sure exactly why I dropped it (it
may just have been oversight) and there have been reports that some HW
actually requires pwm_config(..., 0, ...) before pwm_disable() to turn
off properly.

> There are also a couple unrelated whitespace changes thrown in here.

I think they increase readability, but I can certainly move them into a
separate patch.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131001/aa838b97/attachment.sig>
