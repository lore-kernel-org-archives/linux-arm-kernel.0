From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Sat, 05 Oct 2013 15:19:00 +1300
Subject: [PATCH] irq: bcm2835: Re-implement the hardware IRQ handler.
In-Reply-To: <524B8117.9070309@wwwdotorg.org>
References: <1379751251-2799-1-git-send-email-slapdau@yahoo.com.au>
 <5e0b6222e8648fb0c63aa649ee70b29d11f4924f@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <5243EE06.1020200@yahoo.com.au> <524B8117.9070309@wwwdotorg.org>
Message-ID: <524F7714.3070502@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2013 03:12 PM, Stephen Warren wrote:
> I do agree that it's likely best if the driver processes interrupts in
> the priority order that the HW designers came up with. So, I'm open to
> that change. This might make a difference to some time-critical
> shortcuts like the PCM (audio) interrupt.

FIQ would definitely make a difference.  I've tried playing audio out of 
the 3.5mm audio jack.  It sounds rubbish.  I think the issue might be 
the same as the one for getting decent PWM wave forms [1,2].  I found 
the links while researching how to implement FIQ support. 
Interestingly, a PWM driver is also a good candidate for FIQ.

Implementing FIQ was nothing like I expected, but none the less, I'm 
fairly certain that I've added FIQ support to the interrupt controller 
driver.  Other than normal interrupts seem to continue to behave well, I 
couldn't tell you how well FIQs behave.  That would require implementing 
an FIQ handler for some driver, which looks conceptually straight 
forward, but fiddly.

The implementation of an FIQ handler follow as per instruction from the 
introductory comment block in linux/arch/arm/kernel/fiq.c. The point 
about a relinquish function disabling FIQ before the next driver enables 
is important.  The interrupt controller driver only permits one FIQ 
enabled at any one time, and attempting to enable a second FIQ causes a 
kernel BUG().

I have not submitted it in the form of a patch, because I'm not sure of 
the current status of what you want changed or if you're even open to 
the possibility of changing the driver.  Still, if you're interested, 
you can always have a look at it here [3].

Cheers,
Craig.

[1] http://free-electrons.com/blog/fiq-handlers-in-the-arm-linux-kernel/
[2] http://elinux.org/images/2/27/0910-elce-fiq.pdf
[3] 
https://github.com/rickytarr/linux/blob/topic/interrupt/drivers/irqchip/irq-bcm2835.c
