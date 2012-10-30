From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 30 Oct 2012 14:37:16 +0000
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <CACRpkdapQJY0aoam741O0fb8EeM9BLk_Psq5TaPG84J7wEvCLw@mail.gmail.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121024161429.GA16350@core.coreip.homeip.net>
 <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
 <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
 <CACRpkdaiLXVeUg1quuw3XPTenbKOjn+aWbGQezpcyvzQCtCWow@mail.gmail.com>
 <20121030113407.GA24335@sirena.org.uk>
 <CACRpkdapQJY0aoam741O0fb8EeM9BLk_Psq5TaPG84J7wEvCLw@mail.gmail.com>
Message-ID: <20121030143715.GP4511@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2012 at 03:02:23PM +0100, Linus Walleij wrote:

> I worry that we will end up with power/resource domain
> code that start to look like this:

> suspend()
> switch (device.id) {
> case DEV_FOO:
>   clk_disable();
>   pinctrl_set_state();
>   power_domain_off();
> case DEV_BAR:

Well, if we're doing that then either we'd presumably either get the
same result if we open code it in the drivers or whoever wrote the
resource domain code for the platform should be creating multiple
domains.

> Another effect is that moving all resource handling to
> power domains is that if we do that for a widely shared
> device driver like the PL011 that mandates that power
> domains need to be implemented for U300, Ux500,
> Nomadik, SPEAr 13xx, 3xx, 6xx, Versatile, Versatile
> Express, Integrator (AP & CP) and BCM2835. Probably
> more.

> Basically power (resource) domains have the side-effect
> of in this light not doing one thing (power domains) but
> instead imposing all-or-nothing imperialistic characteristics.

For me that's happening anyway with explicit control, just in different
places - for example the Freescale guys have had issues with IPs shared
between m68k and i.MX requiring that stub clocks be provided on m68k for
things that are always on there and similarly with all the platforms
that get affected when some widely used chip acquires regulator support.

It seems easier to organise things if the platform has responsibility
for coordinating this stuff than if we add stuff in the drivers.

> I worry that the per-SoC power domain implementation
> which will live in arch/arm/mach-* as of today will become
> the new board file problem, overburdening the arch/* tree.
> Maybe I'm mistaken as to the size of these things,
> but just doing ls arch/arm/mach-omap2/powerdomain*
> makes me start worrying.

One thing to remember is that OMAP has some of the most featureful
hardware out there in terms of software control for power so it's
unlikely to ever get much more complex than that.  IME most SoCs
are very much simpler than that and should be able to punt lots of
stuff to device tree data.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121030/050eb2e6/attachment.sig>
