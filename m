From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Sep 2011 10:01:16 +0200
Subject: [PATCH V2 1/1] dmaengine/amba-pl08x: Add support for s3c64xx DMAC
In-Reply-To: <1317189007-23033-2-git-send-email-alim.akhtar@samsung.com>
References: <1317189007-23033-1-git-send-email-alim.akhtar@samsung.com>
	<1317189007-23033-2-git-send-email-alim.akhtar@samsung.com>
Message-ID: <CACRpkdZesKGuPGmUifLj4puN_e=kYAb4WyuQs+xERn9q7036rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry if I missed a few nitpicks last time, anyway it's looking much better now:

On Wed, Sep 28, 2011 at 7:50 AM, Alim Akhtar <alim.akhtar@samsung.com> wrote:
> + ? ? ? /*
> + ? ? ? ?* Samsung pl080 DMAC has one exrta control register

s/exrta/exstra

> + ? ? ? if (pl08x->vd->is_pl080_s3c) {
> + ? ? ? ? ? ? ? writel(txd->ccfg, phychan->base + PL080S_CH_CONFIG);
> + ? ? ? ? ? ? ? writel(lli->cctl1, phychan->base + PL080S_CH_CONTROL2);
> + ? ? ? } else
> + ? ? ? ? ? ? ? writel(txd->ccfg, phychan->base + PL080_CH_CONFIG);

What do you think about adding a field to the struct pl08x
like

u32 config_reg

that we set to the proper config register (PL080S_CH_CONFIG or
PL080_CH_CONFIG in probe(), so the above
becomes the simpler variant:

writel(txd->ccfg, phychan->base + pl08x->config_reg);
if (pl08x->vd->is_pl080_s3c)
    writel(lli->cctl1, phychan->base + PL080S_CH_CONTROL2);

> + ? ? ? if (pl08x->vd->is_pl080_s3c) {
> + ? ? ? ? ? ? ? val = readl(phychan->base + PL080S_CH_CONFIG);
> + ? ? ? ? ? ? ? while ((val & PL080_CONFIG_ACTIVE) ||
> + ? ? ? ? ? ? ? ? ? ? ? (val & PL080_CONFIG_ENABLE))
> + ? ? ? ? ? ? ? ? ? ? ? val = readl(phychan->base + PL080S_CH_CONFIG);
> +
> + ? ? ? ? ? ? ? writel(val | PL080_CONFIG_ENABLE,
> + ? ? ? ? ? ? ? ? ? ? ? phychan->base + PL080S_CH_CONFIG);
> + ? ? ? } else {
> ? ? ? ? ? ? ? ?val = readl(phychan->base + PL080_CH_CONFIG);
> + ? ? ? ? ? ? ? ? ? ? ? while ((val & PL080_CONFIG_ACTIVE) ||
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? (val & PL080_CONFIG_ENABLE))
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? val = readl(phychan->base + PL080_CH_CONFIG);
>
> - ? ? ? writel(val | PL080_CONFIG_ENABLE, phychan->base + PL080_CH_CONFIG);
> + ? ? ? ? ? ? ? writel(val | PL080_CONFIG_ENABLE,
> + ? ? ? ? ? ? ? ? ? ? ? phychan->base + PL080_CH_CONFIG);
> + ? ? ? }

This would also become much simpler with that approach I think...

> ? ? ? ?/* Set the HALT bit and wait for the FIFO to drain */
> - ? ? ? val = readl(ch->base + PL080_CH_CONFIG);
> - ? ? ? val |= PL080_CONFIG_HALT;
> - ? ? ? writel(val, ch->base + PL080_CH_CONFIG);
> -
> + ? ? ? if (pl08x->vd->is_pl080_s3c) {
> + ? ? ? ? ? ? ? val = readl(ch->base + PL080S_CH_CONFIG);
> + ? ? ? ? ? ? ? val |= PL080_CONFIG_HALT;
> + ? ? ? ? ? ? ? writel(val, ch->base + PL080S_CH_CONFIG);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? val = readl(ch->base + PL080_CH_CONFIG);
> + ? ? ? ? ? ? ? val |= PL080_CONFIG_HALT;
> + ? ? ? ? ? ? ? writel(val, ch->base + PL080_CH_CONFIG);
> + ? ? ? }

This would become simply:

val = readl(ch->base + pl08x->config_reg);
val |= PL080_CONFIG_HALT;
writel(val, ch->base + pl08x->config_reg);


> ? ? ? ?/* Clear the HALT bit */
> - ? ? ? val = readl(ch->base + PL080_CH_CONFIG);
> - ? ? ? val &= ~PL080_CONFIG_HALT;
> - ? ? ? writel(val, ch->base + PL080_CH_CONFIG);
> + ? ? ? if (pl08x->vd->is_pl080_s3c) {
> + ? ? ? ? ? ? ? val = readl(ch->base + PL080S_CH_CONFIG);
> + ? ? ? ? ? ? ? val &= ~PL080_CONFIG_HALT;
> + ? ? ? ? ? ? ? writel(val, ch->base + PL080S_CH_CONFIG);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? val = readl(ch->base + PL080_CH_CONFIG);
> + ? ? ? ? ? ? ? val &= ~PL080_CONFIG_HALT;
> + ? ? ? ? ? ? ? writel(val, ch->base + PL080_CH_CONFIG);
> + ? ? ? }

This would get rid of the if/else clauses

> + ? ? ? if (pl08x->vd->is_pl080_s3c) {
> + ? ? ? ? ? ? ? u32 val = readl(ch->base + PL080S_CH_CONFIG);
> + ? ? ? ? ? ? ? val &= ~(PL080_CONFIG_ENABLE | PL080_CONFIG_ERR_IRQ_MASK |
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? PL080_CONFIG_TC_IRQ_MASK);
> + ? ? ? ? ? ? ? writel(val, ch->base + PL080S_CH_CONFIG);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? u32 val = readl(ch->base + PL080_CH_CONFIG);
> + ? ? ? ? ? ? ? val &= ~(PL080_CONFIG_ENABLE | PL080_CONFIG_ERR_IRQ_MASK |
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? PL080_CONFIG_TC_IRQ_MASK);
> + ? ? ? ? ? ? ? writel(val, ch->base + PL080_CH_CONFIG);
> + ? ? ? }

As would this...

> + ? ? ? /* Samsung DMAC is PL080 variant*/
> + ? ? ? {
> + ? ? ? ? ? ? ? .id ? ? = 0x00041082,
> + ? ? ? ? ? ? ? .mask ? = 0x000fffff,
> + ? ? ? ? ? ? ? .data ? = &vendor_pl080_s3c,

Does the hardware realy have this primecell number or is it something that is
hardcoded from the board/device tree?

If it is hardcoded then no objections.

In the latter case, replace 0x41 (= 'A', ARM) with something like
0x55 'U' for Samsung or so. Or 0x51 'S'. Or whatever you like.

Then add that to include/linux/amba/bus.h as
AMBA_VENDOR_SAMSUNG = 0x55,
so we have this under some kind of control.

Yours,
Linus Walleij
