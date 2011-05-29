From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 May 2011 22:56:56 +0100
Subject: IrDA driver fails on PXA255
In-Reply-To: <alpine.DEB.2.00.1105291410450.9658@chino.kir.corp.google.com>
References: <20110528205701.GA1788@doriath.ww600.siemens.net>
	<alpine.DEB.2.00.1105281628480.9934@chino.kir.corp.google.com>
	<BANLkTim9YdhjY75CzMsSOCVKZWi-WKZ5wA@mail.gmail.com>
	<alpine.DEB.2.00.1105291410450.9658@chino.kir.corp.google.com>
Message-ID: <20110529215656.GA5576@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 29, 2011 at 02:17:02PM -0700, David Rientjes wrote:
> On Sun, 29 May 2011, Dmitry Eremin-Solenikov wrote:
> 
> > What about changing your patch for less intrusive one (to emit a
> > WARN_ON) for at least one
> > or two major releases and only then changing it back to the current state?
> > 
> 
> That would return memory that is not guaranteed to be within the first 
> 16MB of address space, so a GFP_DMA allocation would succeed with memory 
> not from ZONE_DMA.

Err, no. GFP_DMA returns memory in a zone which the platform has setup.
There's nothing specific about it being "16MB" or any other size; the
arch can chose what size that is.

> That's an invalid configuration, so users, including 
> you, should at least edit their .config by hand to enable CONFIG_ZONE_DMA 
> as a workaround.

Again, no.  This change has caused a load of previously working drivers
to suddenly start failing without _any_ explanation why or even warning
about the change.  It needs to start off as a WARN_ON() so that stuff
can be fixed, and then changed to a hard error.
