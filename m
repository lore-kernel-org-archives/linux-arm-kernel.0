From: shubhrajyoti.datta@gmail.com (Shubhrajyoti Datta)
Date: Tue, 4 Aug 2015 11:04:52 +0530
Subject: [PATCH v3] iio: adc: xilinx-xadc: Push interrupts into threaded
 context
In-Reply-To: <55B231DE.4080308@metafoo.de>
References: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com>
 <1437434050-32907-1-git-send-email-xander.huff@ni.com>
 <55B231DE.4080308@metafoo.de>
Message-ID: <CAKfKVtGegy2P_YWQAtKEzByN-+q+bq=uus4zNvO4sghXRjpGPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 6:08 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Hi,
>
> Sorry, but I don't think this patch has been sufficiently tested against a
> mainline kernel. The driver wont even probe the way it is right now.
>
> On 07/21/2015 01:14 AM, Xander Huff wrote:
>>
>> The driver currently registers a pair of irq handlers using
>> request_threaded_irq(), however the synchronization mechanism between the
>> hardirq and the threadedirq handler is a regular spinlock.
>
>
> If everything runs in threaded context we don't really need the spinlock
> anymore and can use the mutex throughout.

that should be better from the performance point of view.

>
>>
>> Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can sleep,
>> and is thus not able to be acquired from a hardirq handler. This patch
>> gets
>> rid of the hardirq handler and pushes all interrupt handling into the
>> threaded context.
>
>
> We actually might as well run everything in the hardirq handler (which will
> be threaded in PREEMPT_RT). The reason why we have the threaded handler is
> because xadc_handle_event() used to sleep, but it doesn't do this anymore.

The point is why have the hard irq. If we use hardirq then not mutex
can be used and spinlock will
be busy.

is there something i may be missing?
>
>
