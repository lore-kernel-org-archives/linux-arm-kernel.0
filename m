From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Aug 2013 18:01:51 +0100
Subject: [PATCH v4 3/4] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <20130825161104.GC2748@intel.com>
References: <1376672707-24527-1-git-send-email-zonque@gmail.com>
 <1376672707-24527-4-git-send-email-zonque@gmail.com>
 <5214A601.1010607@marvell.com>
 <CAHp75VfFFq0kaf7wDt3WTwsx6peBmt=rDXaUGXz=cnn4-bBKZw@mail.gmail.com>
 <5214AC80.2090102@gmail.com> <20130825161104.GC2748@intel.com>
Message-ID: <20130825170151.GW6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 25, 2013 at 09:41:04PM +0530, Vinod Koul wrote:
> Also descriptor is returned for a transaction when you invoke .device_prep_xxx.
> And each descriptor is assigned a cookie value.

The descriptor is not assigned a cookie in the preparation function - it
is only assigned a cookie when it is submitted, which should always happen
shortly after preparation.  The submission call returns the assigned
cookie, so there's no reason for any driver to dereference the descriptor.

Any driver which does dereference the descriptor after submission is
potentially a bug; the DMA engine owns it, and can kfree that descriptor
any moment after submission, or even re-use it for another descriptor.
