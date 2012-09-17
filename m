From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 17 Sep 2012 16:59:48 +0800
Subject: [PATCH v2 05/11] USB: chipidea: don't let probe fail if otg
 controller start one role failed
In-Reply-To: <87har0q4tm.fsf@ashishki-desk.ger.corp.intel.com>
References: <20120828092730.GY4011@b20223-02.ap.freescale.net>
 <87vcg2jeyu.fsf@ashishki-desk.ger.corp.intel.com>
 <20120829083337.GI4011@b20223-02.ap.freescale.net>
 <87mx1ejag0.fsf@ashishki-desk.ger.corp.intel.com>
 <20120829104559.GB25433@b20223-02.ap.freescale.net>
 <87ipblqayc.fsf@ashishki-desk.ger.corp.intel.com>
 <20120911081833.GA4251@b20223-02.ap.freescale.net>
 <87y5kfplet.fsf@ashishki-desk.ger.corp.intel.com>
 <20120914083520.GD7167@b20223-02.ap.freescale.net>
 <87har0q4tm.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20120917085947.GB13530@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 01:25:25PM +0300, Alexander Shishkin wrote:
> Richard Zhao <richard.zhao@freescale.com> writes:
> 
> > On Wed, Sep 12, 2012 at 01:47:54PM +0300, Alexander Shishkin wrote:
> >> Richard Zhao <richard.zhao@freescale.com> writes:
> >> 
> >> > On Tue, Sep 11, 2012 at 10:23:55AM +0300, Alexander Shishkin wrote:
> >> >> Richard Zhao <richard.zhao@freescale.com> writes:
> >> >> 
> >> >> > On Wed, Aug 29, 2012 at 12:48:15PM +0300, Alexander Shishkin wrote:
> >> >> >> Richard Zhao <richard.zhao@freescale.com> writes:
> >> >> >> 
> >> >> >> > On Wed, Aug 29, 2012 at 11:10:33AM +0300, Alexander Shishkin wrote:
> >> >> >> >> Richard Zhao <richard.zhao@freescale.com> writes:
> >> >> >> >> 
> >> >> >> >> > On Tue, Aug 28, 2012 at 11:38:23AM +0300, Alexander Shishkin wrote:
> >> >> >> >> >> Richard Zhao <richard.zhao@freescale.com> writes:
> >> >> >> >> >> 
> >> >> >> >> >> > One role failed, but the other role will possiblly still work.
> >> >> >> >> >> > For example, when udc start failed, if plug in a host device,
> >> >> >> >> >> > it works.
> >> >> >> >> >> 
> >> >> >> >> >> If you're a host device, ci->role should be HOST at this point and
> >> >> >> >> >> ci_role_start() shouldn't fail. If ci->role is detected wrongly, the
> >> >> >> >> >> role detection must be fixed. If ci_role_start() fails for host, but it
> >> >> >> >> >> still works when it's called again after the id pin change is detected,
> >> >> >> >> >> again, the problem is elsewhere.
> >> >> >> >> > The check is only for OTG device. For single role device, it just fail
> >> >> >> >> > if it start the role failed.
> >> >> >> >> 
> >> >> >> >> Sorry, can you rephrase?
> >> >> >> >> 
> >> >> >> >> >> 
> >> >> >> >> >> >
> >> >> >> >> >> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> >> >> >> >> >> > ---
> >> >> >> >> >> >  drivers/usb/chipidea/core.c |    7 +++++--
> >> >> >> >> >> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >> >> >> >> >> >
> >> >> >> >> >> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> >> >> >> >> >> > index 19ef324..8fd390a 100644
> >> >> >> >> >> > --- a/drivers/usb/chipidea/core.c
> >> >> >> >> >> > +++ b/drivers/usb/chipidea/core.c
> >> >> >> >> >> > @@ -473,8 +473,11 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
> >> >> >> >> >> >  	ret = ci_role_start(ci, ci->role);
> >> >> >> >> >> >  	if (ret) {
> >> >> >> >> >> >  		dev_err(dev, "can't start %s role\n", ci_role(ci)->name);
> >> >> >> >> >> > -		ret = -ENODEV;
> >> >> >> >> >> > -		goto rm_wq;
> >> >> >> >> >> > +		ci->role = CI_ROLE_END;
> >> >> >> >> >> 
> >> >> >> >> >> So are you relying on id pin interrupt for initializing the role after
> >> >> >> >> >> this? Can you provide more details?
> >> >> >> >> > Yes. The ID pin detect still works. My case is, gadget role failed,
> >> >> >> >> > host role works. I was trying not to ruin host function.
> >> >> >> >> 
> >> >> >> >> But it shouldn't even try to start the gadget, because ci_otg_role()
> >> >> >> >> should set ci->role to HOST before ci_role_start() happens.
> >> >> >> > It depends on ID pin. If ID pin is gadget and gadget is not support well,
> >> >> >> > ci_role_start will fail. See below example.
> >> >> >> >> 
> >> >> >> >> Another question is, why does gadget start fail?
> >> >> >> > There's one example:
> >> >> >> > If usb phy don't support otg yet, otg_set_peripheral will fail, and
> >> >> >> > then cause udc_start fail.
> >> >> >> 
> >> >> >> So you should drop the CI13XXX_REQUIRE_TRANSCEIVER flag from imx
> >> >> >> platform data till the phy is fully implemented.
> >> >> > It's just an example. We can not assume udc_start always success. If it
> >> >> > fails, isn't it better to continue support of host than say game over?
> >> >> 
> >> >> Ok, I think what we need here is to rework error handling around role
> >> >> switching, so that we can allow certain things to fail and retry at a
> >> >> later point (say at id pin change), while being careful about the other
> >> >> failures.
> >> >> 
> >> >> If this patch is not crucial for imx right now, I'd prefer to leave it
> >> >> out.
> >> > That's OK. but I hope other function related patch can be merged for
> >> > 3.7 :)
> >> 
> >> Also 6/11 seems quite pointless to me. Otherwise, I'll send them to Greg
> >> today.
> > If set_peripheral is null, udc_start will fail. Or you prefer removing
> > checking of otg_set_peripheral returned value?
> 
> I guess for now we could do something like
> 
>         if (retval &&
>             !(ci->platdata->flags & CI13XXX_REQUIRE_TRANSCEIVER))
>                 goto remove_dbg;
> 
> ... or implement an otg driver. :)
Yes, a fake otg driver sounds more simple :)

Thanks
Richard
> 
> Regards,
> --
> Alex
> 
