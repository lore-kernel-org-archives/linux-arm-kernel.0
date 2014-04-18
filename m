From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 18 Apr 2014 08:40:54 +0200 (CEST)
Subject: [patch 5/6] edma: Make reading the position of active channels
 work
In-Reply-To: <5350761C.6010109@ti.com>
References: <20140417133737.892475126@linutronix.de>
 <20140417143249.889774979@linutronix.de> <5350761C.6010109@ti.com>
Message-ID: <alpine.DEB.2.02.1404180834520.22697@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Apr 2014, Joel Fernandes wrote:
> On 04/17/2014 09:40 AM, Thomas Gleixner wrote:
> > +	/*
> > +	 * If the channel is active, we need to double read as we
> > +	 * might see half updated data. We limit this to 5
> > +	 * attempts. If that fails we return -EBUSY and let the caller
> > +	 * deal with it.
> > +	 */
> > +	dat = edma_read(ctlr, offs);
> > +	for (i = 0; i < 5; i++) {
> > +		u32 tmp = edma_read(ctlr, offs);
> > +
> > +		if (tmp == dat) {
> > +			*pos = dat;
> > +			return 0;
> > +		}
> > +		dat = tmp;
> > +	}
> > +	return -EBUSY;
> >  }
> > -EXPORT_SYMBOL(edma_get_position);
> >  
> >  /**
> 
> The access is synchronized though and you shouldn't see unreliable
> results, unless you _are_ seeing unreliable results in which case it
> could be a silicon issue.
>
> The original code also doesn't have the double read so I would just drop
> that, unless you are seeing reliability issues.
>
> Here's a thread that discusses it and the end conclusion is that it
> should be fine (Kyle Kastile is one of the EDMA hardware designers).
> http://e2e.ti.com/support/dsp/davinci_digital_media_processors/f/99/t/66011.aspx

Gah, right I saw the issues with the original code, which does a
memcpy_fromio which copies byte by byte. Did not think about retrying
with the edma_read() based one.

Thanks,

	tglx
