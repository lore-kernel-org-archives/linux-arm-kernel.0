From: ming.lei@canonical.com (Ming Lei)
Date: Sun, 28 Aug 2011 11:13:53 +0800
Subject: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
In-Reply-To: <Pine.LNX.4.44L0.1108271548110.21403-100000@netrider.rowland.org>
References: <CACVXFVNz_ic_PPM_vNn1Dz85A2z94kRFso4rcqrvJfuLSqRSCg@mail.gmail.com>
	<Pine.LNX.4.44L0.1108271548110.21403-100000@netrider.rowland.org>
Message-ID: <CACVXFVP8Lr=ggH4FjvMQd6r9poLAT1r+_S3Z-NimP0i08DsQ8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for your comment.

On Sun, Aug 28, 2011 at 4:06 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sun, 28 Aug 2011, Ming Lei wrote:
>
>> I read the doc again, :-), and it mentions few about mb/wmb/rmb, I think
>> my above description is still not correct. Generally speaking, mb only
>> means there is a order between two accesses.
>>
>> Now I think only one mb() after 'dummy->hw_token = token;' is enough:
>> HC will read the up-to-date value of qtd->hw_token after mb() is executed
>> because of the effect of the mb(), which should be guaranteed by mb.
>
> I've been following this whole discussion. ?I didn't understand the
> idea behind the original patch, and I don't understand this. ?What
> reason is there for adding a memory barrier after the "dummy->hw_token
> = token" line? ?Such a barrier would not accomplish anything useful,
> because there are no later memory accesses which need to be ordered
> with respect to that line.

Here, mb is used to synchronize  between writing of CPU and reading of
ehci HC, see below:

	CPU								EHCI
	dummy->hw_token = token;
	mb
									read  dummy->hw_token

The mb() introduced  was supposed to be used to make sure that EHCI
can see the correct value of  dummy->hw_token. If EHCI can't get the correct
hw_token in time, it will work badly, such as irq delay or irq lost which may be
caused by mistaken 'IOC' or 'total bytes to transfer' in hw_token. This is just
what the patch is to fix.

But I think the above is still not correct, and the correct way may be
like below:

	CPU								EHCI
	dummy->hw_token = token;
	wmb
	qh->hw->hw_qtd_next = QTD_NEXT(ehci, dummy->qtd_dma);
									fetch next qtd from qh->hw->hw_qtd_next
									read  qtd->hw_token

The problem is that qh has already linked dummy into its queue before(as did in
qh_update), so even after 'dummy->hw_token = token;' is executed on CPU, EHCI
still may not fetch the up-to-date value of the qtd(dummy in here),
and this should
be the root cause, IMO.

I will figure out a elegant way to handle this race.

> (By the way, Santosh appears to be right about the earlier wmb() in
> this routine. ?As far as I can see, it isn't needed. ?David Brownell
> probably wrote it just as a precaution.)
>
>> > I mean others, please read the the last 3 lines of the comment and
>> > compare that to the code lines you added.
>>
>> I see now, the comment of the last 3 lines is wrong, should be
>>
>> ? ? ? ? ? ? ? ? ? ? ? ? * inside L2 cache. 'token = dummy->hw_token'
>> ? ? ? ? ? ? ? ? ? ? ? ? ?* after mb() is added for obeying correct mb()
>> ? ? ? ? ? ? ? ? ? ? ? ? ?* usage.
>>
>> But the 'token = dummy->hw_token' after mb() isn't needed any
>> more as described above, ?is it?
>
> I don't see why it was ever needed at all. ?The compiler will realize
> that token is a dead variable at that point in the routine and will
> optimize the new line away.

Yes, it is wrong, as I said before.

>
>> The patch can make ehci HC see the up-to-date qtd, so make usb transaction
>> executed correctly. If a qtd->token is not updated, maybe IOC is not set or set very
>> late, so interrupt can't be triggered in time, also mistaken 'total bytes to transfer'
>> can make HC work badly.
>
> This doesn't make any sense. ?qtd becomes the new dummy; by the time
> the HC sees qtd the only important bit set in qtd->hw_token is the HALT
> bit.

Here, I mean the 'qtd' is the 'dummy' in code, and I described it in such way
because 'dummy' has been scheduled into qh queue, so qtd should  be its
new identity, a little confusion about the description, :-)

>
>> In fact, I have traced the problem and found ehci irq is often delayed by ehci HC.
>> also sometimes ehci irq is lost, so I start to trace ehci driver and find the problem here.
>
> I don't think you have identified the underlying cause correctly.
> Something else must be responsible.

I have explained above, so please point it out if anything is still wrong.

thanks,
--
Ming Lei
