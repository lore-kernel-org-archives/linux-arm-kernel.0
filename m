From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Jul 2013 18:18:26 +0100
Subject: Requirements for FDT load address on ARM
In-Reply-To: <alpine.LFD.2.03.1307241116200.15022@syhkavp.arg>
References: <1374677923.6623.194.camel@hastur.hellion.org.uk>
 <alpine.LFD.2.03.1307241116200.15022@syhkavp.arg>
Message-ID: <20130724171826.GX11072@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 04:24:48PM +0100, Nicolas Pitre wrote:
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
> 
> > I'm finding that if I load it "too high" I get a fault (the specifics
> > aren't that relevant but details are below).
> 
> Do you have commit 6f16f4998f98 in your kernel tree?
> 
> > FWIW with RAM from 0x8000000-0xffffffff and a kernel loaded at 
> > 0x80008000 "too high" means above somewhere around 0xaf800000.
> 
> Sorry, I don't understand the above sentence.
> 
> Is RAM actually starting at 0x08000000 ?  Note that the kernel must be 
> loaded in the first 128MB of RAM.
> 
> > I expect this is because the kernel doesn't use an explicit mapping of
> > the fdt but expects it to be within the RAM directly mapped by the
> > lowmem area (i.e. it uses phys_to_virt, since day one aka 93c02ab40ae6
> > "arm/dt: probe for platforms via the device tree").
> 
> The fdt is expected to be located in lowmem.  So yes, that's actually a 
> restriction.

FWIW, you could have a look at what I do in kvmtool. It's not perfect, but
I couldn't come up with anything better:

https://git.kernel.org/cgit/linux/kernel/git/will/kvmtool.git/tree/tools/kvm/arm/fdt.c?h=kvmtool/master

(see the load_flat_binary function)

Will
