From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 24 Mar 2017 14:53:17 +0100
Subject: [PATCH 0/3] minitty: a minimal TTY layer alternative for
 embedded systems
In-Reply-To: <alpine.LFD.2.20.1703240819370.2304@knanqh.ubzr>
References: <20170323210304.2181-1-nicolas.pitre@linaro.org>
 <20170324065015.GA17226@kroah.com>
 <alpine.LFD.2.20.1703240819370.2304@knanqh.ubzr>
Message-ID: <20170324135317.GA26769@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 08:31:45AM -0400, Nicolas Pitre wrote:
> On Fri, 24 Mar 2017, Greg Kroah-Hartman wrote:
> 
> > meta-comment, any reason you didn't cc: linux-serial at vger as well?
> 
> I didn't realize such a list even existed. I looked up "TTY LAYER" in 
> the maintainer file.

Ah, didn't notice the list wasn't included there, I'll go fix that...

> > Again, I like the idea, but worry that with this change, we would have
> > two different tty layers we have to maintain for the next 20+ years, and
> > we have a hard time keeping one stable and working today :)
> 
> That's the crux of the argument: touching the current TTY layer is NOT 
> going to help keeping it stable. Here, not only I did remove features, 
> but the ones I kept were reimplemented to be much smaller and 
> potentially less scalable and performant too.  The ultimate goal here is 
> to have the smallest code possible with very simple locking and not 
> necessarily the most scalable code. That in itself is contradictory with 
> the regular TTY code and warrants a separate implementation. And because 
> it is so small, it is much easier to understand and much easier to 
> maintain.

So, what you are really saying here is "the current tty layer is too
messy, too complex, too big, and not understandable, so I'm going to
route around it by rewriting the whole thing just for my single-use-case
because I don't want to touch it."

That's a horrid thing to do.

Factoring things out is great.  Routing around the existing working code
just because you want something "simpler" is not great.  Refactor and
fix things up so you do understand it, because by ignoring it, you are
going to end up making the same mistakes that have already been fixed
with the existing 20+ years of tty layer development.

So please, take what we have, refactor, and carve things up so that the
_same_ code paths are being used for both "big and little" tty layers.
That way _everyone_ benifits, no need to have totally separate code
paths, and totally different files that different people maintain.

> Where code sharing made sense, I did factor out common parts already, 
> such as the baudrate handling. I intend to do the same to add job 
> control support.

The first two patches were great, I like those.  Keep that work up, just
make it so that a single line disipline attached to a serial port,
without the pty stuff, works just fine and is tiny.  I don't see why
that can't be possible.

thanks,

greg k-h
