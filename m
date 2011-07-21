From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 17:08:00 +0100
Subject: [PATCH 0/9] PL08x further cleanups
In-Reply-To: <1310598328.1536.27.camel@vkoul-udesk3>
References: <20110705131030.GE8286@n2100.arm.linux.org.uk>
	<1310598328.1536.27.camel@vkoul-udesk3>
Message-ID: <20110721160800.GR26574@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 04:35:28AM +0530, Koul, Vinod wrote:
> On Tue, 2011-07-05 at 14:10 +0100, Russell King - ARM Linux wrote:
> > This patch series is the remainder of the PL08x work I did earlier
> > this year while trying to get the ARM platforms working with DMA.
> > 
> > Unfortunately, due to the state of the hardware, I was not able to
> > properly test these changes.  However, they do compile, and I think
> > if others are going to be looking at the PL08x DMA engine driver,
> > they're worth having.
> > 
> > Linus, can you check these out on your hardware please?
> 
> Russell,
> 
> The fail to build for me, on line 550 it refers to bd.llil_bus whereas
> the bd is a pointer. Further the WIDTH macros seem to be missing.

Grr, I've updated the patches and will post the two updated ones.  I
have them in my git tree - would you like them via git instead, or
would you prefer to provide acks and let me push them upstream?

Are there any conflicting changes in amba-pl08x?

> While you are fixing this, you may want to fix the minor checkpatch
> warning as well.

No, the checkpatch warning is inappropriate - and yet again this
illustrates why checkpatch should be a _guide_ and not mandatory.
Checkpatch is warning about:

+       if (plchan->runtime_direction == DMA_FROM_DEVICE) {
+               plchan->src_addr = config->src_addr;
+       } else {
+               plchan->dst_addr = config->dst_addr;
+       }

but in the very next patch this changes to:

        if (plchan->runtime_direction == DMA_FROM_DEVICE) {
                plchan->src_addr = config->src_addr;
+               plchan->src_cctl = pl08x_cctl(cctl);
        } else {
                plchan->dst_addr = config->dst_addr;
+               plchan->dst_cctl = pl08x_cctl(cctl);
        }

Changing this so that the first patch doesn't use the braces, and add
them in the second patch makes the second patch needlessly more noisy
for no benefit.  So no, I'm not fixing that because it makes things
unnecessarily more complex.
