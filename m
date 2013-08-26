From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 26 Aug 2013 08:07:34 +0200
Subject: [PATCH v4 3/4] dma: mmp_pdma: add support for residue reporting
References: <1376672707-24527-1-git-send-email-zonque@gmail.com>
 <1376672707-24527-4-git-send-email-zonque@gmail.com>
 <5214A601.1010607@marvell.com>
 <CAHp75VfFFq0kaf7wDt3WTwsx6peBmt=rDXaUGXz=cnn4-bBKZw@mail.gmail.com>
 <5214AC80.2090102@gmail.com> <20130825161104.GC2748@intel.com>
 <20130825170151.GW6617@n2100.arm.linux.org.uk>
 <20130825164842.GF2748@intel.com>
 <20130825180615.GX6617@n2100.arm.linux.org.uk>
Message-ID: <87vc2touhl.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> Even when there is a callback set, there's no requirement for the DMA
> engine driver to keep the descriptor around after it has been submitted -
> it is free to copy that data into whatever internal representation it
> requires and then discard the descriptor if it so wishes.

That means that a driver which wished to "resubmit" the descriptor has to
"rebuild it" again, no ?

I was under the impression that a descriptor had the guarantee to survive even
after completion. This comes from include/linux/dmaengine.h:168, in enum
dma_ctrl_flags comment :
 * @DMA_CTRL_ACK - if clear, the descriptor cannot be reused until the client
 *  acknowledges receipt, i.e. has has a chance to establish any dependency
 *  chains

The sentence "cannot be reused until" meant that after it could be reused.

And there are usecases for that, for example a video capture buffer. The source
for DMA is always the same (camera FIFO), the destination is always the same
(ie. the same scatter-gather). Why rebuild all the info to resubmit the same
descriptor ?

So is my understand incorrect, and in that case is there a way with dmaengine to
"resubmit" a descriptor, without going through the whole preparation ?

Cheers.

-- 
Robert
