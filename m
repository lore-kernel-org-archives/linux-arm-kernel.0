From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 23 Dec 2010 17:30:27 +0900
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <AANLkTinOMOkY6AUW8Z6FWMMWU9u0_sNjA2r_31u9-A8v@mail.gmail.com>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<20101221182037.GA4783@n2100.arm.linux.org.uk>
	<20101222122904.GC14693@n2100.arm.linux.org.uk>
	<AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
	<AANLkTinOMOkY6AUW8Z6FWMMWU9u0_sNjA2r_31u9-A8v@mail.gmail.com>
Message-ID: <AANLkTikEz=4asJqEP34vUmitqmocd9QJqaUZY+SdQtWN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 23, 2010 at 5:17 PM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/12/23 Dan Williams <dan.j.williams@intel.com>:
>> On Wed, Dec 22, 2010 at 4:29 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> As described above in my code analysis, pl08x_tasklet takes the spinlock,
>>> calls pl011_dma_tx_callback and eventually back to pl08x_prep_slave_sg
>>> and pl08x_prep_channel_resources which then try to take the spinlock
>>> again, leading to deadlock.
>>
>> This is listed in the dmaengine documentation [1], but I obviously
>> missed this before merging. ?This also would have been caught by
>> lockdep as required by SubmitChecklist.
>
> Yeah, my bad. I'll get better at this... :-(
> (I blame it partially on inaccessible hardware, sob sob. I do like to
> run lockdep.)
>
>>?It looks like this driver needs a full scrub
>> which seems unreasonable to complete and test over the holidays before
>> .37 lands. ?Linus we either need to mark this "depends on BROKEN" or
>> revert it.
>
> Isn't it really as simple as to release the spinlock during callbacks?
> That lock is only intended to protect the plchan variables, not to block
> anyone from queueing new stuff during the callback (as happens now).
>
> It can release that lock, make a callback where a new descriptor
> gets queued, and then take it again and start looking at the queue,
> at which point it discovers the new desc and process it.
>
> So something like this:
>
>
> From: Linus Walleij <linus.walleij@stericsson.com>
> Date: Thu, 23 Dec 2010 09:06:14 +0100
> Subject: [PATCH] dma: release pl08x channel lock during callback
>
> The spinlock is not really safeguarding any resources during the
> callback, so let's release it before that and take it back
> afterwards so as to avoid deadlocks.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> ?drivers/dma/amba-pl08x.c | ? ?7 +++++--
> ?1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index b605cc9..7879a22 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -1651,8 +1651,11 @@ static void pl08x_tasklet(unsigned long data)
> ? ? ? ? ? ? ? ?/*
> ? ? ? ? ? ? ? ? * Callback to signal completion
> ? ? ? ? ? ? ? ? */
> - ? ? ? ? ? ? ? if (callback)
> - ? ? ? ? ? ? ? ? ? ? ? callback(callback_param);
> + ? ? ? ? ? ? ? if (callback) {
> + ? ? ? ? ? ? ? ? ? ? ? ?spin_unlock(&plchan->lock);
> + ? ? ? ? ? ? ? ? ? ? ? ?callback(callback_param);
> + ? ? ? ? ? ? ? ? ? ? ? ?spin_lock(&plchan->lock);
> + ? ? ? ? ? ? ? ?}
How about adding completed requests to a list and go on to do important
channel management stuff, and do callbacks at the end after dropping the lock.
As in pl330_tasklet of drivers/dma/pl330.c
