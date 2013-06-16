From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 16 Jun 2013 18:10:04 +0200
Subject: IGEPv2 audio problem
In-Reply-To: <51BDDD26.3000203@collabora.co.uk>
References: <20130616135208.3f124c2c@skate> <51BDAD7F.8090303@collabora.co.uk>
 <20130616153406.1c8096fa@skate> <51BDDD26.3000203@collabora.co.uk>
Message-ID: <20130616181004.513e5579@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Javier Martinez Canillas,

On Sun, 16 Jun 2013 17:43:34 +0200, Javier Martinez Canillas wrote:

> > $ dmesg | grep Flattened
> > [    0.000000] Machine: Generic OMAP3 (Flattened Device Tree), model: IGEPv2
> >
> 
> Thanks a lot for testing and the feedback. I'll investigate this as soon as I
> have access to my IGEPv2 board again.

Great, thanks. If there's anything I can test/try to provide more
informations (such as enabling some ALSA debugging option), don't
hesitate to let me know

> > Also, there is a fairly significant issue with the DT based booting:
> > the Ethernet controller is not enabled apparently.
> > 
> 
> Yes, this is a known issue. The problem is that the smsc911x chip is using a
> GPIO line as IRQ but the OMAP GPIO bank is not initialized before the call to
> request_irq() is made on the smsc911x probe function. An explicit call to
> gpio_request() is needed to enable the GPIO bank.
> 
> For legacy booting this is done in arch/arm/mach-omap2/gpmc-smsc911x.c but for
> DT based booting this is never made. That is why ethernet is not currently
> working since request_irq() is failing.
> 
> There was a very long discussion on linux-omap with Jon Hunter, Linus Walleij,
> Grant Likely (cc'ed now) and others about the best approach to solve this. I
> posted a RFC patch [1] to add a .irq_request function handler to struct irq_chip
> so gpio_request() could be called by the IRQ core on setup.
> 
> Linus said that the right solution is to have some GPIO "hogging" that describes
> which GPIO pins could be used as IRQ so the banks could be pre-initialized while
> Jon said that the best approach is to call gpio_request() on a custom xlate
> handler for the GPIO OMAP, like is made here [2] for the at91 chip. Grant seems
> to agree with Jon so probably that is how we are finally solve this issue.
> 
> For now I'm carrying this HACK patch [3] on my dev tree to make the smsc911x LAN
> chip to work on my IGEPv2 board.

For sure, the process of getting proper DT bindings merged can be
complicated in some situations, and it's not really the point I'm
criticizing. The point I'm making is really that *while* this process
of getting proper DT bindings accepted takes place, users get a broken
kernel.

> Yes, I also admit that the process has been a little bit frustrating for people
> like me trying to maintain an OMAP3 board. For legacy booting Enric and I used
> to fix the issues found with IGEP boards but it was getting every time more hard
> to get the patches accepted until I decided it was not worth spending my (free)
> time on it.

Sure, I understand.

> So I started adding DT support for IGEP boards and hacking some drivers like
> smsc911x and GPMC but there is still a long way to get all the hardware support
> we already have today with board files. DSS bindings have not landed in mainline
> yet, USB HOST and OTG are not working for me and now you say that twl4030 audio
> is not working either...

Again, I'm not concerned about the time it takes to get proper DT
bindings merged. I'm working on some DT bindings for Marvell SoC, and
it's a long process. But while this process takes place, we're careful
not to break users by ensuring that devices that cannot be probed
through DT are probed in a legacy fashion.

For example, we recently merged the PCIe DT bindings (and corresponding
driver) for Marvell SoC, and all the Marvell Kirkwood boards who were
using legacy probing to instantiate their PCIe controllers have been
switched to DT probing. With absolutely no disruption for the users:
they were using DT-based booting before, they are still using DT-based
booting. The only change is that PCIe controllers are no longer
legacy-probed, but DT-probed.

> In fact the same path is being used for OMAP. There is a board-generic.c in
> mach-omap2 that is compatible with "ti,omap{3,4,5}". If you look to the
> omap_generic_init() .init_machine handler for this board file, you will see that
> the display is explicitly initialized for panda and panda sdp using C function
> calls and platform device/data since the OMAP DSS DT bindings are still not
> available [4].

Yes, I've seen that it's used for the specific case of the display. But
my proposal would be to generalize that completely.

> I think the problem is not with the process but that OMAP3 is not been tested
> correctly due lack of manpower. So now we have OMAP3 legacy boot broken and
> deprecated but we are still far from having everything working with DT. I don't
> really know how we can solve this...

See what mach-kirkwood is doing. Simple and efficient.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
