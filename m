From: broonie@kernel.org (Mark Brown)
Date: Tue, 8 Oct 2013 11:44:57 +0100
Subject: [RFC] ASoC: pcm: Trigger all commands on error
In-Reply-To: <20131008094839.GB19005@pengutronix.de>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
 <20131007172706.GS21581@sirena.org.uk>
 <20131008082933.GA19005@pengutronix.de>
 <20131008093413.GX21581@sirena.org.uk>
 <20131008094839.GB19005@pengutronix.de>
Message-ID: <20131008104457.GA21581@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 11:48:39AM +0200, Markus Pargmann wrote:
> On Tue, Oct 08, 2013 at 10:34:13AM +0100, Mark Brown wrote:

> > I meant just unwinding the things done in the trigger call.

> You mean unwinding when we detect the error? If we return the
> error code from the trigger function, the pcm_native.c will still
> trigger a STOP command which is executed on all components.

Sure, but it's another way of getting consistency and does seem a bit
more obvious.

> > > Another possibility is to explicitly allow multiple _STOPs. Then I could
> > > fix the driver to store the clock state. But I would prefer a generic
> > > solution.

> > You're going to have to handle this anyway to be robust - what happens
> > if it's the clock enable that fails?

> If clk_enable fails, we can return an error code in the mxs-saif trigger
> function. Of course the error handling is missing here, but it is not
> necessary to store the state of the clock to handle errors properly.

Right, but then _STOP will be called without the clock having been
successfully enabled so you'll have an unbalanced clk_disable().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131008/037852cf/attachment.sig>
