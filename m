From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 30 Oct 2016 07:16:26 +0100
Subject: [PATCH 01/14] dma: sun6i-dma: Add burst case of 4
In-Reply-To: <CAGb2v67SSZF6XL-HXv83nuwTKpJc53h8gsrb2r2V98LNZBzqEA@mail.gmail.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <3a2404510b5f8b16ae3bb193982d70f158700b2b.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004124011.d7f5754a082d5f17d5185fc4@free.fr>
 <20161004165553.GS5228@lukather>
 <20161023183107.5b75b6aad62853378713299f@free.fr>
 <20161027175154.v4kuhyvm3r5n6tdo@lukather>
 <CAGb2v67SSZF6XL-HXv83nuwTKpJc53h8gsrb2r2V98LNZBzqEA@mail.gmail.com>
Message-ID: <20161030071626.8d67fd9febfd355620a58c4d@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 30 Oct 2016 10:06:20 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> >> Yes, I know that the burst size is always a power of 2.
> >> The best way to check it would be to change the {src,dts}_maxburst to a
> >> bitmap of the possible bursts as 0x0d for 1,4 and 8 bytes. But this
> >> asks for a lot of changes...
> >
> > To be honest, I'm not really a big fan of those tree wide changes
> > without any way to maintain compatibility. It ends up in a single,
> > huge patch if we want to maintain bisectability that just isn't
> > reviewable.
> 
> Looking at the dmaengine API, I believe we got it wrong.
> 
> max_burst in dma_slave_config denotes the largest amount of data
> a single transfer should be, as described in dmaengine.h:
> 
>  * @src_maxburst: the maximum number of words (note: words, as in
>  * units of the src_addr_width member, not bytes) that can be sent
>  * in one burst to the device. Typically something like half the
>  * FIFO depth on I/O peripherals so you don't overflow it. This
>  * may or may not be applicable on memory sources.
>  * @dst_maxburst: same as src_maxburst but for destination target
>  * mutatis mutandis.
> 
> The DMA engine driver should be free to select whatever burst size
> that doesn't exceed this. So for max_burst = 4, the driver can select
> burst = 4 for controllers that do support it, or burst = 1 for those
> that don't, and do more bursts.
> 
> This also means we can increase max_burst for the audio codec, as
> the FIFO is 64 samples deep for stereo, or 128 samples for mono.
> 
> 
> If we agree on the above I can send some patches for this.

That's fine to me, but this does not solve the main problem which is
how/where are defined the possible bursts of a SoC.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
