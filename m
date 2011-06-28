From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Jun 2011 19:03:05 +0200
Subject: [PATCH 1/2] PWM: add pwm framework support
In-Reply-To: <20110628161842.GK6069@pengutronix.de>
References: <1309255368-9775-1-git-send-email-s.hauer@pengutronix.de>
	<201106281427.04373.arnd@arndb.de>
	<20110628161842.GK6069@pengutronix.de>
Message-ID: <201106281903.06121.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 June 2011, Sascha Hauer wrote:
> > How about using idr? It provides you a fast lookup and handles giving
> > out unique numbers.
> 
> Sounds like a good idea, but is idr compatible with the pwmchip_reserve
> function below? idr gives no guarantee that the first id is zero, but I
> need exactly this to make the ids for the internal PWMs known at compile
> time.

You can certainly use ida_get_new_above to guarantee that implicit
number allocation doesn't interfere with the reserved numbers. Whether
that guarantees that you get the reserved numbers when you ask for them,
I don't know.

A possible way to deal with that would be to allocate an array of pointers
for the reserved space but use IDR for the rest, but at that point the
complexity is probably higher than what you have now ;-)

Another question is whether the dynamic allocation even makes sense. How
does a driver that wants to use a PWM find out what number to ask for
when it's not reserved for the platform to start with. Maybe the
answer is to just use an array or tree for the lookup and refuse to
register multiple PWMs to the same number.

	Arnd
