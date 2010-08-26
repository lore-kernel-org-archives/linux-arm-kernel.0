From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 26 Aug 2010 18:02:46 +0200
Subject: ARM: 2.6.3[45] PCI regression (IXP4xx and PXA?)
In-Reply-To: <20100826205344E.fujita.tomonori@lab.ntt.co.jp> (FUJITA
	Tomonori's message of "Thu, 26 Aug 2010 20:55:09 +0900")
References: <1282213882.22370.360.camel@pasglop>
	<20100819234835Y.fujita.tomonori@lab.ntt.co.jp>
	<1282254713.22370.368.camel@pasglop>
	<20100826205344E.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <m3iq2x2wgp.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> writes:

> Lots of drivers call dma_set_coherent_mask with 64bit mask and then
> call it with 32bit mask if 64bit mask fails.

Which seems strange to me. If the driver asks for 64-bit mask and the
system can only give it 32-bits, why return an error? Every 32-bit
address is also 64-bit, with the most significant bits simply cleared.

It makes sense the other way around, if the device wants e.g. 24-bit
mask (ISA or something) but the OS doesn't have a memory pool smaller
than e.g. 4 GB then returning with error is ok.

Same with IXP4xx (and perhaps PXA) - the device wants 32 bits and it's
fine, even if the mask is set to 28 bits since the CPU can't let PCI
access more.

If the device wants to know if it should issue DACs or something like
that, sure - just check the current masks (effective).
-- 
Krzysztof Halasa
