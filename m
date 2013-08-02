From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 02 Aug 2013 15:09:35 -0700
Subject: [PATCH v1 05/24] clk: wrap I/O access for improved portability
In-Reply-To: <alpine.LFD.2.03.1307181330520.14924@syhkavp.arg>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373914074-20889-6-git-send-email-gsi@denx.de>
 <20130715193829.GS14452@pengutronix.de>
 <20130718070402.GO7080@book.gsilab.sittig.org>
 <20130718091735.GW24642@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1307181330520.14924@syhkavp.arg>
Message-ID: <20130802220935.6450.38975@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Nicolas Pitre (2013-07-18 10:47:22)
> On Thu, 18 Jul 2013, Russell King - ARM Linux wrote:
> 
> > 1. clk_get() and clk_put() are NOT part of the common clock API.
> >    They're separate - they're part of the clk API, and the infrastructure
> >    behind that is clkdev, which is a separately owned thing (by me.)
> > 
> > 2. The "contract" of the clk API is defined by the clk API, not by some
> >    random implementation like the common clock API.  The clk API is
> >    maintained by myself, and is described in include/linux/clk.h
> > 
> > 3. clk_prepare() and clk_unprepare() are functions MUST only be called
> >    from contexts where sleeping is permitted.  These functions MAY sleep
> >    for whatever reason they require to, and as long as they require to.
> >    (This is the whole reason these two functions were created in the
> >    first place.)
> > 
> > 4. clk_enable() and clk_disable() MAY be called from any context, but
> >    MUST never sleep.  If you need to talk over a non-atomic bus for these,
> >    then these functions should be no-ops, and the code which does that
> >    must be executed from the clk_prepare()/clk_unprepare() operations.
> 
> Could the above be included in some form in Documentation/clk.txt (this 
> is likely one of the first location people look for information) and 
> elsewhere if appropriate please?
> 
> A *lot* of people are confused by the prepare-enable-disable-unprepare 
> sequence and when I try to find some rational for the prepare/enable 
> split I can only direct them to mail archive posts since this is nowhere 
> to be found in the kernel.
> 
> The comments in include/linux/clk.h, while correct, are very terse and 
> don't provide any insight to the reason why there is a split in the API.
> 
> The content of Documentation/clk.txt does refer to prepare and enable 
> (and their counterparts) but again doesn't provide any clue about the 
> reason for their existence.
> 
> Since there've been several good posts with usage example now buried 
> into list archives, I think this would go a long way helping people get 
> it right if those were part of the kernel documentation as well.

I'll update Documentation/clk.txt with more verbosity. The document was
originally intended as a "porting guide" to help migrate from legacy
frameworks to the common struct clk implementation. However the scope of
the document should probably be generalized a bit more.

Regards,
Mike

> 
> 
> Nicolas
