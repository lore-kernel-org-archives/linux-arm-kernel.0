From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 9 Jun 2015 21:47:05 +0200
Subject: [PATCH 00/34] pinctrl: mvebu: numerous fixes, cleanups and
 improvements
In-Reply-To: <20150609212211.625964e2@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150609170153.GC16778@lunn.ch>
 <20150609212211.625964e2@free-electrons.com>
Message-ID: <20150609194705.GE16778@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 09:22:11PM +0200, Thomas Petazzoni wrote:
> But before doing that, it'd be great to have your point of on the
> patches that actually break the DT backward compatibility. If there are
> to be rejected anyway, I'd rather not spend more time on them.

Hi Thomas

I read a presentation recently, "Device Tree as a stable ABI: a fairy
tale?"  :-)

But we should at least try. So what is actually involved in keeping
backwards compatibility?

The two patches i pointed out have two different situations.

What does pinctrl do when you ask for a pin which is not a member of the
function? If it silently ignores it, not a problem. But i expect it
actually throws an error. I could be wrong here, but it looks like it
is the mvebu code which checks if a pin is a member of a function.  So
it might be possible to set the value of the val in the
mvebu_mpp_ctrl_setting to 0xff for the removed NAND pins, and when we
see such a value, print a warning about outdated DT, and "succeed"
rather than return an error.

For spi -> spi0 it seems messier. So i would leave it as spi with a
comment, and add spi1.

I do see value in having consistent names and matching the datasheet
were possible. So if we can find reasonable compromises, i think these
patches are useful.

	Andrew
