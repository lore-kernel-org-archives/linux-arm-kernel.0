From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 8 Oct 2013 11:48:39 +0200
Subject: [RFC] ASoC: pcm: Trigger all commands on error
In-Reply-To: <20131008093413.GX21581@sirena.org.uk>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
 <20131007172706.GS21581@sirena.org.uk>
 <20131008082933.GA19005@pengutronix.de>
 <20131008093413.GX21581@sirena.org.uk>
Message-ID: <20131008094839.GB19005@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 10:34:13AM +0100, Mark Brown wrote:
> On Tue, Oct 08, 2013 at 10:29:33AM +0200, Markus Pargmann wrote:
> 
> > To make proper error handling and only STOP functions that successfully
> > started, we have to store the state of each function. The command error
> > handling is done in pcm_native.c so we don't have any influence on that.
> 
> I meant just unwinding the things done in the trigger call.

You mean unwinding when we detect the error? If we return the
error code from the trigger function, the pcm_native.c will still
trigger a STOP command which is executed on all components.

> 
> > Another possibility is to explicitly allow multiple _STOPs. Then I could
> > fix the driver to store the clock state. But I would prefer a generic
> > solution.
> 
> You're going to have to handle this anyway to be robust - what happens
> if it's the clock enable that fails?

If clk_enable fails, we can return an error code in the mxs-saif trigger
function. Of course the error handling is missing here, but it is not
necessary to store the state of the clock to handle errors properly.

Regards,

Markus


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
