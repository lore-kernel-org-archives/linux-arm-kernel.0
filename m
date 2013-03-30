From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 30 Mar 2013 13:29:15 +0000
Subject: [PATCH] Fix IXP4xx coherent allocations
In-Reply-To: <m3r4j4sdmv.fsf@intrepid.localdomain>
References: <m3obe9lxil.fsf@intrepid.localdomain>
 <20130323.195740.2108147521543354261.davem@davemloft.net>
 <1364152267.3620.31.camel@deadeye.wl.decadent.org.uk>
 <m3r4j4sdmv.fsf@intrepid.localdomain>
Message-ID: <20130330132915.GB17995@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 24, 2013 at 10:15:36PM +0100, Krzysztof Halasa wrote:
> The problem on ARM (and probably on powerpc, and on something called
> "metag" - grep -r 'coherent DMA mask is unset' arch) is that the default
> coherent DMA mask is zero. IOW, coherent DMA allocations are, by
> default, disabled. A driver has to dma_set_coherent_mask() or, as many
> drivers do, set dev->coherent_dma_mask directly (IMHO
> dev->coherent_dma_mask along with dev->dma_mask are private DMA API
> stuff and e.g. device drivers have no interest there).
> 
> The zero default is IMHO, WRT the actual DMA API, an ARM bug (and
> powerpc's etc). Nevertheless, the patch I posted does everything as
> required by the API. Specifically, the IXP4xx arch part makes
> IXP4xx's dma_set_coherent_mask() compliant with DMA API, and the actual
> dma_set_coherent_mask() calls in drivers are both valid and I guess
> recommended by the API.
> 
> The patch doesn't touch the core ARM issue, that's right.

I'm having a hard time understanding what is an ARM issue here, what is
an ARM bug, and what the DMA API requires.  The DMA API documentation
is extremely sparse in describing what's required of the DMA masks,
what these functions are supposed to do, and what determines whether
a mask is "possible" or not.

Moreover, I'm also having a hard time understanding what broke in 3.7,
and why this fixes it.

In other words, I'm completely failing to understand everything about
this patch.
