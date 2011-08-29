From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 29 Aug 2011 23:21:52 +0800
Subject: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
In-Reply-To: <Pine.LNX.4.44L0.1108291046540.2525-100000@iolanthe.rowland.org>
References: <CACVXFVOvw6bSfcOYR2RWJO=k1WLgSCUygmSwZmtRDdM_tZNWEA@mail.gmail.com>
	<Pine.LNX.4.44L0.1108291046540.2525-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVNFXh33tsvkM=jdnc8OocVhjkzpt6LK59zKa9L2F7HxpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 29, 2011 at 11:03 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 29 Aug 2011, Ming Lei wrote:
>
>> IMO, the dummy has been linked into queue pointed by qh->hw->hw_qtd_next,
>> so EHCI will fetch dummy qtd and execute the transaction and will not have
>> any delay on the transaction.
>>
>> Let me explain the problem again: On ARM, the wmb() before
>> 'dummy->hw_token = token;'
>> will flush l2 write buffer into memory and all parts of 'dummy' except
>> for hw_token field
>> have reached into memory already, but dummy->hw_token will stay at l2
>> write buffer
>> and not reach into memory at this time, so ehci may fetch a
>> inconsistent qtd and execute it,
>> then mistaken IOC or "total bytes to transfer" ?are read by EHCI and
>> cause delayed irq
>> or lost irq.
>
> No. ?Even if the HC reads dummy before dummy->hw_token has been written
> out to memory from the L2 cache, it will not see any inconsistencies.
> It will see the old value in hw_token, which has the ACTIVE bit clear.
> Therefore it will not try to execute the qTD but will move on to the
> next QH. ?See what the fourth paragraph in section 4.10.2 of the EHCI
> spec says about the case where a qTD's ACTIVE bit is set to 0.

Suppose HC can see the old value in hw_token, which has the ACTIVE bit clear.

The qtd transaction will not be executed until the new token is
flushed into memory.
