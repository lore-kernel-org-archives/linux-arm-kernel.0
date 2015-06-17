From: dianders@chromium.org (Doug Anderson)
Date: Wed, 17 Jun 2015 10:01:48 -0700
Subject: [PATCH] ARM: dts: rockchip: Add dmac_bus rx and tx for uart2
In-Reply-To: <34159914.9nlETdacuk@phil>
References: <1434390468-27296-1-git-send-email-romain.perier@gmail.com>
 <34159914.9nlETdacuk@phil>
Message-ID: <CAD=FV=UdrE1PCnfHiYKDm985joX4OLLYemhqm+niPUgYQO4s3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 16, 2015 at 4:37 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> Just for the record and if anybody is interested to work in this, we have an
> issue with the dma implementation [0] that is not yet solved upstream. From
> what I've remember, that mostly got triggered on higher speeds, like higher
> spi-speeds or i2s audio stuff (poping).
>
>
> Heiko
>
> [0]
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/93c3b192dca7e8c773c4d28873114c325382b63e%5E%21/#F0

Right.  In the ChromeOS tree (used for rk3288-based Chromebooks) we
think we solved the DMA issues for the most part by using burst mode.
...but we weren't brave enough to enable DMA for SPI and UART because
we didn't want to track down any additional weird issues and PIO mode
was working well enough.


The full list of things I see in the PL330 driver in ChromeOS:

3e12510 CHROMIUM: dmaengine: pl330: add quirk for broken no flushp
ded3780 CHROMIUM: dmaengine: pl330: support quirks for some broken
7af450f FROMLIST: DMA: pl330: support burst mode for dev-to-mem and
mem-to-dev transmit

Skimming through the i2s driver (which we definitely use with DMA):

21fee4b CHROMIUM: ASoC: rockchip_i2s: modify DMA max burst to 1
4001251 UPSTREAM: ASoC: rockchip: i2s: fix maxburst of dma data to 4

...I was only peripherally involved here, but as you can see it looks
like there were not only changes needed to the PL330 driver but also
changes needed to the DMA client.

You can find links to patches from the same git tree that Heiko pointed at.
