From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 30 Jan 2012 17:32:02 +0000
Subject: [PATCH v6 6/9] ARM: vexpress: Motherboard RS1 memory map support
In-Reply-To: <1327672960.24701.55.camel@hornet.cambridge.arm.com>
References: <1323957761-13553-1-git-send-email-pawel.moll@arm.com>
 <1323957761-13553-7-git-send-email-pawel.moll@arm.com>
 <4F047FE1.5030002@citrix.com>
 <1326979266.32197.60.camel@hornet.cambridge.arm.com>
 <4F184900.8050901@citrix.com>
 <1327672960.24701.55.camel@hornet.cambridge.arm.com>
Message-ID: <20120130173202.GG2248@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 02:02:40PM +0000, Pawel Moll wrote:
> On Thu, 2012-01-19 at 16:46 +0000, David Vrabel wrote:
> > >>  __create_page_tables has only mapped the single physical
> > >> page at 0x1c090000 and thus the test for the UART in the other memory
> > >> map faults.
> 
> I got to the bottom of the problem... The mapping created by the
> DEBUG_LL code in __create_page_tables is actually a section (1MB) so
> covers both possible accesses (0xf8009000 and 0xf8090000). The
> difference between model and hardware is that "real" RS1 VE has a DAP
> ROM located between 0xf8000000 and 0xf800ffff so the 0xf8009000 succeeds
> (returning some irrelevant data), while model is "empty" in that space,
> so it faults.
> 
> Anyway, I have an idea how to solve (or rather work around) the problem
> and will get if working on models in the next version of the series.
> I'll send you a modified version of the relevant patch before that so
> you can test it.
> 
> Thanks for your time!

I would be interested in that too.

However, I would still prefer the explicit debug UART selection route,
since we already have to do that for many boards and I'm not sure how
much I trust the memory maps of future tiles and models to "evolve"
relative to what currently exists.  Are you sure it won't change again?

If we rely on lucky arrangement of slaves on the bus in order to have
a workaround, sooner or later our luck is liable to run out.

Cheers
---Dave
