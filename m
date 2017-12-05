From: broonie@kernel.org (Mark Brown)
Date: Tue, 5 Dec 2017 12:14:40 +0000
Subject: [PATCH 5/8] ASoC: uniphier: add support for UniPhier AIO driver
In-Reply-To: <002b01d36d84$51d80aa0$f5881fe0$@socionext.com>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
 <20171122114321.29196-6-suzuki.katsuhiro@socionext.com>
 <20171204183934.rd4vin22ktukwpip@sirena.org.uk>
 <002b01d36d84$51d80aa0$f5881fe0$@socionext.com>
Message-ID: <20171205121440.GC11658@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 01:48:39PM +0900, Katsuhiro Suzuki wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > Is there a mux in the SoC here?

> Sorry for confusing, It's not mux.

> uniphier_srcport_reset() resets HW SRC (sampling rate converter) block.
> Audio data out ports of UniPhier audio system have HW SRC.

Is the SRC just a single block sitting between the DMA and the external
audio port or is there more going on?  Some of the other code made me
think the hardware was more flexible than this (all the writing to
registers with names like RXSEL for example).

> > > +#endif /* CONFIG_SND_SOC_UNIPHIER_LD11 */

> > Why is there an ifdef here?  There's no other conditional code in here,
> > it seems pointless.

> This config is used to support or not LD11 SoC.
> aio-ld11.c is not build and 'uniphier_aio_ldxx_spec' is undefined if this config is disabled.
> 
> aio-ld11.c defines SoC dependent resources (port, HW ring buffer, DMA ch, etc.)
> and fixed settings.
> I know it's better to move such information into device-tree, but register areas of
> UniPhier's audio system is very strange and interleaved. It's hard to split each nodes...

I'd expect this code to be structured more like a library - have a
driver that handles the specific IPs then have it call into a shared
block of code that does the generic bits.  Though in this case the
device specific bit looks like a couple of tiny data tables so I'm not
sure it's worth making it conditional or separate at all.

> > This looks awfully like compressed audio support...  should there be
> > integration with the compressed audio API/

> Thanks, I'll try it. Is there Documentation in sound/designes/compress-offload.rst?
> And best sample is... Intel's driver?

Yes.

> (Summary)
> I think I should fix as follows:

>   - Split DMA, DAI patches from large one
>   - Validate parameters in hw_params
>   - Add description about HW SRC (or fix bad name 'srcport')
>   - Add comments about uniphier_aiodma_irq()
>   - Expose clocking and audio routing to userspace, or at the very
>     least machine driver configuration
>   - Support compress-audio API for S/PDIF

> and post V2.

At least.  I do think we need to get to the bottom of how flexible the
hardware is first though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/23f3b2ab/attachment.sig>
