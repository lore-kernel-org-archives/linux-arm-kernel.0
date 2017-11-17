From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 17 Nov 2017 15:32:09 +0100
Subject: Again about regression introduced by commit 70d435ba1cd6
 ("ASoC: imx-pcm-dma: simplify pcm_config")
In-Reply-To: <CAFuYjm4vdToNBsurLrDUruwnUTJGpj0qH_1b9+0g9jEmqtkbUg@mail.gmail.com>
References: <CAFuYjm4vdToNBsurLrDUruwnUTJGpj0qH_1b9+0g9jEmqtkbUg@mail.gmail.com>
Message-ID: <1510929129.8104.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kalle,

Am Freitag, den 17.11.2017, 16:27 +0200 schrieb Kalle Kankare:
> Hi,
> 
> The regression was previously discussed on this mailing list last
> month (2017-10-04).
> 
> As in the previous discussion, this commit restricts the supported
> sound formats to S24_LE. This problem is experienced in our iMX6q
> based hardware with SGTL5000 sound chip. I.e.:
> 
> # arecord -l | grep 'card 0' -A2
> card 0: imx6qba16sgtl50 [imx6q-ba16-sgtl5000], device 0: HiFi
> sgtl5000-0 []
> ? Subdevices: 1/1
> ? Subdevice #0: subdevice #0
> 
> In kernel 4.11.0:
> 
> # arecord --dump-hw-params -D hw:0,0 2>&1 | grep '^FORMAT'
> FORMAT:? S16_LE
> 
> And in now in kernel 4.13.3:
> 
> # arecord --dump-hw-params -D hw:0,0 2>&1 | grep '^FORMAT'
> FORMAT:? S24_LE
> 
> By reverting the mentioned commit 70d435ba1cd6, the format returned
> to S16_LE. However, I'm unsure if that is the proper way to solve
> this issue. I.e. does reverting the mentioned commit cause some other
> unwanted effect ?
> 
> What would be the best solution that would make the S16_LE format
> supported again for SGTL5000 ?

Please cherry-pick f9d4a398f121 (dmaengine: imx-sdma: Correct
src_addr_widths and directions) from current Linus mainline tree.

Regards,
Lucas
