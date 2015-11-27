From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Nov 2015 18:04:16 +0000
Subject: interruptible_sleep_on_timeout replacement
In-Reply-To: <565894EB.7040200@free.fr>
References: <565894EB.7040200@free.fr>
Message-ID: <20151127180416.GO8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 06:37:47PM +0100, Mason wrote:
> Hello Arnd,
> 
> I have to port /ancient/ code to v4.1
> The problematic line is:
> 
>   long timeout_jiffies = US_TO_JIFFIES(wait_param->timeout_microsecond);
>   ...
>   timeout_jiffies = interruptible_sleep_on_timeout(&(llad_context.irq_queue), timeout_jiffies);
>   wait_param->timeout_microsecond = JIFFIES_TO_US(timeout_jiffies);

Right, so it's most probably buggy (anything using *_sleep_on* is
buggy almost by definition.)

> IIUC, the appropriate replacement is
> 
>   wait_event_interruptible_timeout(wq, condition, timeout)
> 
> where wq and timeout are the original parameters?

wait_event_interruptible_timeout is documented very well in
include/linux/wait.h.

> To determine the condition... do I have to examine the corresponding
> wake_up_interruptible() calls? I do see several
> 
> 	if (status & SOME_VAL) {
> 		if (!test_and_set_bit(LOG2_SOME_VAL, &(llad_context.irq_bits)))
> 			wake_up_interruptible(&(llad_context.irq_queue));
> 	}

Quoting random bits of out of context code really doesn't help anyone,
especially with something this complex.  We really need to see the
whole driver to comment properly.

Condition is, as the documentation says, is the condition to be waited
for, which should evaluate to true to terminate the wait prior to the
timeout.

> Also I'm not sure the return value is a direct match?

It doesn't.  You're expected to know how much longer you need to wait.
So, you need something like:

I think you will want something like this:

	long timeout_jiffies = US_TO_JIFFIES(wait_param->timeout_microsecond);
	long target_jiffies = jiffies + timeout_jiffies;
	long ret;
	...

	ret = wait_event_interruptible_timeout(&llad_context.irq_queue,
					       ... some condition ...
					       timeout_jiffies);

	if (ret < 0) {
		long now = jiffies;

		if (time_before_eq(now, target_jiffies))
			wait_param->timeout_microsecond =
				JIFFIES_TO_US(target_jiffies - now);
		else
			wait_param->timeout_microsecond = 0;

		return ret;
	}

	if (ret == 0) {
		timed out
	} else {
		condition was satisfied
	}

Even better, change the API so that 'timeout_microsecond' is an
absolute time so you don't have accumulated errors if you're repeatedly
interrupted.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
