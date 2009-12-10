From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 10 Dec 2009 18:58:38 +0100
Subject: [BUG] pxa27x_udc: possible recursive locking detected in
	pxa_ep_queue
In-Reply-To: <200912061223.00528.david-b@pacbell.net> (David Brownell's
	message of "Sun\, 6 Dec 2009 12\:23\:00 -0800")
References: <Pine.LNX.4.44L0.0912061458540.7903-100000@netrider.rowland.org>
	<200912061223.00528.david-b@pacbell.net>
Message-ID: <87pr6mww1d.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Brownell <david-b@pacbell.net> writes:

> Right; such fine grain locking tends to be more hassle than it's
> worth.  ISTR studies from a while back showing locks need to be
> quite heavily contended before splitting them is worth much.  Any
> per-controller lock for a UDC is unlikely to see much contention.
I would gladly look at a reference for the studies if you had it somewhere.

The pxa27x_udc driver is not in a position where parallelism will be a problem
(as there are no pxa multi-core device AFAIK). But if there was an evolution
with multiple cores, slow enough to be unable to saturate the USB bandwith
alone, but which could saturate it with both cores attacking the UDC, the
trouble of per-ep spinlock would be worth it ...

Well, maybe a future 48-cores pxa4xx, who knows ? :)

As a side note, from a very quick glance at pxa25x_udc and omap_udc, I'm a bit
surprised they didn't suffer from the same behaviour.

Cheers.

--
Robert
