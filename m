From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 31 Oct 2012 19:30:34 +0000
Subject: [PATCH RESEND 1/5 v6] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <CACxGe6vgryMPygc8SKFLKqP8Wq=pcGiJe_dPCiDC-evzf32UMA@mail.gmail.com>
References: <1351457210-25222-1-git-send-email-stigge@antcom.de>
 <1351457210-25222-2-git-send-email-stigge@antcom.de>
 <CACxGe6vgryMPygc8SKFLKqP8Wq=pcGiJe_dPCiDC-evzf32UMA@mail.gmail.com>
Message-ID: <20121031193033.GA4164@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 04:00:17PM +0100, Grant Likely wrote:

> For the API, I don't think it is a good idea at all to try and
> abstract away gpios on multiple controllers. I understand that it
> makes life a lot easier for userspace to abstract those details away,
> but the problem is that it hides very important information about how
> the system is actually constructed that is important to actually get
> things to work. For example, say you have a gpio-connected device with
> the constraint that GPIOA must change either before or at the same
> time as GPIOB, but never after. If those GPIOs are on separate
> controllers, then the order is completely undefined, and the user has
> no way to control that other than to fall back to manipulating GPIOs
> one at a time again (and losing all the performance benefits). Either
> controller affinity needs to be explicit in the API, or the API needs
> to be constraint oriented (ie. a stream of commands and individual
> commands can be coalesced if they meet the constraints**). Also, the
> API requires remapping the GPIO numbers which forces the code to be a
> lot more complex than it needs to be.

It feels like I'm missing something here but can we not simply say that
if the user cares about the ordering of the signal changes within an
update then they should be doing two separate updates?  Most of the
cases I'm aware of do things as an update with a strobe or clock that
latches the values.

The big advantage of grouping things together is that it means that we
centralise the fallback code.

> I would rather see new attribute(s) added to the gpiochip's directory
> to allow modifying all the pins on a given controller. It's
> considerably less complex, and I'm a lot happier about extending the
> sysfs ABI in that way than committing to the remapping block approach.

When I've looked at this stuff I've only looked at and thought about in
kernel users.  The gpiolib sysfs ABI is already fun enough :)
