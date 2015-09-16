From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Sep 2015 12:06:36 +0200
Subject: [PATCH 01/31] arch/arm/mach-lpc32xx: use kmemdup rather than
 duplicating its implementation
In-Reply-To: <55F93BE5.60508@samsung.com>
References: <1438934377-4922-1-git-send-email-a.hajda@samsung.com>
 <1438934377-4922-2-git-send-email-a.hajda@samsung.com>
 <55F93BE5.60508@samsung.com>
Message-ID: <80137044.ODrprXt1av@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 September 2015 11:52:37 Andrzej Hajda wrote:
> > @@ -87,7 +87,8 @@ static int lpc32xx_pm_enter(suspend_state_t state)
> >       void *iram_swap_area;
> >  
> >       /* Allocate some space for temporary IRAM storage */
> > -     iram_swap_area = kmalloc(lpc32xx_sys_suspend_sz, GFP_KERNEL);
> > +     iram_swap_area = kmemdup((void *)TEMP_IRAM_AREA,
> > +                              lpc32xx_sys_suspend_sz, GFP_KERNEL);
> >       if (!iram_swap_area) {
> >               printk(KERN_ERR
> >                      "PM Suspend: cannot allocate memory to save portion "
> > @@ -95,10 +96,6 @@ static int lpc32xx_pm_enter(suspend_state_t state)
> >               return -ENOMEM;
> >       }
> >  
> > -     /* Backup a small area of IRAM used for the suspend code */
> > -     memcpy(iram_swap_area, (void *) TEMP_IRAM_AREA,
> > -             lpc32xx_sys_suspend_sz);
> 

Hmm, the patch looks correct in principle, but I think I'd rather leave the
original version with the comment in place, because the source is not
just random memory but instead some SRAM.

We might want to use memcpy_fromio()/memcpy_toio here and remove the cast for
both copies instead.

	Arnd
