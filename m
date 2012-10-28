From: pavel@denx.de (Pavel Machek)
Date: Mon, 29 Oct 2012 00:13:30 +0100
Subject: arm-soc tree was Re: [PATCH] Fix socfpga compilation with
 early_printk() enabled
In-Reply-To: <20121028230153.GA8284@elf.ucw.cz>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <201210251458.48528.arnd@arndb.de>
 <20121027115615.GC5912@elf.ucw.cz>
 <201210271539.20156.arnd@arndb.de>
 <20121028230153.GA8284@elf.ucw.cz>
Message-ID: <20121028231330.GB8284@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > > This fixes early_printk() compilation for
> > > > > socfpga. (senduart/busyuart/waituart were missing). It does that by
> > > > > making Picochip code generic.
> > > > > 
> > > > > Signed-off-by: Pavel Machek <pavel@denx.de>
> > > > > Acked-by: Dinh Nguyen <dinguyen@altera.com>
> > > > > Acked-by: Jamie Iles <jamie@jamieiles.com 
> > > > 
> > > > Applied to fixes branch of arm-soc, but please be more explicit about
> > > > what you want to happen with patches in the future. Ideally we would
> > > > get pull requests for patches on each platform from only one person,
> > > > so please coordinate with Dinh Nguyen who that should be.
> > > 
> > > Dinh is the maintainer, so if we can only send patches from one
> > > person, it needs to be him. If you'd be willing to take patches from
> > > second person, that would help us... if not, of course I can send all
> > > the patches through Dinh.
> > 
> > You can both send patches, we just need to know what to expect. For most
> > platforms it works best if one person collects the patches from
> > everyone.
> 
> > If you are sending patches with both Dinh and us as the recipients,
> > just make it clear who you want to pick up the patch.
> 
> Thanks. Would "[PATCH for soc]" in subject line be suitable markup?
> 
> BTW current for-next soc tree does not compile for me, with 
> 
> arch/arm/mach-vexpress/built-in.o: In function `v2m_timer_init':
> hotplug.c:(.init.text+0xd0): undefined reference to
> `vexpress_clk_init'
> arch/arm/mach-vexpress/built-in.o: In function `v2m_dt_timer_init':
> hotplug.c:(.init.text+0x100): undefined reference to
> `vexpress_clk_of_init'
> make: *** [vmlinux] Error 1

Aha, grep shows:

arch/arm/mach-vexpress/v2m.c:   vexpress_clk_init(ioremap(V2M_SYSCTL, SZ_4K));
include/linux/vexpress.h:void vexpress_clk_init(void __iomem *sp810_base);

...seems vexpress_clk_init is not there, yet... And what is more
serious:

pavel at amd:~/mainline-altera/linux$ grep mach-vexpress MAINTAINERS
pavel at amd:~/mainline-altera/linux$ 

vexpress_clk_of_init();     has same problem.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
