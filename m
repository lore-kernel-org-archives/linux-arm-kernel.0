From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 24 Jul 2013 17:27:38 -0400 (EDT)
Subject: Requirements for FDT load address on ARM
In-Reply-To: <1374690705.30195.18.camel@hastur.hellion.org.uk>
References: <1374677923.6623.194.camel@hastur.hellion.org.uk>
 <alpine.LFD.2.03.1307241116200.15022@syhkavp.arg>
 <1374690705.30195.18.camel@hastur.hellion.org.uk>
Message-ID: <alpine.LFD.2.03.1307241625190.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Jul 2013, Ian Campbell wrote:

> On Wed, 2013-07-24 at 11:24 -0400, Nicolas Pitre wrote:
> > On Wed, 24 Jul 2013, Ian Campbell wrote:
> > 
> > > [apologies if this is a repeat, I don't see it in the archives and at
> > > least one CC'd recipient (Julien) didn't receive it either. Beasties in
> > > our email server I expect...]
> > > 
> > > Are there any requirements about where the FDT may be loaded by the
> > > bootloader?
> > 
> > It must be located where it is unlikely to be overwritten by the zImage 
> > decompressor relocating itself.  Same goes for the initrd.
> 
> Right. That's a bit hard to determine programmaticaly from a bootloader
> though :-(

Well... The kernel has to be loaded in the first 128MB of RAM for the 
automatic RAM location to work.  So you simply have to load the ftd and 
initrd sequentially above the 128MB mark.  The kernel cannot grow above 
16MB in size or we lose the ability to link modules without far calls, 
or 32MB for the kernel itself after wich the kernel itself doesn't link.  
This means the decompressor will never relocate anything above the 128MB 
mark in any case.

In practice this limit can even be lowered to 64MB.


Nicolas
