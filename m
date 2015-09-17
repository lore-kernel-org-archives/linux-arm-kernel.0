From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Sep 2015 18:37:56 +0100
Subject: [linux-sunxi] Re: [PATCH 2/2] ASoC: sunxi: add support for the
 on-chip codec on early Allwinner SoCs
In-Reply-To: <CAGb2v67D30+_itOAyWqGzychxeM_d7rF6TTu1_WBYuFPfFEk1g@mail.gmail.com>
References: <1442064384-23379-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442064384-23379-3-git-send-email-maxime.ripard@free-electrons.com>
 <20150916191612.GM12027@sirena.org.uk>
 <20150917133135.GE4684@lukather>
 <CAGb2v67D30+_itOAyWqGzychxeM_d7rF6TTu1_WBYuFPfFEk1g@mail.gmail.com>
Message-ID: <20150917173756.GE12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 11:10:41PM +0800, Chen-Yu Tsai wrote:
> On Thu, Sep 17, 2015 at 9:31 PM, Maxime Ripard

> >> > +           .formats        = SNDRV_PCM_FMTBIT_S16_LE |
> >> > +                             SNDRV_PCM_FMTBIT_S32_LE,
> >> > +           .sig_bits       = 24,

> >> So presumably also S24_LE (ie, 24 bits packed into a 32 bit word)?

> > Hmm, probably yes, I'll test that.

> IIRC when Emilio first wrote the driver, we tried 24 bit and no sound
> came out. Turns out it's an alignment issue. The codec's FIFO register
> is 32 bits wide, and takes the higher 24 bits as input when set to 24
> bit mode. The internal FIFO is only 24 bits wide. A20 user manual P174
> describes how the bits are copied.

> So for 24 bit audio, you would actually send it 32 bit audio samples,
> and let it truncate or drop the least significant 8 bits. This is why
> we have SNDRV_PCM_FMTBIT_S32_LE with .sig_bits = 24.

> I don't know if this is just a workaround, but a few other drivers do
> this as well, for example twl3040 and omap-mcpdm.

That's very common - it's essentially what S24_LE mode is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150917/6e2bd475/attachment.sig>
