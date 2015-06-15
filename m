From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 15 Jun 2015 12:09:59 +0100
Subject: [PATCH] serial/amba-pl011: Disable interrupts around TX softirq
In-Reply-To: <20150613003945.GA10941@kroah.com>
References: <1433513267-24163-1-git-send-email-Dave.Martin@arm.com>
 <20150613003945.GA10941@kroah.com>
Message-ID: <557EB287.300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 06/13/2015 01:39 AM, Greg Kroah-Hartman wrote:
> On Fri, Jun 05, 2015 at 03:07:47PM +0100, Dave Martin wrote:
>> pl011_tx_softirq() currently uses spin_{,un}lock(), which are not
>> sufficient to inhibit pl011_int() from being triggered by a local
>> IRQ and trying to re-take the same lock.  This can lead to
>> deadlocks.
>>
>> This patch uses the _irq() locking variants instead to ensure that
>> pl011_int() handling for a given port is deferred until any
>> pl011_tx_softirq() work for that port is complete.
>>
>> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>> Tested-by: Robin Murphy <robin.murphy@arm.com>
>> Cc: stable <stable@vger.kernel.org> # 4.1
>> ---
>>
>> Another candidate for v4.1 if possible (sorry!) -- I thought this change
>> was already in, but it went astray when I was refactoring.
> 
> Too late for 4.1, sorry.

So if I get this correctly, we go from "some characters lost from
systemd messages" behaviour in 4.0 to "may deadlock" in 4.1 now?
Is that right?

I understand that you are reluctant to take this patch this late in the
game, but wouldn't it actually be better now to revert PL011 to the
state of 4.0 to avoid ending up with worse-than-4.0 behaviour in the 4.1
release?
We could still backport the solution ending up in 4.2-rc to 4.1.x.

Cheers,
Andre.

> This doesn't apply to my tty-next branch,
> otherwise I would have queued it up there.  Care to redo it and mark it
> for -stable, like I did above, and resend it?
> 
> thanks,
> 
> greg k-h
> 
