From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jul 2012 00:02:33 +0100
Subject: [PATCH v3 1/3] ARM: omap: clk: add clk_prepare and clk_unprepare
In-Reply-To: <CAJOA=zPmfq+WsAF-7nAkMGghPLYHpd+fCkrsv=3JSWLGMb-zkg@mail.gmail.com>
References: <1341224669-15231-1-git-send-email-rnayak@ti.com>
 <1341224669-15231-2-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1207301614590.8722@utopia.booyaka.com>
 <CAJOA=zPmfq+WsAF-7nAkMGghPLYHpd+fCkrsv=3JSWLGMb-zkg@mail.gmail.com>
Message-ID: <20120730230233.GA12574@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 03:42:13PM -0700, Turquette, Mike wrote:
> On Mon, Jul 30, 2012 at 3:31 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > So if we make a change like this one, it seems like we would basically
> > expect it to break once we start doing anything meaningful with
> > clk_prepare(), like using clk_prepare() for voltage scaling or something
> > that requires I2C?  We'd also probably want to mark this with some kind of
> > "HACK" comment.
> 
> Hi Paul,
> 
> Did you have anything in mind to start using clk_prepare?  I still
> hope to get rid of it some day and replace that call with a
> combination of clk_enable and a check like clk_enable_can_sleep.

Don't you dare.

We arrived at the clk_prepare()/clk_enable() split after lots of
discussion between different platform maintainers and their
requirements.

Shoving crap like "clk_enable_can_sleep()" down into drivers is
totally and utterly idiotic.  We've had the situation *already*
where some drivers can be used on some platforms but not on others
because of differences in clk_enable() expectations.

Don't go back there.  clk_prepare() and clk_enable() are separate
calls for a very good reason.  One is sleepable, the other can be
called from any atomic contexts.
