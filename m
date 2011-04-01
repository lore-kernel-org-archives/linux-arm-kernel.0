From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 1 Apr 2011 13:03:59 +0300
Subject: [PATCH] pxa2xx_spi: Fix race condition in stop_queue()
In-Reply-To: <AANLkTikyrfYn02yg3S9_4vBGfon+BNHbPiQkaHaq_Xaq@mail.gmail.com>
References: <1300055230-29628-1-git-send-email-anarsoul@gmail.com>
	<AANLkTikyrfYn02yg3S9_4vBGfon+BNHbPiQkaHaq_Xaq@mail.gmail.com>
Message-ID: <201104011303.59668.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 April 2011 10:26:37 Eric Miao wrote:
> On Mon, Mar 14, 2011 at 6:27 AM, Vasily Khoruzhick <anarsoul@gmail.com> 
wrote:
> > There's a race condition in stop_queue(),
> > if drv_data->queue is empty, but drv_data->busy is still set
> > (or opposite situation) stop_queue will return -EBUSY.
> > So fix loop condition to check that both drv_data->queue is empty
> > and drv_data->busy is not set.
> 
> I think this is a good catch if the queue could be stopped only when
> 1) queue is empty AND 2) transfer is not in progress.

It has check later (under while):

if (!list_empty(&drv_data->queue) || drv_data->busy)
	status = -EBUSY;

And I'm hitting it on Z2 when I'm trying to enter suspend - it fails, because 
spi driver refuses to enter suspend.

> There are several other places you might need to change accordingly,
> e.g. spi_bfin5xx.c

I can make a patch for other drivers, but I can't test it - I have no 
appropriate boards, and even toolchain.

Regards
Vasily
