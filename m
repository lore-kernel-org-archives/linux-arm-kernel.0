From: balbi@ti.com (Felipe Balbi)
Date: Mon, 6 Jul 2015 13:09:21 -0500
Subject: [PATCH] base: power: wakeirq: don't leak dev->power.wakeirq
In-Reply-To: <CAOf5uwnj=0m99E96k-+AYu68yE_UnX1WVU-=6y7OvJnfXKh8+g@mail.gmail.com>
References: <1436205678-31640-1-git-send-email-balbi@ti.com>
 <CAOf5uwnj=0m99E96k-+AYu68yE_UnX1WVU-=6y7OvJnfXKh8+g@mail.gmail.com>
Message-ID: <20150706180921.GF20779@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 08:06:17PM +0200, Michael Trimarchi wrote:
> Hi
> 
> On Jul 6, 2015 8:01 PM, "Felipe Balbi" <balbi@ti.com> wrote:
> >
> > on a first call to dev_pm_attach_wake_irq(), if it
> > fails, it will leave dev->power.wakeirq set to a
> > dangling pointer. Instead, let's clear it to make
> > sure a subsequent call to dev_pm_attach_wake_irq()
> > has chance to succeed.
> >
> > Cc: Tony Lindgren <tmlind@atomide.com>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/base/power/wakeirq.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> > index 7470004ca810..394d250a1ad8 100644
> > --- a/drivers/base/power/wakeirq.c
> > +++ b/drivers/base/power/wakeirq.c
> > @@ -50,9 +50,16 @@ static int dev_pm_attach_wake_irq(struct device *dev,
> int irq,
> >
> >         err = device_wakeup_attach_irq(dev, wirq);
> >         if (err)
> > -               return err;
> > +               goto err_cleanup;
> >
> >         return 0;
> > +
> > +err_cleanup:
> > +       spin_lock_irqsave(&dev->power.lock, flags);
> > +       dev->power.wakeirq = NULL;
> > +       spin_unlock_irqrestore(&dev->power.lock, flags);
> > +
> 
> Why here and not in the fuction that return the error?

because the field was set here, why would I clear it elsewhere ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150706/a661deab/attachment-0001.sig>
