From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Fri, 18 Jul 2014 14:36:30 +0530
Subject: [PATCH 7/8] mailbox: f_mhu: add driver for Fujitsu MHU controller
In-Reply-To: <53C81B3E.2020503@arm.com>
References: <1405233128-4799-1-git-send-email-mollie.wu@linaro.org>
 <53C6B83D.80602@arm.com>
 <CAJe_Zhe_kqmeeu9vF3CZwu3WR=P-nj13Bx+VOBCE7NfGzGPx=g@mail.gmail.com>
 <53C7A5F1.30209@arm.com>
 <CAJe_ZhegVczzcRVikt=nWnwU3nGx2G2mNg9nGR3bF4FfHnPeEg@mail.gmail.com>
 <53C7E71C.8020501@arm.com>
 <CAJe_ZhcROjhXebJetyJus43jNKoBU60jXXRLwnHwMdPJ7LPq7Q@mail.gmail.com>
 <53C81B3E.2020503@arm.com>
Message-ID: <CAJe_Zhfqg6rdrxU8TfN7Xz3wBKcNs1hqz8OsFiUGf=uO=R00mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 July 2014 00:21, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 17/07/14 18:07, Jassi Brar wrote:

>
>>> I believe that's what we need here if we want this driver to work
>>> on both Juno and your platform. Agree ?
>>>
>> Does this driver not work for Juno?
>
>
> I have not yet tried yet. For sure secure access will explode.
>
OK, I will remove setting up SCFG.

>>>
>>> No what I meant is unless there is a real need to use hard irq, we
>>> should prefer threaded one otherwise.
>>>
>> And how does controller discern a "real need" from a "soft need" to
>> use hard irq?
>> Even if the controller driver pushes data up from a threaded function,
>> the client can't know the context and can't sleep because the
>> intermediate API says the rx_callback should be assumed to be atomic.
>
> Yes I am not arguing on that, it should assume atomic and not sleep.
> I am saying we can avoid rx_callback in interrupt context if possible.
> I will try to look at the protocol implementation tomorrow.
>
There is only one way for controller to push data to client... which
is rx_callback() and it specified to be atomic.

>
>> Again, it maybe more efficient if I see your implementation of the
>> driver and understand your concerns about mine.
>>
>
> As I said its almost same as this, except I call mbox_chan_received_data
> in irq thread context. I prefer enabling other interrupts while copying
> payload data.
>
You call mbox_chan_received_data (which does rx_callback) from
threaded handler. If your client only does atomic stuff in
rx_callback(), then you pay for nothing. If your client does sleepable
stuff then, as you agree, that's wrong.

cheers
-jassi
