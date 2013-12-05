From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Dec 2013 16:54:08 -0700
Subject: [PATCH] pinctrl: samsung: Allow pin value to be initialized using
 pinfunc.
In-Reply-To: <CACRpkdYrPd9tnO48bA_5n+-k=KEDyhY7czkCNhTZfpgF3ar+LQ@mail.gmail.com>
References: <1384881351-10782-1-git-send-email-t.figa@samsung.com>	<528BB1F2.4080107@wwwdotorg.org>	<CAD=FV=XS0dbE7zfgDGVdp84h4fHH6tfO8aN_HNh1LbOjYy51aQ@mail.gmail.com>	<528BB913.6080409@wwwdotorg.org>	<CAH9JG2UjnL5bZzNUuJhWY3GpwPD=rJvR2O4Hcpm33G+prSS=BA@mail.gmail.com>	<CACRpkdbyjm0X9RX+8WjqQxBPyRjBOAunkqVcO-0KUd1PTdGavA@mail.gmail.com>	<5293ACA6.7060403@bracey.fi>
 <CACRpkdYrPd9tnO48bA_5n+-k=KEDyhY7czkCNhTZfpgF3ar+LQ@mail.gmail.com>
Message-ID: <52A11220.8080509@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 02:29 AM, Linus Walleij wrote:
...
> So I guess what you're after is a kind of hog that will be pushed
> aside and ignored if a struct device with an associated state appears
> that will use the same pin?

That probably would be useful. Perhaps we should just make all hogs not
exclusively own the pins they configure?

> It is true that we currently require the tables to be strict and not
> overlap like this, so ideally you should remove the hogs when you
> have a device driver, but you're actually describing an interesting
> case here:
> 
> What if I have a driver for this IP block, and it was supposed to
> take care of a few pins, but I decide not to compile it into my
> kernel? Or if I have it as a module and only modprobe it later
> at runtime?

Indeed, that's the nasty hole in pushing even static per-device pinctrl
configuration into each device's node; the device may not appear.

Related, I prefer to put /all/ static pinctrl configuration into the
pinctrl device's "default" state (i.e. use a hog) rather than
configuring the static pinctrl setup per device, for another reason too:

If a particular IO controller's signals can be routed to n different
(sets of) pins, then we need to do *both* of the following when setting
up the pinmux:

a) Configure the pins we want to host those signals to route to/from
that particular IO controller.

b) Configure any other pins that could route to/from that particular IO
controller as some other function; either disabled, or routed to/from
some different IO controller.

That is so that the IO controller's RX/input signals are not connected
from two different sets of pins at once, which would cause two things to
driver them. Depending on HW, this could cause on of:

1) Multiple drivers -> high power usage, or even Silicon damage.

2) Inconsistent configuration, with the "wrong" set of pins driving the
IO controller's inputs, and hence the signals on the "correct" pins
being ignored -> hard to find bug.

Now, (a) could easily happen when the driver for the IO controller is
probed. However, (b) can't, because some other IO controller may need to
use those pins, and the two drivers (or pinctrl states for different
devices) can't both set up those pins.

The only way to solve this is to set up all pinmux state using a single
global table (e.g. the pin controller's default state, or hog) that is
applied early on.

If we rely on resolving these conflicts in per-device default/...
states, then that means the conflicts won't get resolved until a driver
gets probed, if it ever does, which is too late.

... and as such, I prefer only putting *dynamic* configuration into
per-device (non-hog) nodes. (e.g. an I2C bus mux driver which actively
changes the pinmux at run-time to move an I2C controller between
different sets of SoC pins).
