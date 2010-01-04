From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Mon, 4 Jan 2010 09:11:56 +0100
Subject: 21285 serial driver deadlock(?) fix
In-Reply-To: <1262039226.28196.125.camel@localhost>
References: <1262039226.28196.125.camel@localhost>
Message-ID: <20100104091156.0f384dec@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Dec 2009 17:27:06 -0500
Steve Moskovchenko <stevenm86@gmail.com> wrote:

> I've got a board with a StrongARM SA-110 and a 21285 "footbrtidge" on
> it. The kernel's 21285 serial driver works for kernel messages but not
> for I/O from userspace.
> 
> My kernel experience is pretty limited, but I believe the problem lies
> in drivers/serial/21285.c.
> 
> As I understand it:
> serial21285_tx_chars looks like an ISR, which likes to call
> serial21285_stop_tx every once in a while. 
> serial21285_stop_tx, in turn, calls disable_irq(), which waits for the
> current instance of the ISR to finish before disabling that interrupt.
> But, calling this from within an ISR results in deadlock and makes the
> puppy very sad. 
> 
> I've modified the ISR to call a different version of stop_tx, which uses
> disable_irq_nosync() instead. This gave me a working console.

I sent a similar patch some weeks ago:

  http://www.spinics.net/lists/arm-kernel/msg77006.html

which fixes the same problem for me. It would be good to get at least
one of these in I think. My patch also uses _nosync for stop_rx.

// Simon
