From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Dec 2017 13:14:17 +0000
Subject: [PATCH] Arm: mm: ftrace: Only set text back to ro after kernel
 has been marked ro
In-Reply-To: <20171205114709.f6aj6i426keq2cn5@camel2.lan>
References: <20170823135836.52fb44fc@gandalf.local.home>
 <CAGXu5jLaQozk-TuZd8o=CK2kBcj3EFqD+VQtGX-DehU=c_TAkg@mail.gmail.com>
 <20170823150351.606ba09f@gandalf.local.home>
 <20171205114709.f6aj6i426keq2cn5@camel2.lan>
Message-ID: <20171205131416.GW10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 12:47:09PM +0100, Matthias Reichl wrote:
> On Wed, Aug 23, 2017 at 03:03:51PM -0400, Steven Rostedt wrote:
> > On Wed, 23 Aug 2017 11:48:13 -0700
> > Kees Cook <keescook@chromium.org> wrote:
> > 
> > > > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > > > index ad80548..fd75f38 100644
> > > > --- a/arch/arm/mm/init.c
> > > > +++ b/arch/arm/mm/init.c
> > > > @@ -745,19 +745,29 @@ static int __mark_rodata_ro(void *unused)
> > > >         return 0;
> > > >  }
> > > >
> > > > +static int kernel_set_to_readonly;  
> > > 
> > > Adding a comment here might be a good idea, something like:
> > > 
> > > /* Has system boot-up reached mark_rodata_ro() yet? */
> > 
> > I don't mind adding a comment, but the above is rather self explanatory
> > (one can easily see that it is set in mark_rodata_ro() with a simple
> > search).
> > 
> > If a comment is to be added, something a bit more descriptive of the
> > functionality of the variable would be appropriate:
> > 
> > /*
> >  * Ignore modifying kernel text permissions until the kernel core calls
> >  * make_rodata_ro() at system start up.
> >  */
> > 
> > I can resend with the comment, or whoever takes this could add it
> > themselves.
> 
> Gentle ping: this patch doesn't seem to have landed in upstream
> trees yet. Is any more work required?
> 
> It would be nice to have this fix added. Just tested next-20171205
> on RPi B+, it oopses when the function tracer is enabled during boot.
> next-20171205 plus this patch boots up fine.

When does it oops?

Reading through this code, I'm left wondering why we switch the rodata
section to be writable here - if we're poking at kernel text, then
surely we shouldn't be the read-only data read-write?

Should kernel_set_to_readonly also be a rodata-after-init variable?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
