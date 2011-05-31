From: rientjes@google.com (David Rientjes)
Date: Mon, 30 May 2011 22:05:38 -0700 (PDT)
Subject: IrDA driver fails on PXA255
In-Reply-To: <20110529215656.GA5576@n2100.arm.linux.org.uk>
References: <20110528205701.GA1788@doriath.ww600.siemens.net>
	<alpine.DEB.2.00.1105281628480.9934@chino.kir.corp.google.com>
	<BANLkTim9YdhjY75CzMsSOCVKZWi-WKZ5wA@mail.gmail.com>
	<alpine.DEB.2.00.1105291410450.9658@chino.kir.corp.google.com>
	<20110529215656.GA5576@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1105302202510.18793@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 29 May 2011, Russell King - ARM Linux wrote:

> > That would return memory that is not guaranteed to be within the first 
> > 16MB of address space, so a GFP_DMA allocation would succeed with memory 
> > not from ZONE_DMA.
> 
> Err, no. GFP_DMA returns memory in a zone which the platform has setup.
> There's nothing specific about it being "16MB" or any other size; the
> arch can chose what size that is.
> 

Sorry, was talking from the x86 perspective, which probably doesn't make 
much sense since we're talking about an arm driver :)

> > That's an invalid configuration, so users, including 
> > you, should at least edit their .config by hand to enable CONFIG_ZONE_DMA 
> > as a workaround.
> 
> Again, no.  This change has caused a load of previously working drivers
> to suddenly start failing without _any_ explanation why or even warning
> about the change.  It needs to start off as a WARN_ON() so that stuff
> can be fixed, and then changed to a hard error.
> 

I haven't seen a "load" of error reports where this is causing an issue, 
maybe it is much more popular on arm?

This also isn't a hard error, admins should be able to enable 
CONFIG_ZONE_DMA and rebuild so that the driver being loaded can get the 
type of memory it is requesting.  Just putting a WARN_ON() doesn't provide 
any incentive to ever get this stuff fixed.
