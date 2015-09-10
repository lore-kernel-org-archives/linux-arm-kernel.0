From: jogo@openwrt.org (Jonas Gorski)
Date: Thu, 10 Sep 2015 12:28:39 +0200
Subject: [PATCH linux-next v6 4/8] mtd: spi-nor: use optimized commands
 for read/write/erase operations
In-Reply-To: <3a917bbb1408e89239255a780bf991e5511f5535.1441803609.git.cyrille.pitchen@atmel.com>
References: <cover.1441803609.git.cyrille.pitchen@atmel.com>
 <3a917bbb1408e89239255a780bf991e5511f5535.1441803609.git.cyrille.pitchen@atmel.com>
Message-ID: <CAOiHx=mBNYx-DSmbXT0W0M0qVnftu6Sp2=Qn5JhZctyOuK3g2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 9, 2015 at 3:24 PM, Cyrille Pitchen
<cyrille.pitchen@atmel.com> wrote:
> The op codes used by the spi-nor framework are now tuned depending on the
> memory manufacturer.
>
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

To be honest, I'm not sure if it's worth it using the dual/quad I/O
commands on spansion, as they have different dummy cycle requirements
than the fast/dual/quad reads.

E.g. on S25FL128S, Fast/dual/quad is fine with 8 dummy cycles up to
104 MHz, but Quad I/O needs 1 cycle for <= 50 MHz, 4 for <= 90 MHz,
and 5 for <= 104 MHz. Which means we would need a lot more logic in
there or setting it from dts, and for existing users already using
dual/quad mode this would break it. And for m25p80 it would mean to
split the cmd + address into two transfers, all to save 20~30 clock
cycles, which will likely be dwarfed by the savings of the
dual/quadness of the data.

Apart from the fact that I would assume many spi-controllers will have
problems with dummy cycles that aren't a multiple of 8, and would
therefore require bitshifting the data when reading, which will
definitely eat up any time savings from the dual/quad written address.

And for the quad program command the datasheet says it only has any
performance improvement if running@less than 12 MHz, so probably
not much to gain for most users.


Jonas
