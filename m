From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 29 Aug 2012 11:10:33 +0300
Subject: [PATCH v2 05/11] USB: chipidea: don't let probe fail if otg
 controller start one role failed
In-Reply-To: <20120828092730.GY4011@b20223-02.ap.freescale.net>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
 <1346137397-32374-6-git-send-email-richard.zhao@freescale.com>
 <87ligz2yyo.fsf@ashishki-desk.ger.corp.intel.com>
 <20120828092730.GY4011@b20223-02.ap.freescale.net>
Message-ID: <87vcg2jeyu.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Zhao <richard.zhao@freescale.com> writes:

> On Tue, Aug 28, 2012 at 11:38:23AM +0300, Alexander Shishkin wrote:
>> Richard Zhao <richard.zhao@freescale.com> writes:
>> 
>> > One role failed, but the other role will possiblly still work.
>> > For example, when udc start failed, if plug in a host device,
>> > it works.
>> 
>> If you're a host device, ci->role should be HOST at this point and
>> ci_role_start() shouldn't fail. If ci->role is detected wrongly, the
>> role detection must be fixed. If ci_role_start() fails for host, but it
>> still works when it's called again after the id pin change is detected,
>> again, the problem is elsewhere.
> The check is only for OTG device. For single role device, it just fail
> if it start the role failed.

Sorry, can you rephrase?

>> 
>> >
>> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
>> > ---
>> >  drivers/usb/chipidea/core.c |    7 +++++--
>> >  1 file changed, 5 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
>> > index 19ef324..8fd390a 100644
>> > --- a/drivers/usb/chipidea/core.c
>> > +++ b/drivers/usb/chipidea/core.c
>> > @@ -473,8 +473,11 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
>> >  	ret = ci_role_start(ci, ci->role);
>> >  	if (ret) {
>> >  		dev_err(dev, "can't start %s role\n", ci_role(ci)->name);
>> > -		ret = -ENODEV;
>> > -		goto rm_wq;
>> > +		ci->role = CI_ROLE_END;
>> 
>> So are you relying on id pin interrupt for initializing the role after
>> this? Can you provide more details?
> Yes. The ID pin detect still works. My case is, gadget role failed,
> host role works. I was trying not to ruin host function.

But it shouldn't even try to start the gadget, because ci_otg_role()
should set ci->role to HOST before ci_role_start() happens.

Another question is, why does gadget start fail?

Regards,
--
Alex
