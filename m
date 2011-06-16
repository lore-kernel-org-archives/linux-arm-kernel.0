From: khilman@ti.com (Kevin Hilman)
Date: Thu, 16 Jun 2011 11:25:15 -0700
Subject: [PATCH] omap3: pm: Downgrade WARN for no wakeup source
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D563E79@dbde02.ent.ti.com>
	(Sanjeev Premi's message of "Thu, 16 Jun 2011 21:43:07 +0530")
References: <1308229940-27025-1-git-send-email-premi@ti.com>
	<877h8lsswk.fsf@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D563E79@dbde02.ent.ti.com>
Message-ID: <87vcw5k510.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Premi, Sanjeev" <premi@ti.com> writes:

>> -----Original Message-----
>> From: Hilman, Kevin 
>> Sent: Thursday, June 16, 2011 8:52 PM
>> To: Premi, Sanjeev
>> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>> Subject: Re: [PATCH] omap3: pm: Downgrade WARN for no wakeup source
>> 
>> Hi Sanjeev,
>> 
>> Sanjeev Premi <premi@ti.com> writes:
>> 
>> > When multiple wakeup sources are defined in a system,
>> > there is a small window, when more than one source
>> > can trigger wakeup interrupt.
>> >
>> > In the current implementation, the do-while() loop
>> > can handle all wakeup sources that are recorded when
>> > probing the status register in prcm_interrupt_handler().
>> >
>> > When the ISR executes due to next queued wakeup, it
>> > there is nothing to be handled and value of "c" is 0.
>> 
>> Thanks for tracking this one down.
>> 
>> However, It's still not clear to me what is happening here.
>> 
>> Why is the IRQ firing if there is nothing to be handled?  
>> That suggests
>> to me that the IRQ status is not properly being cleared.
>
> [SP] On the contrary the IRQ status is actually getting cleared,
>      but there are more than "1" PRCM interrupts queued.
>
>      The do-while() clears all the interrupt sources that
>      are flagged in the status register.
>
>      When the next wakeup interrupt is getting processed, the
>      status register doesn't contain any "source" to handle.

Still confused.

If a wakeup interrupt is fired, it was caused by something.  

IOW, if "the status register doesn't contain any source",  how is

		if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
				     OMAP3430_IO_ST_MASK)) 

ever true?

Kevin
