From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 18 Apr 2014 11:06:56 +0200
Subject: Rockchip RK3188 I2C driver
In-Reply-To: <15224827.56gI5cqpbK@typ>
References: <3748421.ND1tAjvgKS@typ> <20140417183835.GG12304@sirena.org.uk>
 <15224827.56gI5cqpbK@typ>
Message-ID: <1437066.E9nAxXbK6K@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 18. April 2014, 01:06:27 schrieb Max Schwarz:
> On Thursday 17 April 2014 at 19:38:35, Mark Brown wrote:
> > If you're only doing a few accesses then surely there's no meaningful
> > overhead from just writing what you want?  So long as you don't cache
> > these registers regmap won't really get in the way.
> 
> I think Heiko and I have been operating under the misconception that caching
> is somehow enabled by default - which is not the case. Thanks for clearing
> that up ;-)

Actually I think it's the other way around :-).

See regmap_read() calling _reagmap_read(), which in turn calls 
regcache_read(), except when map->cache_bypass is enabled, which then checks 
the volatile setting for the individual register.

So I guess we'd need to teach syscon to handle volatile registers (mark our 
grf ones as such) and then could leave the rest alone.


Heiko
