From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 28 Mar 2013 10:33:50 +0100 (CET)
Subject: [PATCH 2/2] clk: allow reentrant calls into the clk framework
In-Reply-To: <1364445958-2999-3-git-send-email-mturquette@linaro.org>
References: <1364368183-24420-1-git-send-email-mturquette@linaro.org>
 <1364445958-2999-1-git-send-email-mturquette@linaro.org>
 <1364445958-2999-3-git-send-email-mturquette@linaro.org>
Message-ID: <alpine.LFD.2.02.1303281031260.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Mar 2013, Mike Turquette wrote:

> Reentrancy into the clock framework is necessary for clock operations
> that result in nested calls to the clk api.  A common example is a clock
> that is prepared via an i2c transaction, such as a clock inside of a
> discrete audio chip or a power management IC.  The i2c subsystem itself
> will use the clk api resulting in a deadlock:
> 
> clk_prepare(audio_clk)
> 	i2c_transfer(..)
> 		clk_prepare(i2c_controller_clk)
> 
> The ability to reenter the clock framework prevents this deadlock.
> 
> Other use cases exist such as allowing .set_rate callbacks to call
> clk_set_parent to achieve the best rate, or to save power in certain
> configurations.  Yet another example is performing pinctrl operations
> from a clk_ops callback.  Calls into the pinctrl subsystem may call
> clk_{un}prepare on an unrelated clock.  Allowing for nested calls to
> reenter the clock framework enables both of these use cases.
> 
> Reentrancy is implemented by two global pointers that track the owner
> currently holding a global lock.  One pointer tracks the owner during
> sleepable, mutex-protected operations and the other one tracks the owner
> during non-interruptible, spinlock-protected operations.
> 
> When the clk framework is entered we try to hold the global lock.  If it
> is held we compare the current task id against the current owner; a

s/task id/task/ We store a the task pointer in the owner variable.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
