From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 8 Oct 2013 10:29:33 +0200
Subject: [RFC] ASoC: pcm: Trigger all commands on error
In-Reply-To: <20131007172706.GS21581@sirena.org.uk>
References: <1380883997-18236-1-git-send-email-mpa@pengutronix.de>
 <20131007172706.GS21581@sirena.org.uk>
Message-ID: <20131008082933.GA19005@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 06:27:06PM +0100, Mark Brown wrote:
> On Fri, Oct 04, 2013 at 12:53:17PM +0200, Markus Pargmann wrote:
> 
> > In case of a start command, the calling function will call undo_start,
> > calling this trigger function with the stop command. It will call stop
> > for each function. But only the first function was started previously.
> > The other functions may fail in the assumption that a stop command
> > always comes after a start command.
> 
> > As the API does not specify the behaviour of trigger functionpointers, I
> > think this should be fixed in the function calling the trigger
> > functionpointers.
> 
> > This patch changes the behaviour. The trigger function calls all
> > functionpointers independent of their returncodes. The first error-code
> > is returned.
> 
> I'm not sure if this will resolve the problem robustly - if something is
> going to get confused about this it seems just as likely that the
> trigger that failed will get upset because it gets a _STOP after
> returning an error from _START.  I think what I'd expect here is that
> the unwind on error would unwind only the triggers that it successfully
> ran.  Equally well I'd be a bit surprised if a trigger function actually
> had a problem with extra _STOPs since they mostly just do register
> writes...  did you see this from code inspection or were you resolving a
> practical problem in your system?

Yes this is a practical problem on mx28. mxs-saif enables/disables
clocks when starting/stopping. I debugged a problem where the DMA engine
returned an error on channel preparation and clk_disabled in mxs-saif
was called twice.

To make proper error handling and only STOP functions that successfully
started, we have to store the state of each function. The command error
handling is done in pcm_native.c so we don't have any influence on that.

Another possibility is to explicitly allow multiple _STOPs. Then I could
fix the driver to store the clock state. But I would prefer a generic
solution.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
