From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 17 Jul 2014 18:26:57 +0530
Subject: [PATCH 7/8] mailbox: f_mhu: add driver for Fujitsu MHU controller
In-Reply-To: <53C7A5F1.30209@arm.com>
References: <1405233128-4799-1-git-send-email-mollie.wu@linaro.org>
 <53C6B83D.80602@arm.com>
 <CAJe_Zhe_kqmeeu9vF3CZwu3WR=P-nj13Bx+VOBCE7NfGzGPx=g@mail.gmail.com>
 <53C7A5F1.30209@arm.com>
Message-ID: <CAJe_ZhegVczzcRVikt=nWnwU3nGx2G2mNg9nGR3bF4FfHnPeEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 July 2014 16:01, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 17/07/14 07:25, Jassi Brar wrote:
>>
>>>
>>>> +       u32 val;
>>>> +
>>>> +       pr_debug("%s:%d\n", __func__, __LINE__);
>>>
>>>
>>>
>>> Please remove all these debug prints.
>>>
>> These are as good as absent unless DEBUG is defined.
>>
>
> Yes, but with mailbox framework, the controller driver(esp. this one)is
> almost like a shim layer. Instead of each driver adding these debugs,
> IMO it would be good to have these in the framework.
>
OK

>>>
>>>> +       /* See NOTE_RX_DONE */
>>>> +       val = readl_relaxed(mlink->rx_reg + INTR_STAT_OFS);
>>>> +       mbox_chan_received_data(chan, (void *)val);
>>>> +
>>>> +       /*
>>>> +        * It is agreed with the remote firmware that the receiver
>>>> +        * will clear the STAT register indicating it is ready to
>>>> +        * receive next data - NOTE_RX_DONE
>>>> +        */
>>>
>>>
>>> This note could be added as how this mailbox works in general and
>>> it's not just Rx right ? Even Tx done is based on this logic.
>>> Basically the logic is valid on both directions.
>>>
>> Yes that is a protocol level agreement. Different f/w may behave
>> differently.
>>
>
> Ok, I am not sure if that's entirely true because the MHU spec says it
> drives
> the signal using a 32-bit register, with all 32 bits logically ORed
> together.
> Usually only Rx signals are wired to interrupts and Tx needs to be polled
> but that's entirely implementation choice I believe.
>
On my platform, _STAT register only carries the command code but
actual data is exchanged via SharedMemory/SHM. Now we need to know
when the sent data packet (in SHM) has been consumed by the remote -
for which our protocol mandates the remote clear the TX_STAT register.
And vice-versa for RX.

 Some other f/w may choose some other mechanism for TX-Done - say some
ACK bit set or even some time bound guarantee.

> More over if it's protocol level agreement it should not belong here :)
>
My f/w expects the RX_STAT cleared after reading data from SHM. Where
do you think is the right place to clear RX_STAT?

I have said many times in many threads... its the mailbox controller
_and_ the remote f/w that should be seen as one entity. It may not be
possible to write a controller driver that works with any remote
firmware.

>
>>>> +static int mhu_startup(struct mbox_chan *chan)
>>>> +{
>>>> +       struct mhu_link *mlink = (struct mhu_link *)chan->con_priv;
>>>> +       unsigned long flags;
>>>> +       u32 val;
>>>> +       int ret;
>>>> +
>>>> +       pr_debug("%s:%d\n", __func__, __LINE__);
>>>> +       spin_lock_irqsave(&mlink->lock, flags);
>>>> +       val = readl_relaxed(mlink->tx_reg + INTR_STAT_OFS);
>>>> +       writel_relaxed(val, mlink->tx_reg + INTR_CLR_OFS);
>>>> +       spin_unlock_irqrestore(&mlink->lock, flags);
>>>> +
>>>> +       ret = request_irq(mlink->irq, mhu_rx_interrupt,
>>>> +                         IRQF_SHARED, "mhu_link", chan);
>>>
>>>
>>>
>>> Just a thought: Can this be threaded_irq instead ?
>>> Can move request_irq to probe instead esp. if threaded_irq ?
>>> That provides some flexibility to client's rx_callback.
>>>
>> This is controller driver, and can not know which client want
>> rx_callback in hard-irq context and which in thread_fn context.
>> Otherwise, request_irq() does evaluate to request_threaded_irq(), if
>> thats what you mean.
>
> Agreed but on contrary since MHU involves external firmware(running
> on different processor) which might have it's own latency, I prefer
> threaded over hard irq. And yes request_irq does evaluate to
> request_threaded_irq but with thread_fn = NULL which is not what I want.
>
If remote has its own latency, that does not mean we add some more :)

>>   There might be use-cases like (diagnostic or other) data transfer
>> over mailbox where we don't wanna increase latency, so we have to
>> provide a rx_callback in hard-irq context.
>>
> OK
>
Cool.

>
>>>
>>>> +       for (i = 0; i < 3; i++) {
>>>> +               mhu->chan[i].con_priv = &mhu->mlink[i];
>>>> +               spin_lock_init(&mhu->mlink[i].lock);
>>>> +               res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
>>>> +               mhu->mlink[i].irq = res->start;
>>>> +               mhu->mlink[i].rx_reg = mhu->base + mhu_reg[i];
>>>> +               mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + 0x100;
>>>> +       }
>>>> +
>>>> +       mhu->mbox.dev = &pdev->dev;
>>>> +       mhu->mbox.chans = &mhu->chan[0];
>>>> +       mhu->mbox.num_chans = 3;
>>>
>>>
>>>
>>> Change this to 2, we shouldn't expose secular channel here as Linux can't
>>> access that anyway.
>>>
>> On the contrary, I think the device driver code should be able to
>> manage every resource - secure or non-secure. If we remove secure
>> channel option, what do we do on some other platform that needs it?
>> And Linux may not always run in non-secure mode.
>
>
> In general secure accesses are avoided these days in Linux as we have no
> way to identify it. I agree there are few place where we do access.
> Even though I don't like you have secure channel access in Linux, you
> have valid reasons. In case you decide to support it, there is some
> restrictions in bit 31, though RAZ/WI you need to notify that to protocol
> if it tries to access it ?
>
>
>>   So here we populate all channels and let the clients knows which
>> channel to use via platform specific details - DT. Please note the
>> driver doesn't touch any secure resource if client doesn't ask it to
>> (except SCFG for now, which I think should have some S vs NS DT
>> binding).
>>
>
> Not sure of this though. We need feedback from DT maintainers.
>
Yup.


Cheers,
Jassi
