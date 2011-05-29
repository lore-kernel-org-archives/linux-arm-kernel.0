From: rientjes@google.com (David Rientjes)
Date: Sun, 29 May 2011 14:17:02 -0700 (PDT)
Subject: IrDA driver fails on PXA255
In-Reply-To: <BANLkTim9YdhjY75CzMsSOCVKZWi-WKZ5wA@mail.gmail.com>
References: <20110528205701.GA1788@doriath.ww600.siemens.net>
	<alpine.DEB.2.00.1105281628480.9934@chino.kir.corp.google.com>
	<BANLkTim9YdhjY75CzMsSOCVKZWi-WKZ5wA@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1105291410450.9658@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 29 May 2011, Dmitry Eremin-Solenikov wrote:

> What about changing your patch for less intrusive one (to emit a
> WARN_ON) for at least one
> or two major releases and only then changing it back to the current state?
> 

That would return memory that is not guaranteed to be within the first 
16MB of address space, so a GFP_DMA allocation would succeed with memory 
not from ZONE_DMA.  That's an invalid configuration, so users, including 
you, should at least edit their .config by hand to enable CONFIG_ZONE_DMA 
as a workaround.  Then, we should try to fix up the Kconfig entries for 
drivers requiring DMA allocations to select CONFIG_ZONE_DMA or fix 
defconfigs when DMA is known to be needed for a device.
