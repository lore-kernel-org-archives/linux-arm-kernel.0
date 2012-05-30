From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 30 May 2012 12:10:58 +0800
Subject: [PATCH v4 4/6] gpio: introduce lock mechanism for gpiochip_find
In-Reply-To: <20120526002500.CA3123E14E9@localhost>
References: <1337952980-14621-1-git-send-email-b29396@freescale.com>
 <1337952980-14621-4-git-send-email-b29396@freescale.com>
 <20120526002500.CA3123E14E9@localhost>
Message-ID: <20120530041058.GB2235@b29396-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On Fri, May 25, 2012 at 06:25:00PM -0600, Grant Likely wrote:
> On Fri, 25 May 2012 21:36:18 +0800, Dong Aisheng <b29396@freescale.com> wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > The module lock will be automatically claimed for gpiochip_find function
> > in case the gpio module is removed during the using of gpiochip instance.
> > Users are responsible to call gpiochip_put to release the lock after
> > the using.
> > 
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> 
...
> Also, it doesn't do anything to protect against the gpio_chip being
> removed after the gpio number is resolved, which means the gpio number
> may no longer be valid, or may no longer point to the same gpio chip.
> It looks like the locking protection needs to be wider to be useful.
> 
I understand the issue now.
It's correct that we did not lock gpio_chip before calling gpio_request
after the gpio number is resolved.

I thought about adding a new API called of_gpio_request to hide the lock
to users like:
int of_gpio_request(..)
{
	spin_lock_irqsave(&gpio_lock, flags);
	ret = of_get_named_gpio(..);
	if (ret < 0)
		do_err..
	ret = gpio_request(..)

	spin_unlock_irqrestore(&gpio_lock, flags);
	return ret;
}
But it seems it does not work since the gpio_request may sleep and we may
need a new sleepable lock rather using the exist gpio_lock.

In the same time, i'm also thinking about a question that do we really
need to do this to protect gpio_chip being removed afer gpio number is
resolved?
My doubts is that gpio lib really does not block the gpiochip to be removed
before calling gpio_request, so why we need to do that for dt?
Maybe just let gpio_request to detect if gpio number is valid is already ok
for dt.

what's your suggestion on it?

Regards
Dong Aisheng
