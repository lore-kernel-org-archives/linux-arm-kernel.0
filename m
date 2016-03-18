From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Mar 2016 21:23:10 +0100
Subject: [PATCH 1/2] spi: sun4i: add DMA support
In-Reply-To: <CAOMqctSoA5WxtBCUK0PoHTV9OBi_fw4mdqOw+Dc_1DB_jghqng@mail.gmail.com>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-2-git-send-email-plaes@plaes.org>
 <20160226122504.GR18327@sirena.org.uk>
 <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
 <20160306214206.GW8418@lukather>
 <CAOMqctQ5aq0A95ErVVF13f_8JBy0xRw9_FZ3avbYmZUGXp=Svg@mail.gmail.com>
 <20160317072721.GJ30977@lukather>
 <CAOMqctQzMhR_bf=rMyROcTAPcrgx2EBqhH+qJL=b-U=iG9ZF4Q@mail.gmail.com>
 <20160317114308.GF2566@sirena.org.uk>
 <CAOMqctSoA5WxtBCUK0PoHTV9OBi_fw4mdqOw+Dc_1DB_jghqng@mail.gmail.com>
Message-ID: <20160318202310.GS30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2016 at 12:54:08PM +0100, Michal Suchanek wrote:
> On 17 March 2016 at 12:43, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Mar 17, 2016 at 11:58:05AM +0100, Michal Suchanek wrote:
> >> On 17 March 2016 at 08:27, Maxime Ripard
> >
> >> > You're mixing two things up: the fact that we can't do more than the
> >> > FIFO length in PIO and that we're missing DMA support. We have patches
> >> > to address both, and there's no depedency between the two.
> >
> >> The only thing is that although DMA is optional on pretty much any
> >> system you will have DMA available unless you broke your config. You
> >> really do want the DMA support when it is available. So there will be
> >> nobody testing the non-DMA part and it will be prone to bitrot.
> >
> > Well, it might be worth doing PIO for very short transfers even if you
> > have DMA - it's quite common for this to perform better.
> 
> That's what the driver does. The discussion revolves around the fact
> that the driver does not attempt to work (even for very short
> transfers) when the DMA channels are not configured and just bails
> out. AFAICT the channels are always available when the system is
> properly configured and the dmaengine driver loaded.

I guess we just don't have the same defininition of "proper".

Let's take an opposite view. Can you have SPI working now if the
DMAEngine framework is not there? Yes. Why should it change? And even
more so, why should it change silently?

> Very few device drivers would work with 63byte transfers only and the
> code for manually driving the CS line in case the DMA engine fails to
> configure will necessarily go untested most of the time since most
> systems will have DMA configured properly.

That's not true. A significant portion would work. I don't like to
make up numbers, but I guess only the EEPROMs and rather big screens
wouldn't work.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160318/ca3001f3/attachment.sig>
