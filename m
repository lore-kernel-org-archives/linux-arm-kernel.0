From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Wed, 6 Feb 2013 06:04:22 +0000
Subject: [PATCH V2 1/6] pinctrl: pinctrl-single: use arch_initcall and
 module_exit
In-Reply-To: <20130205112731.GK17786@n2100.arm.linux.org.uk>
References: <1359445134-13323-1-git-send-email-manishv.b@ti.com>
 <1359445134-13323-2-git-send-email-manishv.b@ti.com>
 <CACRpkdbf7TwrjfT2rhqQFGc3yh_Nt117RtzQO2y6g5Ddx5Ay_w@mail.gmail.com>
 <20130201170906.GE22517@atomide.com> <20130201171124.GF22517@atomide.com>
 <A4887BF146CD57468F700B415D2F47015828C7@DBDE01.ent.ti.com>
 <20130205112731.GK17786@n2100.arm.linux.org.uk>
Message-ID: <A4887BF146CD57468F700B415D2F4701583209@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Feb 05, 2013 at 16:57:31, Russell King - ARM Linux wrote:
> On Tue, Feb 05, 2013 at 06:36:34AM +0000, Vishwanathrao Badarkhe, Manish wrote:
> > I made following changes, in order to update "dip->p" pointer with 
> > correct value:
> > 
> > -       if (!dpi->p) {
> > +       if (IS_ERR_OR_NULL(dpi->p)) {
> >                 dpi->p = devm_pinctrl_get(dev);
> > -               if (IS_ERR_OR_NULL(dpi->p)) {
> > -                       int ret = PTR_ERR(dpi->p);
> > -
> > -                       dev_dbg(dev, "no pinctrl handle\n");
> > -                       /* Only return deferrals */
> > -                       if (ret == -EPROBE_DEFER)
> > -                               return ret;
> > -                       return 0;
> > -               }
> > +               ret = PTR_ERR(dpi->p);
> > +               dev_dbg(dev, "no pinctrl handle\n");
> > +               /* Only return deferrals */
> > +               if (ret == -EPROBE_DEFER)
> > +                       return ret;
> > +               return 0;
> > 
> > Is this intended change?
> 
> The above looks totally broken to me.
> 
> Oh, it's using IS_ERR_OR_NULL(), so it's bound to be broken.
> 

I went through discussion in community on usage of "IS_ERR_OR_NULL".
https://patchwork.kernel.org/patch/1953271/
Will take care not use this in future.

Thanks,
Manish
