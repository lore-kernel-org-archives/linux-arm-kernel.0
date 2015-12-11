From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Dec 2015 15:46:53 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <20151211133601.GB18249@io.lakedaemon.net>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <14967875.ttNXUbSTvS@wuerfel> <20151211133601.GB18249@io.lakedaemon.net>
Message-ID: <3272371.tle8Qz0NMz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 December 2015 13:36:01 Jason Cooper wrote:
> +Josh
> 
> Hey Arnd, Detlef,
> 
> On Fri, Dec 11, 2015 at 12:10:55AM +0100, Arnd Bergmann wrote:
> > On Thursday 10 December 2015 23:00:24 Detlef Vollmann wrote:
> > > On 12/10/15 22:29, Arnd Bergmann wrote:
> > > > On Thursday 10 December 2015 22:14:25 Detlef Vollmann wrote:
> > > >> On 12/10/15 21:59, Arnd Bergmann wrote:
> > > > It may also be worth investigating what has made CONFIG_OF so costly,
> > > Probably because too much is done at runtime and too few things can
> > > be fixed at build time.
> > > 
> > > > maybe we can reduce this a bit again.
> > > Probably not without turning the wheel backward 
> > > 
> > > So for the test: yes it works, but I'm unhappy with it.
> > 
> > I'm not too happy about adding 80kb to the uncompressed kernel 
> > image either. I've spent some more time now trying to find where
> > we added the bloat. It's mainly in drivers, not in arch specific
> > code, a kilobyte here and there eventually adds up, but the largest
> > portion with a little over 50% of the total diff is drivers/of.
> 
> Wasn't there an idea kicked around a while ago to create a
> dt2boardfile script/executable*?  Then, during kernel configuration, you
> enable it and select which dts file you want.  It would disable
> CONFIG_OF, multiplatform, etc.  And generate a board_file.c from the dts
> file.

I think you are right this has come up in the past, but I don't see how
it would work in practice without significant changes to driver subsystems:

The way we describe devices in DT is often very different from what we
have for the traditional board files, and in some cases we don't even
support platform data any more, so this would still depend on having
properties according to the DT bindings, and require a large chunk of
the same code that is doing DT at the moment.

	Arnd
