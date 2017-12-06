From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Wed, 6 Dec 2017 15:03:18 +0900
Subject: [PATCH 5/8] ASoC: uniphier: add support for UniPhier AIO driver
In-Reply-To: <20171205121440.GC11658@finisterre>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
 <20171122114321.29196-6-suzuki.katsuhiro@socionext.com>
 <20171204183934.rd4vin22ktukwpip@sirena.org.uk>
 <002b01d36d84$51d80aa0$f5881fe0$@socionext.com>
 <20171205121440.GC11658@finisterre>
Message-ID: <004801d36e57$ea1940d0$be4bc270$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Tuesday, December 5, 2017 9:15 PM
> To: Suzuki, Katsuhiro/?? ?? <suzuki.katsuhiro@socionext.com>
> Cc: alsa-devel at alsa-project.org; Rob Herring <robh+dt@kernel.org>;
> devicetree at vger.kernel.org; Yamada, Masahiro/?? ??
> <yamada.masahiro@socionext.com>; Masami Hiramatsu
> <masami.hiramatsu@linaro.org>; Jassi Brar <jaswinder.singh@linaro.org>;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 5/8] ASoC: uniphier: add support for UniPhier AIO driver
> 
> On Tue, Dec 05, 2017 at 01:48:39PM +0900, Katsuhiro Suzuki wrote:
> 
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.
> 

Thank you, I set it.


> > > Is there a mux in the SoC here?
> 
> > Sorry for confusing, It's not mux.
> 
> > uniphier_srcport_reset() resets HW SRC (sampling rate converter) block.
> > Audio data out ports of UniPhier audio system have HW SRC.
> 
> Is the SRC just a single block sitting between the DMA and the external
> audio port or is there more going on?  Some of the other code made me
> think the hardware was more flexible than this (all the writing to
> registers with names like RXSEL for example).
> 

This hardware has 2 types of HW SRC. First type sit before audio port and
cannot change routing. I use it in this driver. Second type is like a loopback,
but this block is not used in this driver to simplify the first version.

Type 1:
  Mem -> DMA -> SRC -> Out Port -> External pin
Type 2:
  Mem -> DMA -> SRC -> Out Port -> In Port -> DMA -> Mem


> > > > +#endif /* CONFIG_SND_SOC_UNIPHIER_LD11 */
> 
> > > Why is there an ifdef here?  There's no other conditional code in here,
> > > it seems pointless.
> 
> > This config is used to support or not LD11 SoC.
> > aio-ld11.c is not build and 'uniphier_aio_ldxx_spec' is undefined if this
config is
> disabled.
> >
> > aio-ld11.c defines SoC dependent resources (port, HW ring buffer, DMA ch,
etc.)
> > and fixed settings.
> > I know it's better to move such information into device-tree, but register
areas of
> > UniPhier's audio system is very strange and interleaved. It's hard to split
each
> nodes...
> 
> I'd expect this code to be structured more like a library - have a
> driver that handles the specific IPs then have it call into a shared
> block of code that does the generic bits.  Though in this case the
> device specific bit looks like a couple of tiny data tables so I'm not
> sure it's worth making it conditional or separate at all.
> 

Sorry... I agree your opinion, but I can't imagine the detail.

I think my driver has structure as follows (ex. startup):
  DAI: uniphier_aio_startup()@aio-core.c
  Lib: uniphier_aio_init()@aio-regctrl.c
  SoC specific: uniphier_aio_ld11_spec at aio-ld11.c

Am I wrong? Would you mean split the functions in aio-regctl.[ch] to other
kernel module? I wonder if you could tell me the example from existing
drivers. I'll try to fix my driver like as it.


> > > This looks awfully like compressed audio support...  should there be
> > > integration with the compressed audio API/
> 
> > Thanks, I'll try it. Is there Documentation in
> sound/designes/compress-offload.rst?
> > And best sample is... Intel's driver?
> 
> Yes.
> 
> > (Summary)
> > I think I should fix as follows:
> 
> >   - Split DMA, DAI patches from large one
> >   - Validate parameters in hw_params
> >   - Add description about HW SRC (or fix bad name 'srcport')
> >   - Add comments about uniphier_aiodma_irq()
> >   - Expose clocking and audio routing to userspace, or at the very
> >     least machine driver configuration
> >   - Support compress-audio API for S/PDIF
> 
> > and post V2.
> 
> At least.  I do think we need to get to the bottom of how flexible the
> hardware is first though.

Yes, indeed. This hardware is more flexible and complex, but now I (and our
company) don't use it. Of course, I don't want to hide some features of this
hardware from ALSA people. I should try to upstream all features in the future,
I think.


Regards,
--
Katsuhiro Suzuki
