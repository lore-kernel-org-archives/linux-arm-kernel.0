From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Mar 2015 15:17:40 +0000
Subject: [PATCH 2/3] pm: domains: factor out code to get the generic PM
 domain from a struct device
In-Reply-To: <CAPDyKFrpM0TYnNvAX8Jw6zUAekh0=XXMJyxWxSgKSao=TQf62Q@mail.gmail.com>
References: <20150320171941.GK8656@n2100.arm.linux.org.uk>
 <E1YZ0b3-0000so-KG@rmk-PC.arm.linux.org.uk>
 <CAPDyKFrpM0TYnNvAX8Jw6zUAekh0=XXMJyxWxSgKSao=TQf62Q@mail.gmail.com>
Message-ID: <20150323151740.GR8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 02:28:14PM +0100, Ulf Hansson wrote:
> On 20 March 2015 at 18:20, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> > The PM domain code contains two methods to get the generic PM domain
> > for a struct device.  One is dev_to_genpd() which is only safe when
> > we know for certain that the device has a generic PM domain attached.
> > The other is coded into genpd_dev_pm_detach() which ensures that the
> > PM domain in the struct device is a generic PM domain (and so is safer).
> >
> > This commit factors out the safer version, documents it, and hides the
> > unsafe dev_to_genpd().
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/base/power/domain.c | 46 +++++++++++++++++++++++++++++++--------------
> >  include/linux/pm_domain.h   |  6 +++---
> >  2 files changed, 35 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index b3fbc21da2dc..89d2eea7f561 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -68,7 +68,36 @@ static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
> >         return genpd;
> >  }
> >
> > -struct generic_pm_domain *dev_to_genpd(struct device *dev)
> > +/*
> > + * Get the generic PM domain for a particular struct device.
> > + * This validates the struct device pointer, the PM domain pointer,
> > + * and checks that the PM domain pointer is a real generic PM domain.
> > + * Any failure results in NULL being returned.
> > + */
> > +struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev)
> 
> I wouldn't mind keeping also this function static, unless you foresee
> users outside genpd?

_I_ have users of it outside at the moment.

Once the major churn in PM domains is over and I have no use for this
externally, I'll consider making it static in my patch set - but all
the time that doing so results in breakage for me...

Plus, you're asking me to do yet another 20+ minute re-spin of this
patch set.  I'm going to refuse; I'm almost at the point of just not
giving a damn on this stuff, it's wasting too much of my time.
Especially as, yet again, you should have replied to the emails in the
previous round suggesting this change.

Rafael, please merge these three as we previously agreed.  Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
