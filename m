From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Sat, 6 Dec 2014 12:31:01 +0530
Subject: [PATCH] dmaengine: pl330: Set residue in tx_status callback
In-Reply-To: <20141205151843.GV11285@n2100.arm.linux.org.uk>
References: <1416995095-13763-1-git-send-email-padma.v@samsung.com>
 <CAAgF-BfpU72KTJjVd8jWStD8yJ5sSmXOiQm77xQunO2QhC9ExQ@mail.gmail.com>
 <547DF61D.3010909@metafoo.de>
 <CAAgF-BfPyaOhhrA5L8vm2WDnhBYDexJFkGxqL1GsL2TMB8z=Rw@mail.gmail.com>
 <CAJe_Zhd2-vBgAoJsBt7JCOYDuTZrBCScSZ1HaNO3gNTZ-P6A9A@mail.gmail.com>
 <20141205151843.GV11285@n2100.arm.linux.org.uk>
Message-ID: <CAJe_ZhfDsfehCXHB6pCuQ6672kXBYFxh687cZT1qaSCOyLy76g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 December 2014 at 20:48, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Dec 03, 2014 at 01:21:37PM +0530, Jassi Brar wrote:
>> because the reasoning above seems incorrect considering the following
>> documentation...
>>
>> Documentation/crypto/async-tx-api.txt says
>                        ^^^^^^^^^^^^
>
> async-tx-api is not the DMA slave API.
>
>>   " .... Once a driver-specific threshold is met the driver
>> automatically issues pending operations.  An application can force this
>> event by calling async_tx_issue_pending_all(). ...."
>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> DMA slave users do not call this function.  This documentation is not
> relevant for DMA slave.
>
The APIs (device_issue_pending, tx_submit etc) are same for Slave and Async.
async_tx_issue_pending_all() for Async and dma_async_issue_pending()
for Slave both boil down to device_issue_pending()

>> include/linux/dmaengine.h says
>>   dma_async_tx_descriptor.tx_submit(): set the prepared descriptor(s)
>> to be executed by the engine
>
> It doesn't say when.
>
:) OK

>> so theoretically a driver, not starting transfer until
>> issue_pending(), is "broken".
>
> It isn't.  DMA slave engine implementations have been needing the
> issue_pending() call since their dawn, so it's something that they've
> always needed.
>
>> At best the patch at 04abf5daf7d makes the driver slightly more
>> complicated and the reason behind confusion such as in this thread.
>
> That may be, and yes, it _might_ be worth discussing whether this should
> be relaxed or not, but that should be done as a proposal, not trying to
> hide it as a bug fix.  It isn't.
>
It does, though, create an "awkward situation" when a channel is
active while new requests are submitted - why would the channel want
to stop after current transfer and await fresh issue_pending()? It's
not that the request can be modified after submission.

And it isn't that tx_submit() is meant for 'sleepable' preparation for
the transfer and we need another call to be issued from atomic
context. From what I see most drivers don't need to sleep in
tx_submit(). In fact, from a quick look most clients seem to suffer
from the ritual i.e, there's nothing between tx_submit() and
issue_pending() calls. And when there is indeed some code, it seems
that can be moved just before tx_submit().

Last and apparently the least of all, we can never enforce the same
behavior of the api on Async dma and have uniform behavior over the
api.

So, if all tx_submit() does is put the request in controller driver's
internal queue and the client can't touch the request after
tx_submit(), why not merge the tx_submit() and issue_pending()?

Thanks.
