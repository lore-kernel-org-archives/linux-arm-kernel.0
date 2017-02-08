From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Feb 2017 10:01:42 +0100
Subject: [GIT PULL 1/2] Broadcom dts changes for 4.11 (part 2)
In-Reply-To: <87wpd1h838.fsf@eliezer.anholt.net>
References: <20170202020607.31682-1-f.fainelli@gmail.com>
 <CAK8P3a2FtHbtvnzdf6UN2JxA4Uj34AW_bhD1TuBQJJbU5TdoVA@mail.gmail.com>
 <87wpd1h838.fsf@eliezer.anholt.net>
Message-ID: <2177299.CJQXaYRB83@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 7, 2017 3:52:43 PM CET Eric Anholt wrote:
> Arnd Bergmann <arnd@arndb.de> writes:

n we can take all other changes.
> >
> > For the bcm2835, try coming up with a branch that doesn't need the
> > dependency and send that separately. There are three common ways
> > to do that:
> >
> > - rebase the patches on top of the commit that introduced the header file
> >   change, provided that one sits directly on top of an -rc without any
> >   driver patches below it (or in the same patch)
> > - change the dts files to refer to the clk by numeric value instead of the
> >   macro name, then follow up with a patch to use the name for a later
> >   release
> > - defer the whole branch for the next kernel release.
> 
> OK, if we can't merge the topic branch, I'll just punt on this for the
> next release.  From previous topic branch merges, I thought the rule was
> "it's OK as long as you have the subsystem maintainer's ack."

I should probably explain this a bit more: We never liked those dependencies
but let them slip through in the past, as there isn't a lot of damage.

For a while we had a 'next/late' branch in which we queued up changes that
had dependencies on other branches, and then we sent that branch to Linus
once the dependencies were all merged. This works, but it's always been
annoying, so we try to avoid it completely now.

The kernel releases are frequent enough that waiting for another merge window
isn't a big deal if you plan for it in advance. Also, a lot of the header
file dependencies are completely avoidable: In some cases not using a header
leads to a better binding: e.g. most interrupt controllers just enumerate
their IRQ lines so there is no ambiguity regarding which line has which number.
For clk controllers this is often but not always the case, but often enough
you at least know what clocks are present and can give them names without
having to implement every single clk output setting in the clk controller.

	Arnd
