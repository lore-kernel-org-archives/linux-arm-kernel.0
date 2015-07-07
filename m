From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Tue, 7 Jul 2015 09:40:05 +0200
Subject: RFC: default ioremap_*() variant defintions
In-Reply-To: <CAPcyv4jqsB+K5EsYqi1jssWqZV-55Q_Xz=beHXZPL0T6VvpawQ@mail.gmail.com>
References: <20150703181709.GD7021@wotan.suse.de>
 <CAPcyv4jqsB+K5EsYqi1jssWqZV-55Q_Xz=beHXZPL0T6VvpawQ@mail.gmail.com>
Message-ID: <20150707074005.GN7021@wotan.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 04, 2015 at 06:54:40AM -0700, Dan Williams wrote:
> On Fri, Jul 3, 2015 at 11:17 AM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> > I have no idea why its not picking up asm-generic ioremap_uc() for x86,
> 
> x86 does not use "include/asm-generic/io.h".  That's a helper-include
> for archs that want to use it, but it's incomplete, see the patch
> referenced below...

Ah it includes iomap.h not io.h odd...

> > although this is the right thing to do the guard should not work as we never
> > define ioremap_uc() as a macro but we do as an exported symbol. The way
> > archs do their ioremap calls is they define externs and then they include
> > asm-generic to pick up the things they don't define. In the extern calls
> > for ioremap_uc() we never add a define there. Adding a simple one line
> > #define right after the extern declaration to itself should suffice to
> > fix paranoia but curious why this does work as-is right now.
> >
> > I'd like review and consensus from other architecture folks if this is
> > the Right Thing To Do (TM) and if it is decide how we want to fix this.
> > For instance my preference would be to just add this fix as-is after
> > we've figured out the guard thing above, and then define these variants
> > in the documentation on the asm-generic file as safe to not have, and
> > safe to map to the default ioremap call. If you don't have a safe call
> > like this we should set out different expectations, for instance having
> > it depend on Kconfig symbol and then drivers depend on it, archs then
> > implement the symbols and can HAVE_ARCH_FOO. If everyone agrees with
> > this then there is quite a bit of cleanup possible as tons of archs do
> > tons of their own variant mapping definitions.
> 
> We're also discussing this issue in the patch here:
> 
> https://lkml.org/lkml/2015/6/22/98
> "[PATCH v5 2/6] arch: unify ioremap prototypes and macro aliases":

Great, you've done all the exact work I expected we needed to do ;)

> Russell mentioned wanting to fix up ioremap_wt() for ARM [1], after
> which I would look to re-spin this patch with the interface proposed
> by Christoph [2].
> 
> [1]: https://lkml.org/lkml/2015/7/1/125
> [2]: https://lkml.org/lkml/2015/6/22/391

OK thanks I guess I'll jump in there as I have some feedback.

  Luis
