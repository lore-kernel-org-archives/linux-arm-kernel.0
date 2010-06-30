From: lamiaposta71@gmail.com (Raffaele Recalcati)
Date: Wed, 30 Jun 2010 10:52:30 +0200
Subject: [PATCH] ASoC: DaVinci: Added support for cpu clocking I2S
In-Reply-To: <4C28F3D1.5060806@boundarydevices.com>
References: <1277707487-3371-1-git-send-email-lamiaposta71@gmail.com>
	<4C28F3D1.5060806@boundarydevices.com>
Message-ID: <AANLkTikhqZRWYoNnZ2PSnVVpV0rUqQQyRxfz99a25EMU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/28 Troy Kisky <troy.kisky@boundarydevices.com>

> Raffaele Recalcati wrote:
> > +             if (dev->i2s_fast_clock) {
> > +                     clk_div = 256;
> can you have
>   f = (freq / params->rate_num) * params->rate_den;
> > +                     do {
> > +                             framesize = (freq / (--clk_div)) /
> > +                                         params->rate_num *
> > +                                         params->rate_den;
> and
>                                framesize = f / (--clk_div);
> > +                     } while (((framesize < 33) || (framesize > 4095))
> &&
> > +                              (clk_div));
> > +                     clk_div--;
> looks like clk_div can go negative here, should the above while say
> (clk_div > 1)
>

> +                     } while (((framesize < 33) || (framesize > 4095)) &&
> +                              (clk_div));

only if clk_div not null stay inside the while.

> +                     clk_div--;

and here can at minumum be 0, not negative.



> > +                     srgr |= DAVINCI_MCBSP_SRGR_FPER(framesize - 1);
> > +             } else {
> > +                     /* symmetric waveforms */
> > +                     clk_div = freq / (mcbsp_word_length * 16) /
> > +                               params->rate_num * params->rate_den;
> > +                     srgr |= DAVINCI_MCBSP_SRGR_FPER(mcbsp_word_length *
> > +                                                     16 - 1);
> > +             }
> > +             clk_div &= 0xFF;
> > +             srgr |= clk_div;
>


so, dividing for (CLKGDV + 1) it is ok.

Raffaele
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100630/574baf13/attachment.html>
