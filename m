From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 9 Feb 2016 12:36:24 +0100
Subject: [PATCH] ARM: ks8695: fix __initdata annotation
In-Reply-To: <18237653.x9qPaNvtCU@wuerfel>
References: <1454941509-2773774-1-git-send-email-arnd@arndb.de>
 <20160209090030.GS13664@pengutronix.de>
 <18237653.x9qPaNvtCU@wuerfel>
Message-ID: <20160209113624.GU13664@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Tue, Feb 09, 2016 at 12:14:15PM +0100, Arnd Bergmann wrote:
> On Tuesday 09 February 2016 10:00:30 Uwe Kleine-K?nig wrote:
> > > diff --git a/arch/arm/mach-ks8695/board-og.c b/arch/arm/mach-ks8695/board-og.c
> > > index 1f4f2f4f25bb..fa1a7c2ca2bb 100644
> > > --- a/arch/arm/mach-ks8695/board-og.c
> > > +++ b/arch/arm/mach-ks8695/board-og.c
> > > @@ -80,7 +80,7 @@ static void __init og_pci_bus_reset(void)
> > >  #define      S8250_VIRT      0xf4000000
> > >  #define      S8250_SIZE      0x00100000
> > >  
> > > -static struct __initdata map_desc og_io_desc[] = {
> > > +static struct map_desc __initdata og_io_desc[] = {
> > 
> > I would have expected that
> > 
> > +static struct map_desc og_io_desc[] __initdata = {
> > 
> > is the correct variant?
> > 
> 
> I think those two mean the exact same thing, and we have tons of examples
> for either one in the kernel, unlike the one I removed. I have
> verified that the resulting object files are identical.
> 
> Can you point me to some documentation that clarifies which one to use,
> and why?

Having the attribute list after the declarator isn't recommended as
explicit as I remember having read it somewhere in the gcc docs.

	info gcc "Attribute Syntax"

has:

	 An attribute specifier list may appear immediately before a declarator
	(other than the first) in a comma-separated list of declarators in a
	declaration of more than one identifier using a single list of
	specifiers and qualifiers.  Such attribute specifiers apply only to the
	identifier before whose declarator they appear.  For example, in

	     __attribute__((noreturn)) void d0 (void),
		 __attribute__((format(printf, 1, 2))) d1 (const char *, ...),
		  d2 (void)

	the 'noreturn' attribute applies to all the functions declared; the
	'format' attribute only applies to 'd1'.

(Funny enough, in the example the attribute specifier list doesn't
appear *immediately* before the declarator d0.)

This might be interpreted as "usually the attribute specifier list appears
after the declarator". Other than that I cannot find an explict
recommended placement in the docs. The examples in

	info gcc "Variable Attributes"

always have the attribute list after the declarator.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
