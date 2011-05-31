From: rientjes@google.com (David Rientjes)
Date: Mon, 30 May 2011 22:01:14 -0700 (PDT)
Subject: IrDA driver fails on PXA255
In-Reply-To: <20110529215805.GB5576@n2100.arm.linux.org.uk>
References: <20110528205701.GA1788@doriath.ww600.siemens.net>
	<alpine.DEB.2.00.1105281628480.9934@chino.kir.corp.google.com>
	<20110528234614.GV24876@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1105281913490.15709@chino.kir.corp.google.com>
	<20110529072516.GW24876@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1105291417090.9658@chino.kir.corp.google.com>
	<20110529215805.GB5576@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1105302156190.18793@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 29 May 2011, Russell King - ARM Linux wrote:

> We might as well enable CONFIG_ZONE_DMA for everything if that's what
> you're proposing, because it's not just this driver which will be affected.

I'd certainly suggest at least defaulting it to on for arm if you're going 
to be using GFP_DMA in drivers.

> And as soon as we do that, we completely lose the warnings that stuff
> needs fixing.
> 

That's because nothing needs fixing at that point, the page allocator is 
guaranteed to return lowmem if GFP_DMA is passed and CONFIG_ZONE_DMA is 
enabled, or NULL.  Whether GFP_DMA is correct in the memory allocator is a 
different subject, but those types of audits can easily be done on the 
source code.  In my opinion, we should be doing "select ZONE_DMA" on any 
Kconfig option that builds a driver that unconditionally uses GFP_DMA.

The current behavior exists so that the admin reports the error here so it 
can get fixed up (either by finding that GFP_DMA is unnecessary, selective 
depending on the particular hardware, or modifying the Kconfig) and can 
workaround the problem by forcing CONFIG_ZONE_DMA.
