From: vkoul@infradead.org (Vinod Koul)
Date: Mon, 25 Jul 2011 19:08:31 +0530
Subject: [PATCH 0/9] PL08x further cleanups
In-Reply-To: <20110721160800.GR26574@n2100.arm.linux.org.uk>
References: <20110705131030.GE8286@n2100.arm.linux.org.uk>
	<1310598328.1536.27.camel@vkoul-udesk3>
	<20110721160800.GR26574@n2100.arm.linux.org.uk>
Message-ID: <1311601111.8206.5.camel@vkoul-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-07-21 at 17:08 +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 14, 2011 at 04:35:28AM +0530, Koul, Vinod wrote:
> > On Tue, 2011-07-05 at 14:10 +0100, Russell King - ARM Linux wrote:
> > > This patch series is the remainder of the PL08x work I did earlier
> > > this year while trying to get the ARM platforms working with DMA.
> > > 
> > > Unfortunately, due to the state of the hardware, I was not able to
> > > properly test these changes.  However, they do compile, and I think
> > > if others are going to be looking at the PL08x DMA engine driver,
> > > they're worth having.
> > > 
> > > Linus, can you check these out on your hardware please?
> > 
> > Russell,
> > 
> > The fail to build for me, on line 550 it refers to bd.llil_bus whereas
> > the bd is a pointer. Further the WIDTH macros seem to be missing.
> 
> Grr, I've updated the patches and will post the two updated ones.  I
> have them in my git tree - would you like them via git instead, or
> would you prefer to provide acks and let me push them upstream?
> 
Russell,
Thanks I have applied this

Although gcc didnt like not handling other enums so warned:

drivers/dma/amba-pl08x.c: In function 'pl08x_width':
drivers/dma/amba-pl08x.c:1119: warning: enumeration value
'DMA_SLAVE_BUSWIDTH_UNDEFINED' not handled in switch
drivers/dma/amba-pl08x.c:1119: warning: enumeration value
'DMA_SLAVE_BUSWIDTH_8_BYTES' not handled in switch

which can be fixed as:

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 9aa2bd4..4925e0d 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1123,6 +1123,8 @@ static u32 pl08x_width(enum dma_slave_buswidth
width)
 		return PL080_WIDTH_16BIT;
 	case DMA_SLAVE_BUSWIDTH_4_BYTES:
 		return PL080_WIDTH_32BIT;
+	default:
+		return -EINVAL;
 	}
 	return ~0;
 }

If you are okay, pls ack it

-- 
~Vinod Koul
Intel Corp.
