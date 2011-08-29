From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 29 Aug 2011 22:25:10 +0800
Subject: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
In-Reply-To: <Pine.LNX.4.44L0.1108281233270.3742-100000@netrider.rowland.org>
References: <CACVXFVP8Lr=ggH4FjvMQd6r9poLAT1r+_S3Z-NimP0i08DsQ8g@mail.gmail.com>
	<Pine.LNX.4.44L0.1108281233270.3742-100000@netrider.rowland.org>
Message-ID: <CACVXFVOvw6bSfcOYR2RWJO=k1WLgSCUygmSwZmtRDdM_tZNWEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 29, 2011 at 1:00 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Sun, 28 Aug 2011, Ming Lei wrote:
>
>> > I've been following this whole discussion. ?I didn't understand the
>> > idea behind the original patch, and I don't understand this. ?What
>> > reason is there for adding a memory barrier after the "dummy->hw_token
>> > = token" line? ?Such a barrier would not accomplish anything useful,
>> > because there are no later memory accesses which need to be ordered
>> > with respect to that line.
>>
>> Here, mb is used to synchronize ?between writing of CPU and reading of
>> ehci HC, see below:
>
> A memory barrier never synchronizes events between two processors (for
> example, between the CPU and HC). ?It only affects ordering for the
> processor it executes on. ?That's why you always have to use memory
> barriers in pairs for inter-CPU synchronization: one memory barrier
> instruction for each CPU.

IMO, for SMP case, memory barrier pairs(smp_*) are required to synchronize
events between two processors. mb/wmb/rmb are mainly used to
synchronize events between CPU and device, and one barrier may be
enough, for example:

	CPU							device	
	A=1;
	wmb
	B=2;
									read B
									read A

one wmb is used to order 'A=1' and 'B=2', which will make the two write
operations reach to physical memory as the order: 'A=1' first, 'B=1' second.
Then the device can observe the two write events as the order above,
so if device has seen 'B==2', then device will surely see 'A==1'.

>
>> ? ? ? CPU ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? EHCI
>> ? ? ? dummy->hw_token = token;
>> ? ? ? mb
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? read ?dummy->hw_token
>>
>> The mb() introduced ?was supposed to be used to make sure that EHCI
>> can see the correct value of ?dummy->hw_token.
>
> It won't do that. ?All it will do is guarantee that the CPU writes out
> dumy->hw_token before it writes out or reads in any values executed
> after the mb.
>
>> ?If EHCI can't get the correct
>> hw_token in time, it will work badly, such as irq delay or irq lost which may be
>> caused by mistaken 'IOC' or 'total bytes to transfer' in hw_token.
>
> No. ?All that will happen is that the HC will execute the qTD a little
> later, when it does read the correct hw_token. ?No IRQs will be lost,
> and there will be no mistaken IOC or "total bytes to transfer" values.

IMO, the dummy has been linked into queue pointed by qh->hw->hw_qtd_next,
so EHCI will fetch dummy qtd and execute the transaction and will not have
any delay on the transaction.

Let me explain the problem again: On ARM, the wmb() before
'dummy->hw_token = token;'
will flush l2 write buffer into memory and all parts of 'dummy' except
for hw_token field
have reached into memory already, but dummy->hw_token will stay at l2
write buffer
and not reach into memory at this time, so ehci may fetch a
inconsistent qtd and execute it,
then mistaken IOC or "total bytes to transfer"  are read by EHCI and
cause delayed irq
or lost irq.

It is not only a reasoning or guess, and I have traced this kind of
fact certainly.

>
>> ?This is just
>> what the patch is to fix.
>
> The patch won't fix this. ?You're trying to force the CPU to write out
> dummy->hw_token more quickly. ?A memory barrier won't do that. ?And
> even if the CPU does write out the value more quickly, that doesn't
> guarantee it will be in time for the HC to see the new value right
> away.
>
>> But I think the above is still not correct, and the correct way may be
>> like below:
>>
>> ? ? ? CPU ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? EHCI
>> ? ? ? dummy->hw_token = token;
>> ? ? ? wmb
>> ? ? ? qh->hw->hw_qtd_next = QTD_NEXT(ehci, dummy->qtd_dma);
>
> If you do this write, you will corrupt the hardware list. ?You _must_
> _not_ modify the hardware fields of an active QH.

Yes, I agree on it. hw_qtd_next is write by HC and qh_refresh(), and it
should be written only by cpu when the qh is in idle state.

> Besides, qh_link_async() calls qh_refresh() -> qh_update(), which does
> this already. ?And it does this correctly, with the appropriate checks
> to make sure the QH isn't active.
>
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? fetch next qtd from qh->hw->hw_qtd_next
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? read ?qtd->hw_token
>>
>> The problem is that qh has already linked dummy into its queue before(as did in
>> qh_update), so even after 'dummy->hw_token = token;' is executed on CPU, EHCI
>> still may not fetch the up-to-date value of the qtd(dummy in here),
>> and this should
>> be the root cause, IMO.
>
> There's no way to fix this. ?The CPU and the HC are independent. ?The
> HC is allowed to cache values whenever it likes (within certain
> limits). ?If it has already cached an old value from the qTD, there's
> no way to force it to use a new value. ?You just have to wait until it
> refreshes its cache.

I don't think ehci will cache something inside hardware, and it will
always fetch qtd linked into qh from memory(not cache) to qh transfer overlay.
We can find it in ehci spec 4.10.2.

As I explained above in the 'wmb' example, I hope we can use
the current memory barrier rules to fix this kind of problem and avoid
to invent new barrier. But because we can't write qh->hw->hw_qtd_next
when the qh has been linked into ehci async queue, it is not doable.

thanks,
--
Ming Lei
