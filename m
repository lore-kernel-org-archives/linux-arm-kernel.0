From: scottwood@freescale.com (Scott Wood)
Date: Wed, 19 Jan 2011 12:19:25 -0600
Subject: RFC: Host-endian device tree format
In-Reply-To: <AANLkTi=AdwaW5vvm1TzNxcNrjYiJ3dOEjwoZrm-koxuw@mail.gmail.com>
References: <AANLkTi=AdwaW5vvm1TzNxcNrjYiJ3dOEjwoZrm-koxuw@mail.gmail.com>
Message-ID: <20110119121925.2680afd1@udp111988uds.am.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Jan 2011 10:43:02 +0000
Dave Martin <dave.martin@linaro.org> wrote:

> Hi all,
> 
> Apologies if this has been discussed before--- I don't see an obvious
> rebuttal in my quick searching past threads, so I'll just quickly ask
> the question:
> 
> Could we use host-endianness for the device tree binary blob?
> 
> The fdt binary format seems to lend itself strongly to a host-endian
> format: it begins with a word-sized magic number, and when parsing the
> device tree every elements type and size is known before that element
> is read; furthermore, every element is size-aligned.  Therefore, I
> (naively?) presume that a little-endian format should "just work",
> simply by flipping the endianness of every element and discarding all
> the __be32_to_cpu() type stuff when reading the fdt at boot time.  The
> magic number ensures that there's no risk of accidentally reading the
> fst in the wrong byte order.

It's simpler and faster to unconditionally swap a word as you load it,
especially on instruction sets with swapping support, than it is to
dynamically decide whether to swap.  It would be nice if GCC would let
data structures be annotated with endianness, so that it would
automatically swap when needed, though.

Look at the I/O accessors in drivers/dma/fsldma.h -- that complexity
wouldn't have been necessary if Freescale hadn't "fixed" the endianness
when sticking the DMA engine in a new chip family.

What about bi-endian hardware?  Is it possible you might ever want to
boot a kernel in one endianness when the device tree was generated
assuming the opposite choice?

-Scott
