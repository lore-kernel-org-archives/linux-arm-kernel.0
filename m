From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 27 Jan 2018 17:14:26 +0100
Subject: [PATCH v6 2/2] media: V3s: Add support for Allwinner CSI.
In-Reply-To: <1516695531-23349-1-git-send-email-yong.deng@magewell.com>
References: <1516695531-23349-1-git-send-email-yong.deng@magewell.com>
Message-ID: <CACRpkdan52UB7HOyH1gnHWg4CDke_VQxAdq8cBgwUroibE59Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 9:18 AM, Yong Deng <yong.deng@magewell.com> wrote:

> Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> interface and CSI1 is used for parallel interface. This is not
> documented in datasheet but by test and guess.
>
> This patch implement a v4l2 framework driver for it.
>
> Currently, the driver only support the parallel interface. MIPI-CSI2,
> ISP's support are not included in this patch.
>
> Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Yong Deng <yong.deng@magewell.com>

This is cool stuff :)

> +void sun6i_csi_update_buf_addr(struct sun6i_csi *csi, dma_addr_t addr)
> +{
> +       struct sun6i_csi_dev *sdev = sun6i_csi_to_dev(csi);
> +       /* transform physical address to bus address */
> +       dma_addr_t bus_addr = addr - PHYS_OFFSET;

I am sorry if this is an unjustified drive-by comment. Maybe you
have already investigate other ways to do this.

Accessing PHYS_OFFSET directly seems unintuitive
and not good practice.

But normally an dma_addr_t only comes from some
function inside <linux/dma-mapping.h> such as:
dma_alloc_coherent() for a contigous buffer which is coherent
in physical memory, or from some buffer <= 64KB that
is switching ownership between device and CPU explicitly
with dma_map* or so. Did you check with
Documentation/DMA-API.txt?

Yours,
Linus Walleij
