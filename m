From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 8 Dec 2014 18:37:27 +0530
Subject: [PATCH] dmaengine: pl330: Set residue in tx_status callback
In-Reply-To: <CAJe_ZhfDsfehCXHB6pCuQ6672kXBYFxh687cZT1qaSCOyLy76g@mail.gmail.com>
References: <1416995095-13763-1-git-send-email-padma.v@samsung.com>
 <CAAgF-BfpU72KTJjVd8jWStD8yJ5sSmXOiQm77xQunO2QhC9ExQ@mail.gmail.com>
 <547DF61D.3010909@metafoo.de>
 <CAAgF-BfPyaOhhrA5L8vm2WDnhBYDexJFkGxqL1GsL2TMB8z=Rw@mail.gmail.com>
 <CAJe_Zhd2-vBgAoJsBt7JCOYDuTZrBCScSZ1HaNO3gNTZ-P6A9A@mail.gmail.com>
 <20141205151843.GV11285@n2100.arm.linux.org.uk>
 <CAJe_ZhfDsfehCXHB6pCuQ6672kXBYFxh687cZT1qaSCOyLy76g@mail.gmail.com>
Message-ID: <20141208130727.GK16827@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 06, 2014 at 12:31:01PM +0530, Jassi Brar wrote:
> It does, though, create an "awkward situation" when a channel is
> active while new requests are submitted - why would the channel want
> to stop after current transfer and await fresh issue_pending()? It's
> not that the request can be modified after submission.
> 
> And it isn't that tx_submit() is meant for 'sleepable' preparation for
> the transfer and we need another call to be issued from atomic
> context. From what I see most drivers don't need to sleep in
> tx_submit(). In fact, from a quick look most clients seem to suffer
> from the ritual i.e, there's nothing between tx_submit() and
> issue_pending() calls. And when there is indeed some code, it seems
> that can be moved just before tx_submit().
> 
> Last and apparently the least of all, we can never enforce the same
> behavior of the api on Async dma and have uniform behavior over the
> api.
> 
> So, if all tx_submit() does is put the request in controller driver's
> internal queue and the client can't touch the request after
> tx_submit(), why not merge the tx_submit() and issue_pending()?
You are thinking from an API point and not what can be done with this API.
Today this API allows you to collate all pending txn and start while
dmaengine driver can collate and submit as a batch to hardware and not waste
time in getting irq and then setting next one. Sadly none of the drivers use
this feature...

I actually like the split model, you can also prepare txn ahead of time and
submit them when needed. If you don't like this, then please do as most
implementation do today, call prepare and submit in series. Flexiblity in
API is a better option IMO

Thanks
-- 
~Vinod
