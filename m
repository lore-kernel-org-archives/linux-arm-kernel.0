From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Nov 2013 09:53:34 +0000
Subject: [PATCH 17/31] ASoC: tegra: call pm_runtime APIs around register
 accesses
In-Reply-To: <528A96EC.4040409@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-18-git-send-email-swarren@wwwdotorg.org>
 <20131116100205.GG15393@sirena.org.uk>
 <528A4D9A.10809@wwwdotorg.org>
 <20131118183947.GS2674@sirena.org.uk>
 <528A96EC.4040409@wwwdotorg.org>
Message-ID: <20131119095334.GW2674@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 03:38:36PM -0700, Stephen Warren wrote:

> 1) regcache_sync() doesn't mean "if the cache is dirty, flush the
> dirty registers to HW", but rather, "if the cache is dirty, write any
> registers that don't match HW defaults to HW". If the HW was in
> cache-only mode because simply because clocks were turned off but not
> power, then the register values were retained, and the current HW
> register values may not be "HW defaults", and you may in fact /need/
> to write a value to HW that matches the HW default, yet is different
> from the current retained register content.

OK, that's a potential problem in general...  Fortunately most of the
uses actually cut power.

> a) Make regmap creation read the initial HW state to use as HW
> defaults when the regmap is created. IIRC, this is done for some
> regmap configurations but not others. That said, this doesn't seem
> correct, since there's no guarantee that the HW state when the regmap
> is created /is/ the default HW state.

Right, this is why we don't initialise the cache by default.

> I think I still prefer option (c).

there's also the option of doing an explicit read on that register to
get it into the cache.  But yeah, like I say I'm not totally against
this and I did ack it already.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/c92c707d/attachment.sig>
