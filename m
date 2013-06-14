From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 14 Jun 2013 23:15:49 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306141054530.26420-100000@netrider.rowland.org>
References: <CACVXFVPtZq4XWddBnP0ze2aecwXsuU+0OL8TP1Tb_5BrpJv9cw@mail.gmail.com>
 <Pine.LNX.4.44L0.1306141054530.26420-100000@netrider.rowland.org>
Message-ID: <CACVXFVO1Ou-wZedv0VntNwS1NZSRzvOjfVhvHBew0odz-PUYjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 10:56 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Fri, 14 Jun 2013, Ming Lei wrote:
>
>> On Fri, Jun 14, 2013 at 3:41 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> >
>> > The main reason for moving away from the current scheme is to reduce
>> > latency for other interrupt handlers.  Ming gave two examples of slow
>> > USB code that runs in hardirq context now; with his change they would
>> > run in softirq context and therefore wouldn't delay other interrupts so
>> > much.  (Interrupt latency is hard to measure, however.)
>>
>> With the two trace points of irq_handler_entry and irq_handler_exit, the
>> interrupt latency(or the time taken by hard irq handler) isn't hard to measure.
>> One simple script can figure out the average/maximum latency for one irq
>> handler, like I did in 4/4.
>
> But that doesn't measure the time between when the IRQ request is
> issued and when irq_handler_entry runs.

That might be hard to measure, also I am wondering if the time can be
measured only by software, but these patches only focus on the time
between HCD irq entry and irq exit.


Thanks,
--
Ming Lei
