From: slash.tmp@free.fr (Mason)
Date: Fri, 27 Nov 2015 18:37:47 +0100
Subject: interruptible_sleep_on_timeout replacement
Message-ID: <565894EB.7040200@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

I have to port /ancient/ code to v4.1
The problematic line is:

  long timeout_jiffies = US_TO_JIFFIES(wait_param->timeout_microsecond);
  ...
  timeout_jiffies = interruptible_sleep_on_timeout(&(llad_context.irq_queue), timeout_jiffies);
  wait_param->timeout_microsecond = JIFFIES_TO_US(timeout_jiffies);

IIUC, the appropriate replacement is

  wait_event_interruptible_timeout(wq, condition, timeout)

where wq and timeout are the original parameters?

To determine the condition... do I have to examine the corresponding
wake_up_interruptible() calls? I do see several

	if (status & SOME_VAL) {
		if (!test_and_set_bit(LOG2_SOME_VAL, &(llad_context.irq_bits)))
			wake_up_interruptible(&(llad_context.irq_queue));
	}

Also I'm not sure the return value is a direct match?

Regards.
