From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Jan 2012 15:34:59 +0000
Subject: [PATCH v3 0/7] Add common cpuidle code for consolidation.
In-Reply-To: <87fwf3ehi3.fsf@ti.com>
References: <1327379854-12403-1-git-send-email-rob.lee@linaro.org>
 <871uqoj23b.fsf@ti.com>
 <CAMXH7KGeVtvW7ciHrDuK_a6b396RUXnU4eWb26nNMSk1jsDkyw@mail.gmail.com>
 <87fwf3ehi3.fsf@ti.com>
Message-ID: <20120129153459.GF15455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 10:58:44AM -0800, Kevin Hilman wrote:
> It might be the case now that with syscore_ops, the timekeeping
> suspend/resume is happening early enought that the system will not go
> idle before the syscore_ops are done, so you would never see this WARN.
> That being said,  any platforms that add syscore_ops could introduce
> callbacks that could potentially allow a CPU to hit idle, and you'd get
> this WARN from the timekeeping susbystem.

I would really hope that doesn't happen, because syscore_ops stuff will
be called with IRQs off - and you're not allowed to enable interrupts
in the syscore ops callbacks.

So if you did hit idle, you wouldn't be able to receive any interrupt
to wake you from idle state.
