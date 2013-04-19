From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Apr 2013 16:21:54 +0200
Subject: [PATCH 1/2] ARM: default machine descriptor for multiplatform
In-Reply-To: <20130419132848.GO14496@n2100.arm.linux.org.uk>
References: <1365779468-116419-1-git-send-email-arnd@arndb.de>
 <20130419132848.GO14496@n2100.arm.linux.org.uk>
Message-ID: <201304191621.54681.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 April 2013, Russell King - ARM Linux wrote:
> On Fri, Apr 12, 2013 at 05:11:07PM +0200, Arnd Bergmann wrote:
> > @@ -752,7 +761,7 @@ void __init setup_arch(char **cmdline_p)
> >  
> >       setup_processor();
> >       mdesc = setup_machine_fdt(__atags_pointer);
> > -     if (!mdesc)
> > +     if (!mdesc && __machine_arch_type != ~0)
> >               mdesc = setup_machine_tags(__atags_pointer, __machine_arch_type);
> >       machine_desc = mdesc;
> >       machine_name = mdesc->name;
> 
> If mdesc is NULL and __machine_arch_type is ~0, then mdesc remains NULL.
> That means machine_desc is NULL (which is probably very bad), and the
> initialization of machine_name causes a NULL pointer dereference.
> 
> This is clearly wrong.  mdesc must never be NULL if you're using FDT
> here, so the original code should be fine.

Ah, right. I think was a leftover from an earlier version of the
patch where I only assigned the default platform after this.

There is also a related mistake in setup_machine_fdt, the second
change is not needed there either AFAICT.

Thanks for taking a look!

	Arnd
