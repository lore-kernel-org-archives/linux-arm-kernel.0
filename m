From: peter@hurleysoftware.com (Peter Hurley)
Date: Tue, 21 Oct 2014 15:42:00 -0400
Subject: [PATCH] tty: serial: msm: Fix lock init issue with earlycon
In-Reply-To: <20141020222003.GD12469@codeaurora.org>
References: <1413551588-14877-1-git-send-email-galak@codeaurora.org>
 <544553F6.1020409@codeaurora.org> <544580ED.3050604@hurleysoftware.com>
 <20141020221656.GC12469@codeaurora.org>
 <20141020222003.GD12469@codeaurora.org>
Message-ID: <5446B708.6070404@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2014 06:20 PM, Stephen Boyd wrote:
> On 10/20, Stephen Boyd wrote:
>> On 10/20, Peter Hurley wrote:
>>>
>>> FWIW, __msm_console_write() is a deadlock-waiting-to_happen since it does
>>> not disable interrupts with spin_lock_irqsave().
>>>
>>
>> Yeah we should fix that. As far as I can tell we've never used
>> the irqsave variant of the lock in the console path. Did this
>> become necessary at some point since this driver was introduced?
>> I'm wondering how many stable trees need the fix.
> 
> Actually I don't see this case. It looks like the console is
> always called in call_console_drivers() with irqs saved and
> disabled via the logbuf_lock in console_cont_flush() or
> console_unlock().

Thanks for bringing that to my attention.

That looks like a vestige of the initial transition away from BKL.
I might look into just disabling preemption; even that might not
really be necessary.

Regards,
Peter Hurley
