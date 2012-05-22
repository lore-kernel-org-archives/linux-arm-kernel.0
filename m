From: lee.booi.lim@gmail.com (Lee Booi Lim)
Date: Tue, 22 May 2012 17:51:01 +0800
Subject: Why DMA PL330 peripheral transfer does not support burst request?
In-Reply-To: <CABb+yY0NtS+vU98CtZvS_Raj_Yuuobqyn8NPCCE+awYqmxhiVQ@mail.gmail.com>
References: <CAGe5uTBouMxJqX9yqizFNYkrNhb4jF=5=Y0NGV=tMDH+MqY25w@mail.gmail.com>
 <CAGe5uTCZXRMDcwHZPGMirwD3gjeOYGuAgHbYD7K3gCgyOEOvYQ@mail.gmail.com>
 <CABb+yY13K4Y3-Da0v8Af+j-7MKWU3ho9Ho4_qFtwZ0XUgWnYQw@mail.gmail.com>
 <CAGe5uTByHp6BeN+sKNE8AySph_f9ZK6dEveGdt83+kw47p7Bag@mail.gmail.com>
 <CAGe5uTCDA8PxjNYwyqz3HsGdbMetWtSN9DFivWamvnrPXDEU2Q@mail.gmail.com>
 <CABb+yY0NtS+vU98CtZvS_Raj_Yuuobqyn8NPCCE+awYqmxhiVQ@mail.gmail.com>
Message-ID: <CAGe5uTB6DoAar5BvxRXRMnaiPNJf464ij8JmGnGEnGsb-3AjzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2012 at 3:02 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Fri, May 18, 2012 at 7:48 AM, Lee Booi Lim <lee.booi.lim@gmail.com> wrote:
>> Appreciate if you could share with me on what is the weird behaviour
>> seen. Is it because of DMA PL330 hardware bug? We have seen a problem
>> on DMA PL330 that happens in DMA burst mode. If a DMA channel is
>> programmed to wait for a burst from the peripheral (let's takes an
>> example of RX path), somehow transfer error happened in the middle due
>> to the peripheral is not able to trigger a burst as it does not have
>> enough data. In this case, the DMA channel will be killed if the
>> driver / application detects timeout on the transfer. However, the DMA
>> PL330 is not able to resume to normal even with DMAKILL and DMAFLUSHP,
>> that particular DMA channel will remain in waiting for burst mode. If
>> the DMA transfer is restarted with single transfer, the request will
>> be ignored. The waiting for burst state can only be reset if a cold
>> reset to the DMA PL330 controller happen or a burst is actually
>> happen.
>>
>> May I know whether the similar behaviour is observed in 6440? If not,
>> could you please share with me on the behaviour you have observed so
>> that I can try to reproduce it.
>>
> It's been almost 3yrs now, I don't remember exactly. IIRC it was evt0
> of 6440 and the problem was random skips in sine wave playback over
> I2S, while it worked just fine over an evt1. Please note the *IIRC*, I
> have suffered those audio issues for many reasons.
>
> Apparently you have changed the micro-code in the driver. So I can't
> say much about what you observe. I might be able to suggest something
> useful if I know what your SoC and code looks like and if the original
> driver didn't work for you.

I have not make changes to the driver to support burst yet. The PL330
hardware problem was found by my friend on the use case test (not
running Linux) for the PL330 but not using Linux driver. That's why I
thought that you have disabled the burst support due to this PL330
bug. ARM has acknowledged the scenario I described above as a PL330
controller hardware bug.  So seems that we saw a different problem.
The above scenario only happens if burst mode is supported in the
driver. Evt0 and evt1 refer to event in DMA channel?

>
>> As you have mentioned that the bottleneck is always at the
>> peripherals, may I know is this a fair assumption? Please correct me
>> if I get you wrong, you meant that the peripheral is always slower in
>> pulling out the data from DMAC or putting data into DMAC, right? You
>> are not saying that the peripheral cannot support burst mode, right?
>>
> I meant peripherals produce/consume data at a rate slower than the dma
> could provide even at single burst.
> Though thinking about it again, I shouldn't have generalized for every
> peripheral-dmac combination. Which is yours?

We are thinking to include the support burst mode since the
peripherals IP that we are using supports burst mode (e.g. Designware
SPI).
