From: jogo@openwrt.org (Jonas Gorski)
Date: Thu, 10 Sep 2015 12:36:26 +0200
Subject: [PATCH linux-next v6 0/8] add driver for Atmel QSPI controller
In-Reply-To: <cover.1441803609.git.cyrille.pitchen@atmel.com>
References: <cover.1441803609.git.cyrille.pitchen@atmel.com>
Message-ID: <CAOiHx=khSdd-Ro8xJ11X+hijMWjyiryfYJtJOoMoK_CrZ_m39A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 9, 2015 at 3:24 PM, Cyrille Pitchen
<cyrille.pitchen@atmel.com> wrote:
> This series of patches add support for the new Atmel QSPI controller
> embedded inside sama5d2x SoCs.
>
> These patches were first developped for linux-3.18-at91 and tested on a
> sama5d27 Xplained ultra board, which embeds a Micron n25q128a13 QSPI NOR
> flash memory. Then the series was adapted for mainline.

All in all, this looks a lot better now compared to the previous
version. What I'm still missing is some definsive programming to
ensure we don't break existing users, or update the current users to
not break. The issues I currently see are

1) We don't check if a spi-nor controller actually supports a certain
protocol, just if SPI_NOR_DUAL/_QUAD is set
2) We currently set these new protocols, but none of the current
spi-nor controller drivers are aware of the protocols, which has the
possiblity of silently breaking things (or not, since they will then
fail to read correct data)
3) m25p80 currently uses SPI_RX_DUAL -> SPI_NOR_DUAL, but does not
check SPI_TX_DUAL (which is required for any of the != 1_1_x
commands). Although this is more an academical concern, as currently
all spi controller drivers seem to support _RX_ and _TX_, never only
one direction.


Jonas
