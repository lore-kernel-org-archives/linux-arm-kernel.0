From: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 29 May 2012 11:52:32 +0100
Subject: [PATCH] netwinder: nw_gpio_lock is a raw_spinlock_t
In-Reply-To: <20120529100619.GA23186@faui49q.informatik.uni-erlangen.de>
References: <1338040464.2525.38.camel@koala>
 <20120525082812.GA12238@faui49q.informatik.uni-erlangen.de>
 <20120529100619.GA23186@faui49q.informatik.uni-erlangen.de>
Message-ID: <1338288752.11518.166.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-05-29 at 12:06 +0200, Christian Dietrich wrote:
> --- a/drivers/char/ds1620.c
> +++ b/drivers/char/ds1620.c
> @@ -74,21 +74,21 @@ static inline void netwinder_ds1620_reset(void)
>  
>  static inline void netwinder_lock(unsigned long *flags)
>  {
> -       spin_lock_irqsave(&nw_gpio_lock, *flags);
> +       raw_spin_lock_irqsave(&nw_gpio_lock, *flags);
>  }
>  
>  static inline void netwinder_unlock(unsigned long *flags)
>  {
> -       spin_unlock_irqrestore(&nw_gpio_lock, *flags);
> +       raw_spin_unlock_irqrestore(&nw_gpio_lock, *flags);
>  } 

If you were to make these functions public by shifting them into
arch/arm/mach-footbridge/include/mach/hardware.h that would be a lot
nicer, and other places wouldn't have to touch the raw spinlock
directly.

Also... while we're thinking about preemption and netwinder, note that
the write enable is valid for only 2ms or so. So all the functions in
dc21285.c that you just touched should probably *also* be disabling
preemption when they're run on a netwinder, to ensure that that time
doesn't expire before they actually get to run.

-- 
dwmw2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6171 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120529/15a9a04f/attachment-0001.bin>
