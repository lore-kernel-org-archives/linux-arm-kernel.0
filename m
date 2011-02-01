From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 01 Feb 2011 12:57:57 -0800
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110201152820.GQ31216@n2100.arm.linux.org.uk>
References: <201102011711.31258.jeremy.kerr@canonical.com>	<20110201105449.GY1147@pengutronix.de>	<AANLkTimayMAfr+zA6uO_yUmZqsOLmJ3fiiS696mL_evn@mail.gmail.com>	<20110201140024.GZ1147@pengutronix.de>	<20110201151418.GN31216@n2100.arm.linux.org.uk>	<20110201152203.GE1147@pengutronix.de>
	<20110201152820.GQ31216@n2100.arm.linux.org.uk>
Message-ID: <4D4873D5.70203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2011 07:28 AM, Russell King - ARM Linux wrote:
> On Tue, Feb 01, 2011 at 04:22:03PM +0100, Uwe Kleine-K?nig wrote:
>> Full ack.  (I wonder if you misunderstood me or wanted to put my
>> statement into more words.  Jassi didn't like that a clk_enable without
>> a previous clk_prepare worked on some platforms and on others it
>> doesn't.  With BUG_ON(clk->ops->prepare&&  !clk->prepare_count) in
>> clk_enable we have exactly this situation.)
>
> Even with a NULL clk->ops->prepare function, we still want drivers to
> have called clk_prepare().  So we can do something like:
>
> 	if (WARN_ON(clk->prepare_count == 0))
> 		return -EINVAL;
>
> in clk_enable() should be sufficient and noisy enough not to be missed.

This code will only catch the error when it actually happens and will 
even miss catching some of them (if timed right -- unprepare happens in 
the other core after this check is executed).

I really wish there was something better we could do to help driver devs 
catch errors of calling enable without calling prepare(). Some thing 
like spin lock debug, or the might_sleeps() inside mutexes, etc.

Hmm... Jeremy, how about doing a similar check in the unprepare code? 
You could WARN/BUG ON the prepare count going to zero when the enable 
count is still non-zero?

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
