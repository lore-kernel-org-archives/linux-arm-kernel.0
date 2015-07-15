From: xander.huff@ni.com (Xander Huff)
Date: Wed, 15 Jul 2015 10:57:44 -0500
Subject: [PATCH v2] iio: adc: xilinx-xadc: Push interrupts into threaded
 context
In-Reply-To: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com>
References: <5574633F.7090004@kernel.org>	<1436391502-2604-1-git-send-email-xander.huff@ni.com>
 <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com>
Message-ID: <55A682F8.3090001@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/9/2015 12:03 AM, Shubhrajyoti Datta wrote:
>     @@ -330,8 +310,18 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq,
>     void *devid)
>                      xadc_zynq_update_intmsk(xadc, 0, 0);
>                      ret = IRQ_WAKE_THREAD;
>              }
>     +
>     +       alarm = xadc->zynq_alarm;
>     +       xadc->zynq_alarm = 0;
>     +
>              spin_unlock(&xadc->lock);
>
>     +       xadc_handle_events(indio_dev, xadc_zynq_transform_alarm(alarm));
>     +
>     +       /* unmask the required interrupts in timer. */
>     +       schedule_delayed_work(&xadc->zynq_unmask_work,
>     +                       msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
>     +
>
> Now that we are in the threaded context do we need the  work queue stuff.
Seems reasonable to try to remove it. I'll do some testing and send out a v3 if 
it works, thanks.

-- 
Xander Huff
Staff Software Engineer
National Instruments
