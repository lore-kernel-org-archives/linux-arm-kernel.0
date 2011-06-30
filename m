From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Jun 2011 14:30:03 +0100
Subject: [PATCH v8 00/12] use nonblock mmc requests to minimize latency
In-Reply-To: <201106301512.46788.arnd@arndb.de>
References: <1309248717-14606-1-git-send-email-per.forlin@linaro.org>
	<201106301512.46788.arnd@arndb.de>
Message-ID: <20110630133003.GZ21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 03:12:46PM +0200, Arnd Bergmann wrote:
> I think this looks good enough to merge into the linux-mmc tree, the code is
> clean and the benefits are clear.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> One logical follow-up as both a cleanup and performance optimization would be
> to get rid of the mmc_queue_thread completely. When mmc_blk_issue_rq() is
> non-blocking always, you can call it directly from the mmc_request()
> function, instead of waking up another thread to do it for you.

It isn't anywhere near that - because you need to wait for the
request to complete, then analyze the results and if there has been
an error, send more commands and wait for their response.

To do all that in an asynchronous fashion will just create a mess of
small little functions with hard to understand code.  It's far better
to do all that in a clear procedural way in a thread.

We've been here before - with PCMCIA's card insertion code, where you
have to go through a sequence of events (insert, power up, reset, etc).
The PCMCIA code used to have a collection of small functions to do
each step, one chained after the other in a state machine fashion.
The result was horrid.  That's exactly what you'll end up with here.

Threads have their place, and this is one of them.
