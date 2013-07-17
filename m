From: juha.lumme@gmail.com (Juha Lumme)
Date: Wed, 17 Jul 2013 22:42:26 +0900
Subject: Can't get FIQ interrupt to work on i.mx233
In-Reply-To: <20130716161643.GB3428@localhost.localdomain>
References: <CAF-Ht3z3GQLwEWoB+UgOGepHfMFUD7pTRHfYWR9Ynk3rM4dD=Q@mail.gmail.com>
 <20130716081132.GB24642@n2100.arm.linux.org.uk> <51E5322B.8080602@gmail.com>
 <20130716161643.GB3428@localhost.localdomain>
Message-ID: <51E69F42.2060106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Thanks for the idea, that's indeed a dead simple way to find out.
Being sure that I will get stuck in FIQ handler, I started experimenting 
different things, and it seems that if instead of calling 
mxs_icoll_set_irq_fiq(31) (which only sets FIQ bit), I directly set bits 
4 (FIQ) and 2 (ENABLE) in HW_ICOLL_INTERRUPT31 register, my interrupt 
starts working as expected. Maybe I can also leave enable_fiq out this way.

So it currently seems like mxs_icoll_set_irq_fiq (which I patched in) 
and enable_fiq (already there) are not working as expected currently in 
freescale's mainline 3.10.
I will try to find out the reason, and create patches for this - but if 
you have any pointers on what might help me on a right path, I would 
appreciate it.

Anyway, thanks for helping me this far already,
Juha

On 07/17/2013 01:16 AM, Dave Martin wrote:
> On Tue, Jul 16, 2013 at 08:44:43PM +0900, Juha Lumme wrote:
>> Hi Russel,
>>
>> Thanks for your reply.
>> And thanks for pointing out the wrong instruction there with the ldr
>> instruction.
>>
>> However, unfortunately the code still doesn't seem to trigger
>> anything (neither to clear the IRQ bit in the timer, nor the GPIO
>> output).. It seems to me as if the handler never gets called. Is
>> there a good way to confirm that any activity is actually triggered
>> when timer3 reaches 0, and the IRQ bit is set to 1 ?
>>
> A brutal, but simple, way to confirm that your handler is being called
> is to try putting an infinite loop in there:
>
> 	b	.
>
> If your board then locks up, the handler is almost certainly getting
> called.
>
> Cheers
> ---Dave
