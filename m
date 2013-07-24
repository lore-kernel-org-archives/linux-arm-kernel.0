From: ian.campbell@citrix.com (Ian Campbell)
Date: Wed, 24 Jul 2013 19:31:45 +0100
Subject: Requirements for FDT load address on ARM
In-Reply-To: <alpine.LFD.2.03.1307241116200.15022@syhkavp.arg>
References: <1374677923.6623.194.camel@hastur.hellion.org.uk>
 <alpine.LFD.2.03.1307241116200.15022@syhkavp.arg>
Message-ID: <1374690705.30195.18.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-07-24 at 11:24 -0400, Nicolas Pitre wrote:
> On Wed, 24 Jul 2013, Ian Campbell wrote:
> 
> > [apologies if this is a repeat, I don't see it in the archives and at
> > least one CC'd recipient (Julien) didn't receive it either. Beasties in
> > our email server I expect...]
> > 
> > Are there any requirements about where the FDT may be loaded by the
> > bootloader?
> 
> It must be located where it is unlikely to be overwritten by the zImage 
> decompressor relocating itself.  Same goes for the initrd.

Right. That's a bit hard to determine programmaticaly from a bootloader
though :-(

> > I'm finding that if I load it "too high" I get a fault (the specifics
> > aren't that relevant but details are below).
> 
> Do you have commit 6f16f4998f98 in your kernel tree?

It doesn't look like I do. The symptoms I'm seeing could well be
explained by that lack.

> > FWIW with RAM from 0x8000000-0xffffffff and a kernel loaded at 
> > 0x80008000 "too high" means above somewhere around 0xaf800000.
> 
> Sorry, I don't understand the above sentence.
> 
> Is RAM actually starting at 0x08000000 ?

Sorry, missed a zero, RAM starts at 0x80000000.

What I was trying to say that in my empirical experience loading the fdt
"too high" meant above 0xaf800000. Not actually terribly useful data
TBH.

>   Note that the kernel must be 
> loaded in the first 128MB of RAM.

> > I expect this is because the kernel doesn't use an explicit mapping of
> > the fdt but expects it to be within the RAM directly mapped by the
> > lowmem area (i.e. it uses phys_to_virt, since day one aka 93c02ab40ae6
> > "arm/dt: probe for platforms via the device tree").
> 
> The fdt is expected to be located in lowmem.  So yes, that's actually a 
> restriction.

OK, that's good to know.

> > This effectively
> > limits the FDT to being within the first ~700MB (give or take based
> > on .config etc, I suppose <500MB is a pretty safe rule of thumb). Is
> > this expected or is it actually not intentional and the kernel should
> > really be using an explicit mapping here? Should I send a patch against
> > Documentation/arm/Booting?
> 
> Yes please.

OK I'll try and put something together which I hope won't be too
drastically wrong.

Ian.
