From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 14 Sep 2018 17:57:06 +0200
Subject: [RFC PATCH 3/3] dma-mapping: clear dma_parms on teardown, too
In-Reply-To: <874f7cd9-ac51-5968-de40-14a0addf9c96@arm.com>
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
 <20180913151716.6333-4-wsa+renesas@sang-engineering.com>
 <874f7cd9-ac51-5968-de40-14a0addf9c96@arm.com>
Message-ID: <20180914155706.GA906@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2018 at 02:23:51PM +0100, Robin Murphy wrote:
> On 13/09/18 16:17, Wolfram Sang wrote:
> > While sanitizig the pointer for dma_ops on teardown, do the same for
> > dma_parms, too. Rename the function to have a more generic name.
> 
> Upon closer inspection, it looks like there are some cases (at least PCI and
> MFD) where dma_parms is installed by the parent/bus at device creation, and
> therefore remains valid and *would* be expected to persist across the child
> device's driver unbinding and rebinding - seems this is more complex than I
> first thought, sorry.

No problem. I am thankful I understand more details. So, the life cycle
of dma_parms is truly that of the device. Which means that the drivers
using devm_kzalloc in their probe, should ideally clear the pointer on
unbind. Otherwise, it is not possible to say if the non-NULL dma_parms
is intended or dangling. Which makes my initial dmam_set_dma_parms()
approach look not too bad, I'd think?

However, I don't want to push hard with this one. If you think this is
too academic, I'll just leave it for now...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180914/0e62acbc/attachment.sig>
