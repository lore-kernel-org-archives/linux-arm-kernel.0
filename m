From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 25 Aug 2013 22:18:42 +0530
Subject: [PATCH v4 3/4] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <20130825170151.GW6617@n2100.arm.linux.org.uk>
References: <1376672707-24527-1-git-send-email-zonque@gmail.com>
 <1376672707-24527-4-git-send-email-zonque@gmail.com>
 <5214A601.1010607@marvell.com>
 <CAHp75VfFFq0kaf7wDt3WTwsx6peBmt=rDXaUGXz=cnn4-bBKZw@mail.gmail.com>
 <5214AC80.2090102@gmail.com> <20130825161104.GC2748@intel.com>
 <20130825170151.GW6617@n2100.arm.linux.org.uk>
Message-ID: <20130825164842.GF2748@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 25, 2013 at 06:01:51PM +0100, Russell King - ARM Linux wrote:
> On Sun, Aug 25, 2013 at 09:41:04PM +0530, Vinod Koul wrote:
> > Also descriptor is returned for a transaction when you invoke .device_prep_xxx.
> > And each descriptor is assigned a cookie value.
Sorry this wasnt meant to be in same timeline, just stating that descriptor is
always assigned a cookie value and yes that will be done _only_ when descriptor
is submitted by invoking .tx_submit(). 

In dma driver, one should use cookie value to check status

Also, the reason for not assigning cookie in prepare is simple. If we preared
three trasactions A, B and C. But sumbitted A, C and then B then whole cookie
logic will fail, so it makes sense to assign cookie in an ordered fashion when
trasactions are submitted not when prepared.

Though i suspect in slave dma case, we would see ordered manner typically.

> The descriptor is not assigned a cookie in the preparation function - it
> is only assigned a cookie when it is submitted, which should always happen
> shortly after preparation.  The submission call returns the assigned
> cookie, so there's no reason for any driver to dereference the descriptor.
> 
> Any driver which does dereference the descriptor after submission is
> potentially a bug; the DMA engine owns it, and can kfree that descriptor
> any moment after submission, or even re-use it for another descriptor.
I would say after callback is invoked in case when one is set. For the ones when
no callback is set, yes after invoking tx_submit() is right one.

Clients should remeber the cookie value returned and use it to track the status
of transactions.

~Vinod
-- 
