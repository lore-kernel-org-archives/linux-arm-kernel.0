From: linuxzsc@gmail.com (Richard Zhao)
Date: Tue, 4 Sep 2012 22:17:33 +0800
Subject: [PATCH v2 05/11] USB: chipidea: don't let probe fail if otg
 controller start one role failed
In-Reply-To: <20120829104559.GB25433@b20223-02.ap.freescale.net>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
 <1346137397-32374-6-git-send-email-richard.zhao@freescale.com>
 <87ligz2yyo.fsf@ashishki-desk.ger.corp.intel.com>
 <20120828092730.GY4011@b20223-02.ap.freescale.net>
 <87vcg2jeyu.fsf@ashishki-desk.ger.corp.intel.com>
 <20120829083337.GI4011@b20223-02.ap.freescale.net>
 <87mx1ejag0.fsf@ashishki-desk.ger.corp.intel.com>
 <20120829104559.GB25433@b20223-02.ap.freescale.net>
Message-ID: <20120904141732.GC19897@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 06:46:00PM +0800, Richard Zhao wrote:
> On Wed, Aug 29, 2012 at 12:48:15PM +0300, Alexander Shishkin wrote:
> > Richard Zhao <richard.zhao@freescale.com> writes:
> > 
> > > On Wed, Aug 29, 2012 at 11:10:33AM +0300, Alexander Shishkin wrote:
> > >> Richard Zhao <richard.zhao@freescale.com> writes:
> > >> 
> > >> > On Tue, Aug 28, 2012 at 11:38:23AM +0300, Alexander Shishkin wrote:
> > >> >> Richard Zhao <richard.zhao@freescale.com> writes:
> > >> >> 
> > >> >> > One role failed, but the other role will possiblly still work.
> > >> >> > For example, when udc start failed, if plug in a host device,
> > >> >> > it works.
> > >> >> 
> > >> >> If you're a host device, ci->role should be HOST at this point and
> > >> >> ci_role_start() shouldn't fail. If ci->role is detected wrongly, the
> > >> >> role detection must be fixed. If ci_role_start() fails for host, but it
> > >> >> still works when it's called again after the id pin change is detected,
> > >> >> again, the problem is elsewhere.
> > >> > The check is only for OTG device. For single role device, it just fail
> > >> > if it start the role failed.
> > >> 
> > >> Sorry, can you rephrase?
> > >> 
> > >> >> 
> > >> >> >
> > >> >> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > >> >> > ---
> > >> >> >  drivers/usb/chipidea/core.c |    7 +++++--
> > >> >> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >> >> >
> > >> >> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > >> >> > index 19ef324..8fd390a 100644
> > >> >> > --- a/drivers/usb/chipidea/core.c
> > >> >> > +++ b/drivers/usb/chipidea/core.c
> > >> >> > @@ -473,8 +473,11 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
> > >> >> >  	ret = ci_role_start(ci, ci->role);
> > >> >> >  	if (ret) {
> > >> >> >  		dev_err(dev, "can't start %s role\n", ci_role(ci)->name);
> > >> >> > -		ret = -ENODEV;
> > >> >> > -		goto rm_wq;
> > >> >> > +		ci->role = CI_ROLE_END;
> > >> >> 
> > >> >> So are you relying on id pin interrupt for initializing the role after
> > >> >> this? Can you provide more details?
> > >> > Yes. The ID pin detect still works. My case is, gadget role failed,
> > >> > host role works. I was trying not to ruin host function.
> > >> 
> > >> But it shouldn't even try to start the gadget, because ci_otg_role()
> > >> should set ci->role to HOST before ci_role_start() happens.
> > > It depends on ID pin. If ID pin is gadget and gadget is not support well,
> > > ci_role_start will fail. See below example.
> > >> 
> > >> Another question is, why does gadget start fail?
> > > There's one example:
> > > If usb phy don't support otg yet, otg_set_peripheral will fail, and
> > > then cause udc_start fail.
> > 
> > So you should drop the CI13XXX_REQUIRE_TRANSCEIVER flag from imx
> > platform data till the phy is fully implemented.
> It's just an example. We can not assume udc_start always success. If it
> fails, isn't it better to continue support of host than say game over?
Hi Alex,

Is it persuadable? Could you please give comments of other patches too?

Thanks
Richard
> 
> Thanks
> Richard
> > 
> > Regards,
> > --
> > Alex
> > 
> 
