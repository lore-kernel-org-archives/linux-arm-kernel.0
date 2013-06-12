From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 12 Jun 2013 14:41:16 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <CACVXFVPRWxjXqyv-L6yU1OLXHFYCbe7cQxGnaFxqbEXwBK=hfQ@mail.gmail.com>
References: <CACVXFVMNzwD44mhKijURSWrqLKjy7_oOY8hrTtjbyOxGS2tv=g@mail.gmail.com>
 <Pine.LNX.4.44L0.1306111431170.1392-100000@iolanthe.rowland.org>
 <CACVXFVPRWxjXqyv-L6yU1OLXHFYCbe7cQxGnaFxqbEXwBK=hfQ@mail.gmail.com>
Message-ID: <CACVXFVO_eGeiyjzyoFJWEa8WMhQdvO+vD43b5g6Tf2eTjAp0gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 10:43 AM, Ming Lei <ming.lei@canonical.com> wrote:
> On Wed, Jun 12, 2013 at 3:10 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>>
>> I don't follow your reasoning.  Consider the following situation, where
>> the same spinlock is used in both a URB completion handler and an
>> interrupt handler:
>>
>>         URB completes
>>         A tasklet calls the completion handler, with interrupts enabled
>>         The completion handler does
>>                 spin_lock(&lock);
>>         An interrupt occurs
>>         The interrupt handler does
>>                 spin_lock(&lock);       // Deadlock!
>
> If you mean the interrupt handler is HCD irq handler of the device, no
> such problem since all complete() will run in tasklet context.
>
> If not, I am wondering why one USB driver need register another hard
> interrupt handler? Could you share such examples? I understand the
> case only exists with timer handler as discussed with Oliver, don't I?

In fact, timer funtion is still run in softirq context, so the deadlock won't
be caused with acquiring same lock(spin_lock) in both timer function
and complete() from tasklet.


Thanks,
--
Ming Lei
