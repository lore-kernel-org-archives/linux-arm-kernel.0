From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2016 13:32:49 +0200
Subject: [PATCH v5] spi: orion.c: Add direct access mode
In-Reply-To: <20160418110415.GT3217@sirena.org.uk>
References: <1460974417-32375-1-git-send-email-sr@denx.de>
 <4437692.8jaX7AeWuo@wuerfel> <20160418110415.GT3217@sirena.org.uk>
Message-ID: <4248364.c0REkIZjj0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2016 12:04:15 Mark Brown wrote:
> On Mon, Apr 18, 2016 at 12:51:55PM +0200, Arnd Bergmann wrote:
> 
> > This would be easier if have a conclusive proof that 1MB per CS always enough.
> > Is this something that is guaranteed in the SPI spec or the documentation for
> > this controller?
> 
> There's no spec for SPI but if there were it'd be hard to see it
> imposing a limit, one can transfer data as long as the bus is clocked
> (which some things like ADCs and DACs make use of).
> 

I just reread Stefan's patch and realized that I had fundamentally
misunderstood how the transfer is done: I thought the offset inside of
the window was used to address a NOR flash directly, but it seems
it is just used to send arbitrarily long commands.

This means that the 1MB window is probably a reasonable size (provided
that the (most importantly) the SPI-NOR driver can guarantee that it
never exceeds this).

It also means that we are probably better off using the single-window mode
of the SPI controller, where all CS lines share a single mbus window.
The only real difference here is that we can map all endpoints using a
single contiguous window into the CPU address space if we want, or we
can still map them separately on a given board if that results in a nicer
layout.

	Arnd
