From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Mar 2013 19:48:02 +0000
Subject: [PATCH] dma: of-dma: return error when 'dma-cells' not found
In-Reply-To: <51360797.6000007@gmail.com>
References: <1362475531-32260-1-git-send-email-padma.v@samsung.com>
 <1859273.NY466Orvuh@wuerfel> <51360797.6000007@gmail.com>
Message-ID: <201303051948.02468.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 March 2013, Rob Herring wrote:
> > Why would you call of_dma_controller_register() for a dma
> > engine that does not support slave channels, when that is the
> > only purpose of that interface?
> 
> Well maybe then that function should be allowed to fail without erroring
> out. I just fixed it a the line that failed.

We have a lot of interfaces that fall back to silently doing nothing
when there is no need.

> Doing be32_to_cpup directly
> on a function return that can be NULL is not correct either.

Agreed.
 
> > Note that the binding defines #dma-cells as required, and it
> > does not make any sense otherwise.
> 
> The 2nd patch I submitted changes that. It does not make sense to
> require it if you have no requests and hence will never have a phandle
> reference in a slave device.

I still don't see why you would want to use the binding for
dma slaves to describe a dmaengine that does not have slaves.

> The simple fact is that the pl330 had an
> existing binding that worked for the memory to memory only case and
> kernel changes broke this. Kernel changes should not break existing
> device-trees.

Of course we should not break the existing device tree, but I think
it would be more sensible to change the pl330 specific binding in this
case to require the use of the generic dma slave binding only when
there are slaves connected to it.

If the #dma-cells property is absent, the pl330 driver can be changed
not to call of_dma_controller_register.

	Arnd
