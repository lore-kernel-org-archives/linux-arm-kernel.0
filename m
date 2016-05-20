From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 20 May 2016 11:38:46 +0200
Subject: at91 slow clock with an external crystal (on Atmel SAM9G25)
In-Reply-To: <9cf2f9be-7f76-ca65-f2cf-ca0d20de6d2f@overkiz.com>
References: <9cf2f9be-7f76-ca65-f2cf-ca0d20de6d2f@overkiz.com>
Message-ID: <20160520113846.5df0be05@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Atmel and clk maintainers.

Hi Mickael,

Please use get_maintainer.pl (or the MAINTAINERS file) to find people
you should send your questions too

On Wed, 18 May 2016 10:04:35 +0200
Mickael GARDET <m.gardet@overkiz.com> wrote:

> Hi,
> 
> I have one question about usage of slow clock with an external crystal 
> (on Atmel SAM9G25).
> 
> All work fine If I set CONFIG_SCLK=y in at91bootstrap but we wouldn't 
> update at91bootstrap.

Yes, the 'external crystal'/'internal RC osc' selection is currently
done in at91bootstrap, and Linux just use what has been configured by
the bootstrap.

> 
> If I force usage of external crystal (like this [1]) it work 
> for me but what's the recommended way to do this ?

I'd rather see something more generic for mainline, but you can keep it
in your own tree ;).

IMHO, the proper solution would be to add a min_accuracy field in
struct clk_rate_request (and a clk_set_min_accuracy() helper), implement
->determine_rate() in clk-slow.c to find the parent matching this
constraint, and patch all users of the slow clk to set this constraint
to something appropriate (100ppm ?).

At least, slow clock users should check if the accuracy provided by the
slow clock match what they expect and complain if it's not the case
(it's already doable thanks to the clk_get_accuracy() function).

Best Regards,

Boris

> [1]http://code.bulix.org/kpzu92-98883


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
