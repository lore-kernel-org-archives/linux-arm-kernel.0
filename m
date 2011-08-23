From: tj@kernel.org (Tejun Heo)
Date: Wed, 24 Aug 2011 00:17:03 +0200
Subject: try_to_freeze() called with IRQs disabled on ARM
In-Reply-To: <20110823221314.GL3895@n2100.arm.linux.org.uk>
References: <20110823151936.GM9232@opensource.wolfsonmicro.com>
	<201108232351.55432.rjw@sisk.pl>
	<CAOS58YNUSn2eVLDLzqKmrtL7M5tSetkhZ1ODecLK54NSDnZVAA@mail.gmail.com>
	<20110823220056.GK3895@n2100.arm.linux.org.uk>
	<CAOS58YNuCbaOsWBfmjSUsXsArZ5ng6c0B30yswFbRAWkho6L6Q@mail.gmail.com>
	<20110823221314.GL3895@n2100.arm.linux.org.uk>
Message-ID: <CAOS58YNtQEuke=Ko9J2oNGMECjabzxj=Nrg1o64X1JC3YRmJuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 12:13 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Thereby entirely preventing threads from being frozen? ?You're asking
> me to effectively disable suspend/resume on an architecture where it's
> heavily used. ?That's not a good idea, and would be an out-right
> regression.

Eh? So, it's supposed to enter refrigerator with IRQ disabled? Then,
moving might_sleep() inside refrigerator() doesn't help either, does
it? Then we should be doing is,

if (freezing() && IRQ disabled) {
      bust on IRQ;
      try_to_freeze();
      replug IRQ;
}

But, that can't be right. The current code isn't triggering warning
from scheduler code, right? If the above is the case, it should be
triggering that. What am I missing?

-- 
tejun
