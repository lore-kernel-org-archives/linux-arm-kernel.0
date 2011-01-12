From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 12 Jan 2011 13:19:49 -0800
Subject: Bug: loops_per_jiffy based udelay() mostly shorter than requested
In-Reply-To: <20110109170829.GA14252@flint.arm.linux.org.uk>
References: <20110109170829.GA14252@flint.arm.linux.org.uk>
Message-ID: <AANLkTik5BmZAOFdYVGAjuoHftQ3qh1oTCEr5MpkCiDVz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 9, 2011 at 9:08 AM, Russell King <rmk@arm.linux.org.uk> wrote:
>
> Any suggestions or thoughts, or should we not care too much if udelay()
> produces slightly shorter than desired delays? ?Or am I doing something
> horribly wrong in the ARM code?

Judging by the numbers you quote, I would definitely put this in the
"don't care too much".

If it's about 1% off, it's all fine. If somebody picked a delay value
that is so sensitive to small errors in the delay that they notice
that - or even notice something like 5% - then they have picked too
short of a delay.

udelay() was never really meant to be some kind of precision
instrument. Especially with CPU's running at different frequencies,
we've historically had some rather wild fluctuation. The traditional
busy loop ends up being affected not just by interrupts, but also by
things like cache alignment (we used to inline it), and then later the
TSC-based one obviously depended on TSC's being stable (which they
weren't for a while).

So historically, we've seen udelay() being _really_ off (ie 50% off
etc), I wouldn't worry about things in the 1% range.

                       Linus
