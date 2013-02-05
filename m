From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Feb 2013 22:23:04 +0000
Subject: [PATCH, RFC] default machine descriptor for multiplatform
In-Reply-To: <CAL_JsqJ2SyGeJePvNh5fREWP5LcAxnvNsiq2=kKNxKrnquyy3Q@mail.gmail.com>
References: <20130131092024.GN2637@n2100.arm.linux.org.uk>
 <1638002.UJ7zfj1Wn5@wuerfel>
 <CAL_JsqJ2SyGeJePvNh5fREWP5LcAxnvNsiq2=kKNxKrnquyy3Q@mail.gmail.com>
Message-ID: <201302052223.04807.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 February 2013, Rob Herring wrote:
> >
> > + if (IS_ENABLED(CONFIG_ARCH_MULTIPLATFORM)) {
> > + DT_MACHINE_START(GENERIC_DT, "Generic DT based system")
> > + MACHINE_END
> 
> I assume this works, but it looks a bit strange declared here.

Yes, I was wondering whether it should be global instead, but that
would require an #ifdef, or enabling it for all DT-based builds, not
just those with ARCH_MULTIPLATFORM.


> >  static int __init customize_machine(void)
> >  {
> > - /* customizes platform devices, or adds new ones */
> > + /*
> > + * customizes platform devices, or adds new ones
> > + * On DT based machines, we fall back to populating the
> > + * machine from the device tree, if no callback is provided,
> > + * otherwise we would always need an init_machine callback.
> > + */
> >   if (machine_desc->init_machine)
> >   machine_desc->init_machine();
> > + else
> > + of_platform_populate(NULL, of_default_bus_match_table,
> > + NULL, NULL);
> 
> Could this be unconditional? It should be safe to call multiple times
> if a platform calls this first because ordering matters or there are
> custom match tables. I would guess any ordering requirements need to
> happen before this call anyway.

Yes, possible, but that needs more testing to avoid potential regressions.

	Arnd
