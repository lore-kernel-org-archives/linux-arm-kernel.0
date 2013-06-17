From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jun 2013 00:40:06 -0700
Subject: IGEPv2 audio problem
In-Reply-To: <20130616181004.513e5579@skate>
References: <20130616135208.3f124c2c@skate> <51BDAD7F.8090303@collabora.co.uk>
 <20130616153406.1c8096fa@skate> <51BDDD26.3000203@collabora.co.uk>
 <20130616181004.513e5579@skate>
Message-ID: <20130617074005.GE4465@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thomas Petazzoni <thomas.petazzoni@free-electrons.com> [130616 09:16]:
> On Sun, 16 Jun 2013 17:43:34 +0200, Javier Martinez Canillas wrote:
> 
> > > Also, there is a fairly significant issue with the DT based booting:
> > > the Ethernet controller is not enabled apparently.
> > > 
> > 
> > Yes, this is a known issue. The problem is that the smsc911x chip is using a
> > GPIO line as IRQ but the OMAP GPIO bank is not initialized before the call to
> > request_irq() is made on the smsc911x probe function. An explicit call to
> > gpio_request() is needed to enable the GPIO bank.
> > 
> > For legacy booting this is done in arch/arm/mach-omap2/gpmc-smsc911x.c but for
> > DT based booting this is never made. That is why ethernet is not currently
> > working since request_irq() is failing.
> > 
> > There was a very long discussion on linux-omap with Jon Hunter, Linus Walleij,
> > Grant Likely (cc'ed now) and others about the best approach to solve this. I
> > posted a RFC patch [1] to add a .irq_request function handler to struct irq_chip
> > so gpio_request() could be called by the IRQ core on setup.
> > 
> > Linus said that the right solution is to have some GPIO "hogging" that describes
> > which GPIO pins could be used as IRQ so the banks could be pre-initialized while
> > Jon said that the best approach is to call gpio_request() on a custom xlate
> > handler for the GPIO OMAP, like is made here [2] for the at91 chip. Grant seems
> > to agree with Jon so probably that is how we are finally solve this issue.
> > 
> > For now I'm carrying this HACK patch [3] on my dev tree to make the smsc911x LAN
> > chip to work on my IGEPv2 board.
> 
> For sure, the process of getting proper DT bindings merged can be
> complicated in some situations, and it's not really the point I'm
> criticizing. The point I'm making is really that *while* this process
> of getting proper DT bindings accepted takes place, users get a broken
> kernel.

We can initialize the smsc911x code with pdata until the issue is sorted
out to keep things working. 
 
> > Yes, I also admit that the process has been a little bit frustrating for people
> > like me trying to maintain an OMAP3 board. For legacy booting Enric and I used
> > to fix the issues found with IGEP boards but it was getting every time more hard
> > to get the patches accepted until I decided it was not worth spending my (free)
> > time on it.
> 
> Sure, I understand.
> 
> > So I started adding DT support for IGEP boards and hacking some drivers like
> > smsc911x and GPMC but there is still a long way to get all the hardware support
> > we already have today with board files. DSS bindings have not landed in mainline
> > yet, USB HOST and OTG are not working for me and now you say that twl4030 audio
> > is not working either...
> 
> Again, I'm not concerned about the time it takes to get proper DT
> bindings merged. I'm working on some DT bindings for Marvell SoC, and
> it's a long process. But while this process takes place, we're careful
> not to break users by ensuring that devices that cannot be probed
> through DT are probed in a legacy fashion.

Yes we should keep things working constantly. I too am quite frustrated
how many drivers break every merge window :( For the current omap4 DT
conversion, we've tried to make sure the basic features continue working, but
of course work is also needed by the board maintainers to configure and
enable various devices for the DT based booting.

Regards,

Tony 
