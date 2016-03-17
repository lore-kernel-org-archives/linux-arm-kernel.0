From: hramrach@gmail.com (Michal Suchanek)
Date: Thu, 17 Mar 2016 12:54:08 +0100
Subject: [PATCH 1/2] spi: sun4i: add DMA support
In-Reply-To: <20160317114308.GF2566@sirena.org.uk>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-2-git-send-email-plaes@plaes.org>
 <20160226122504.GR18327@sirena.org.uk>
 <CAOMqctTz=szSkpk95D_dUJjjpziCKoPv=xRczjfq2Roct-K-OA@mail.gmail.com>
 <20160306214206.GW8418@lukather>
 <CAOMqctQ5aq0A95ErVVF13f_8JBy0xRw9_FZ3avbYmZUGXp=Svg@mail.gmail.com>
 <20160317072721.GJ30977@lukather>
 <CAOMqctQzMhR_bf=rMyROcTAPcrgx2EBqhH+qJL=b-U=iG9ZF4Q@mail.gmail.com>
 <20160317114308.GF2566@sirena.org.uk>
Message-ID: <CAOMqctSoA5WxtBCUK0PoHTV9OBi_fw4mdqOw+Dc_1DB_jghqng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 March 2016 at 12:43, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Mar 17, 2016 at 11:58:05AM +0100, Michal Suchanek wrote:
>> On 17 March 2016 at 08:27, Maxime Ripard
>
>> > You're mixing two things up: the fact that we can't do more than the
>> > FIFO length in PIO and that we're missing DMA support. We have patches
>> > to address both, and there's no depedency between the two.
>
>> The only thing is that although DMA is optional on pretty much any
>> system you will have DMA available unless you broke your config. You
>> really do want the DMA support when it is available. So there will be
>> nobody testing the non-DMA part and it will be prone to bitrot.
>
> Well, it might be worth doing PIO for very short transfers even if you
> have DMA - it's quite common for this to perform better.

That's what the driver does. The discussion revolves around the fact
that the driver does not attempt to work (even for very short
transfers) when the DMA channels are not configured and just bails
out. AFAICT the channels are always available when the system is
properly configured and the dmaengine driver loaded.

Very few device drivers would work with 63byte transfers only and the
code for manually driving the CS line in case the DMA engine fails to
configure will necessarily go untested most of the time since most
systems will have DMA configured properly.

Thanks

Michal
