From: bgat@billgatliff.com (Bill Gatliff)
Date: Wed, 07 Oct 2009 07:45:39 -0500
Subject: i.MX31 kernel panic and irq
In-Reply-To: <87077C4F48609F4392621D9F99DDE20901202E10@tesla.star.galaxy.io>
References: <87077C4F48609F4392621D9F99DDE20901202E0E@tesla.star.galaxy.io>
	<4ACB659E.3000206@billgatliff.com>
	<87077C4F48609F4392621D9F99DDE20901202E10@tesla.star.galaxy.io>
Message-ID: <4ACC8D73.2080109@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolf, Rene, HRO-GP wrote:
> Hi Bill.
>
> Thanks for your fast reply!
>
>   
>> low-level throttling of incoming interrupts 
>>     
>
> Hmm, I did test it with the option 'IRQF_DISABLED'. That should disable
> IRQs while in the ISR, so all IRQs during the ISR should be ignored.
> If they are ignored this should not lead to stack overflows, right?
> Or is the stack jumble happening during the time the kernel needs to
> disable the IRQs?
>   

I'd have to look in detail at the code for the IRQ handler, but IIRC it 
re-enables IRQs at some point before even the first IRQF_DISABLED 
handler would get called.  So your explanation could be accurate.

> I did test the setup with 10kHz and it went haywire, too:
> 1st test: crash after  700k irqs
> 2nd test: crash after 4200k irqs
> 3rd test: crash after  200k irqs
>
> So it seams quite random to me. Also tried with no irq events: system
> was running for 20 min. without crash.
>   

Well, "random" when you have limited information.  :)  If it is a stack 
overflow, it would be quite predictable--- at the moment the stack 
overflows!  But you don't know how to reliably set up a condition where 
the stack will overflow, because it will be dependent on whatever else 
the system is busy doing.

I wonder how it fares at 1kHz?

> About the application: the IRQs will come with a freq. of around 200kHz.
> in bursts of several dozens. So I'm not quite sure if that is going
> to work, will have to try :-)
>   

Boy, I sure hope you don't also need a predictable interrupt latency.  
It sounds like the system will definitely fall behind during those bursts.

If your function generator has an amplitude modulation capability, you 
could use that along with a very low-duty-cycle pulse to create 
controlled bursts of any duration and count.  You might need two 
function generators to do it, or perhaps just a couple of 555 timers and 
a soldering iron.

In your previous posts you said that the system could process a few 
200kHz interrupts before it died.  If that number is always greater than 
"several dozens", then you might be still be ok.  Otherwise, you might 
need to bring some additional hardware into the design or switch to a 
different CPU (PPC machines tend to have pretty decent performance at 
such high loads).

Another alternative would be to disable the interrupt source at the 
moment the first interrupt is detected, and then use a polled mode until 
the burst is over.  In fact, if you were to implement that as part of 
your testing and find that your system no longer dies, that's another 
indication that stack overflow might be the root cause.


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
