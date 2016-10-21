From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 21 Oct 2016 10:20:30 +0800
Subject: [PATCH v5 23/23] phy: Add support for Qualcomm's USB HS phy
In-Reply-To: <147700563857.2550.16732518381302920183@sboyd-linaro>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
 <20161018015636.11701-24-stephen.boyd@linaro.org>
 <147700563857.2550.16732518381302920183@sboyd-linaro>
Message-ID: <20161021022030.GB16461@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 04:20:38PM -0700, Stephen Boyd wrote:
> Quoting Stephen Boyd (2016-10-17 18:56:36)
> > +
> > +static int
> > +qcom_usb_hs_phy_vbus_notifier(struct notifier_block *nb, unsigned long event,
> > +                             void *ptr)
> > +{
> > +       struct qcom_usb_hs_phy *uphy;
> > +       int is_host;
> > +       u8 addr;
> > +
> > +       uphy = container_of(nb, struct qcom_usb_hs_phy, vbus_notify);
> > +       is_host = extcon_get_cable_state_(uphy->id_edev, EXTCON_USB_HOST);
> 
> Please don't apply this patch. This call now deadlocks on v4.9-rc1
> because of how extcon_get_cable_state_() now grabs a lock that is
> already held here when we're inside the notifier. It's not really
> required that we grab the lock in extcon there, but this has exposed a
> flaw in the logic anyway. We don't know if the id pin is going to toggle
> before or after this function is called, so we should really keep track
> of both vbus and id state in this driver and then do the same ulpi
> writes from two different notifiers for both vbus and id pin. We would
> be duplicating work sometimes, but that's pretty much the best solution
> I can come up with. Otherwise it's racy.
> 

Why you need to care id status? If EXTCON_USB event has happened, and
event is true, you can set, otherwise, it is clear operation, that's
to say you may not need have id extcon phandle, do you think so?

-- 

Best Regards,
Peter Chen
