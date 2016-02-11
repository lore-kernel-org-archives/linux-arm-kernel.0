From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 11 Feb 2016 07:13:22 -0800
Subject: [PATCH] tty/serial: digicolor: Fix bad usage of IS_ERR_VALUE
In-Reply-To: <20160211104650.GU10826@n2100.arm.linux.org.uk>
References: <1455030539-10798-1-git-send-email-linux@roeck-us.net>
 <4571887.rTPndCnv20@wuerfel> <56BAA27A.9050605@roeck-us.net>
 <20160211104650.GU10826@n2100.arm.linux.org.uk>
Message-ID: <20160211151322.GA30389@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 10:46:50AM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 09, 2016 at 06:37:46PM -0800, Guenter Roeck wrote:
> > On 02/09/2016 07:26 AM, Arnd Bergmann wrote:
> > >On Tuesday 09 February 2016 07:08:59 Guenter Roeck wrote:
> > >>IS_ERR_VALUE() assumes that its parameter is an unsigned long.
> > >>It can not be used to check if an unsigned int reflects an error.
> > >>Doing so can result in the following build warning.
> > >>
> > >>drivers/tty/serial/digicolor-usart.c: In function ?digicolor_uart_probe?:
> > >>include/linux/err.h:21:38: warning:
> > >>         comparison is always false due to limited range of data type
> > >>drivers/tty/serial/digicolor-usart.c:485:6: note:
> > >>         in expansion of macro ?IS_ERR_VALUE?
> > >>
> > >>If that warning is seen, an error return from platform_get_irq() is missed.
> > >>
> > >>
> > >
> > >The patch looks correct to me, but what compiler version and which kernel
> > >tree is it that triggered the warning?
> > >
> > >Andrzej Hajda just modified the definition of IS_ERR_VALUE(), and the
> > >changes are still under discussion, but I don't see that warning with
> > >any of the versions.
> > >
> > I see it with gcc 5.1 and 5.2 (and W=1). I did not see / notice Andrzej's patch.
> > 
> > I agree that fixing the problem in IS_ERR_VALUE() is preferrable.
> 
> I disagree.  What happens if (eg) you decide to do this:
> 
> 	u8 irq;
> 
> 	irq = platform_get_irq(...);
> 	if (IS_ERR_VALUE(irq))
> 		...
> 
> is that the fault of IS_ERR_VALUE() that it will never be true?  No, it's
> a programming error in the caller, because the caller is using the wrong
> type here - in fact, you can't do anything in IS_ERR_VALUE() to correct
> that.
> 
Yes, I think we all reached that conclusion by now.

Thanks,
Guenter
