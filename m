From: vkoul@infradead.org (Vinod Koul)
Date: Mon, 25 Jul 2011 19:21:51 +0530
Subject: [PATCH 0/9] PL08x further cleanups
In-Reply-To: <20110725134340.GK9653@n2100.arm.linux.org.uk>
References: <20110705131030.GE8286@n2100.arm.linux.org.uk>
	<1310598328.1536.27.camel@vkoul-udesk3>
	<20110721160800.GR26574@n2100.arm.linux.org.uk>
	<1311601111.8206.5.camel@vkoul-mobl4>
	<20110725134340.GK9653@n2100.arm.linux.org.uk>
Message-ID: <1311601911.8206.11.camel@vkoul-mobl4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-07-25 at 14:43 +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 25, 2011 at 07:08:31PM +0530, Vinod Koul wrote:
> > Although gcc didnt like not handling other enums so warned:
> > 
> > drivers/dma/amba-pl08x.c: In function 'pl08x_width':
> > drivers/dma/amba-pl08x.c:1119: warning: enumeration value
> > 'DMA_SLAVE_BUSWIDTH_UNDEFINED' not handled in switch
> > drivers/dma/amba-pl08x.c:1119: warning: enumeration value
> > 'DMA_SLAVE_BUSWIDTH_8_BYTES' not handled in switch
> 
> Those must be new since I wrote the patch.
> 
> > which can be fixed as:
> > 
> > diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> > index 9aa2bd4..4925e0d 100644
> > --- a/drivers/dma/amba-pl08x.c
> > +++ b/drivers/dma/amba-pl08x.c
> > @@ -1123,6 +1123,8 @@ static u32 pl08x_width(enum dma_slave_buswidth
> > width)
> >  		return PL080_WIDTH_16BIT;
> >  	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> >  		return PL080_WIDTH_32BIT;
> > +	default:
> > +		return -EINVAL;
> >  	}
> >  	return ~0;
> >  }
> > 
> > If you are okay, pls ack it
> 
> No.  This function is used as:
> 
> +       width = pl08x_width(addr_width);
> +       if (width == ~0) {
>                 dev_err(&pl08x->adev->dev,
>                         "bad runtime_config: alien address width\n");
>                 return -EINVAL;
>         }
> 
> Notice that it returns a u32 so negative errnos don't make sense.  It
> returns ~0 to indicate error.
> 
> The code is actually correct as it stands, it's just gcc deciding to
> emit a warning for an unhandled enum value which isn't really unhandled.
> Just move the 'return ~0;' at the end of the function inside the switch
> as a default case to shut it up.
Okay but shouldn't this ideally check for width < 0, that way we can
return proper errors?

-- 
~Vinod Koul
Intel Corp.
