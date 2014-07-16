From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Wed, 16 Jul 2014 08:45:58 -0300
Subject: [PATCH 1/5] [RFC-HACK] pinctrl-single: init by postcore_initcall()
In-Reply-To: <20140522233154.GE29577@atomide.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
 <1400799986-20043-2-git-send-email-chf.fritz@googlemail.com>
 <20140522233154.GE29577@atomide.com>
Message-ID: <20140716114558.GA1842@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 May 04:31 PM, Tony Lindgren wrote:
> * Christoph Fritz <chf.fritz@googlemail.com> [140522 16:07]:
> > --- a/drivers/pinctrl/pinctrl-single.c
> > +++ b/drivers/pinctrl/pinctrl-single.c
> > @@ -2069,7 +2069,22 @@ static struct platform_driver pcs_driver = {
> >  #endif
> >  };
> >  
> > +#ifdef CONFIG_USE_OF
> > +static int __init pcs_driver_drv_init(void)
> > +{
> > +       return platform_driver_register(&pcs_driver);
> > +}
> > +postcore_initcall(pcs_driver_drv_init);
> > +
> > +static void __exit pcs_driver_drv_exit(void)
> > +{
> > +       platform_driver_unregister(&pcs_driver);
> > +}
> > +module_exit(pcs_driver_drv_exit);
> > +#else
> >  module_platform_driver(pcs_driver);
> > +#endif
> > +
> 
> I would prefer to initialize all the drivers with module_init
> and and if necessary, selected frameworks with subsys_initcall. 
> 
> In drivers/Makefile we do have painctrl before gpio, so this
> too could be just module_init once the other drivers are fixed.
> 

I've been using patches that change gpio and i2c initialization to module_init
for some time now. However, I still see some non-DT boards using the GPIO API
in early functions such as .init_machine.

Only when these boards get converted and the legacy support is dropped, we'll
be able to move all the drivers to module_init.
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
