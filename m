From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 15 Oct 2015 10:47:09 -0700
Subject: [PATCH] mtd: document linux-specific partition parser DT binding
In-Reply-To: <20151015170428.GA9250@obsidianresearch.com>
References: <1444915191-28350-1-git-send-email-linus.walleij@linaro.org>
 <20151015162210.GA4545@localhost>
 <20151015170428.GA9250@obsidianresearch.com>
Message-ID: <20151015174709.GB108923@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Thu, Oct 15, 2015 at 11:04:28AM -0600, Jason Gunthorpe wrote:
> On Thu, Oct 15, 2015 at 09:22:10AM -0700, Brian Norris wrote:
> 
> > Are you trying to use this binding, or is this just purely a mechanical
> > documentation issue? I ask, because it seems that binding never really
> > got reviewed at all, and others have recently tried to extend
> > support
> 
> I wrote it before ARM started down the DT direction and all these
> formalities were developed.
> 
> > That's not to say we can't document the old one, but I'm curious if
> > there are real users. I'd also like to encourage new users to avoid the
> > old one if we can make that feasible.
> 
> We continue to use it here,

Good to know.

> there is just no way to autodetect flash
> partition layouts.

Right. It'd be lovely if things were more standardized, and we could
just build all parsers in for all MTDs, like how block devices do it,
but sadly that's probably not feasible, given the quirks of various
parsers, and how they often require scanning a large portion of the
device :(

> I'm not fussed about having to change to something
> else in future.

OK, good to know. Recent developments have put maintainers in a tough
position sometimes, since as soon as there's a DT binding used in the
wild, some people like to claim that it is ABI and must never change.
This ties the hands when wanting to deprecate/improve/replace features.
In reality, there are few (my guess: a negligible near-zero-percent) DT
users that actually have DTs locked into some kind of firmware in a way
that they (1) can never update their DT and (2) expect to be able to run
mainline kernels, so this all just becomes a lot of fuss over nothing.

> The reason the original patch exposed the cmdline parser is because
> that is how the internal mechanisms work

Right. And that's why it's best these days not to directly expose
internal mechanisms via DT.

> - but realistically, the
> cmdline parser is a hack to get around the lack of DT partition
> description. If the DT can describe the partitions it should supersede
> and obsolete the old command line hack. IMHO

Hmm, I don't know. I wouldn't expect people should really be using
cmdlineparts as a production solution, but I'd consider it more of a
debugging/development option -- if I want to override the DT (which is
sometimes a bit harder to change) or the on-flash layout (e.g.,
RedBoot), then I can fiddle with the command line. So I wouldn't quite
qualify it as a hack (though many might use it in a hacky way) nor would
I suggest that the DT should override it.

> > Also, if we're really going to support this, we should list exactly what
> > strings we support. And that's one of the problems with the existing
> > binding; it supports any old string Linux supports, which doesn't match
> > how we typically want to add bindings (i.e., via proposal + review).
> 
> That is why it is prefixed with linux, the review of the part parser name is
> the responsibility of the MTD crew, not the DT folks.

OK. That works for now. But I don't want to extend this binding to any
other drivers, if I can help it. And I don't want to encourage it (lest
it *really* becomes ABI).

I don't think it would be too hard to fix this to not be so
Linux-specific. I think any partition layouts that people would want to
specify in DT can be reasonably well-defined to not consider them
Linux-specific. Some probably didn't even have a Linux target in mind
when they were developed. We'd just need to give them better names and a
short description and/or pointers to documentation. e.g. [1][2].

> bcm47xxpart seems like a terrible name for a partition scheme. Really,
> almost any scheme can be used on any SOC, naming a partition parser
> after a SOC family makes very little sense to me..

I believe it was defined purely by Broadcom, for use with their
firmwares mostly seen on that SoC family. And in the spirit of DT
naming, IP often gets named after the first SoC that implements it, even
if later revs aren't the same SoC (or SoC family) but are still
compatible. So I can see the name being reasonable, even if not perfect.

Any better nominations for names?

Brian

[1] http://infocenter.arm.com/help/topic/com.arm.doc.dui0102g/DUI0102F_afs1_4_rg.pdf
[2] https://sourceware.org/redboot/
