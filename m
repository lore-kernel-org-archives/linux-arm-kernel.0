From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Jun 2013 22:55:12 +0200
Subject: [PATCH 08/15] pwm: Add new pwm-samsung driver
In-Reply-To: <8756440.8o3uDlCqg5@flatron>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <20130624195020.GA7163@mithrandir> <8756440.8o3uDlCqg5@flatron>
Message-ID: <201306242255.12540.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 June 2013, Tomasz Figa wrote:
> Wouldn't adding a big comment about why this is enough for this platform 
> and why anything more sophisticated would be just overengineering in this 
> case be enough?
> 
> As you could see in several versions of the series I linked in my previous 
> replies, anything that looked decently simply added a lot of glue code and 
> cross module dependencies without serving any useful purpose, other than 
> just looking good.
> 
> This driver is already a lot better than previous one, because as opposed 
> to the old one, it gives synchronization that is technically correct. Not 
> even saying about a lot of other things fixed, like multiplatform-
> awareness, OF support, coding style, proper handling of dividers, etc., 
> etc. It would be really bad if all this was put to waste...

I agree. The shared spinlock as the interface between the two drivers
is clearly a hack, but I think it is an appropriate hack in this special
case and that's why I suggested using that over the more complex solutions
that Tomasz suggested.

The important part is that the DT binding reasonable and could support
more complex scenarios even though they are highly unlikely.
We can always change the kernel code to something else if we need to,
but I could not come up with good *and* simple design. The most obvious
solution would be to make the clocksource driver the master that exports
an interface to the pwm driver, but that just adds complexity for the
common case that just uses the pwm driver but not the clocksource driver.

The attempt to create a separate MFD glue driver that abstracts the
interface in the way that pwm-tiecap does also was a failure here, because
one of the two consumers has to run very early, before we have access to
most of the device infrastructure the kernel provides.

	Arnd
