From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 24 Aug 2010 08:58:43 +0200
Subject: [PATCH 3/3 v2] dmaengine: Add Freescale i.MX SDMA support
In-Reply-To: <AANLkTinYkXwKZwin8fsiepvJh=s47uti2+2gC8r3OEOk@mail.gmail.com>
References: <1281956870-12463-1-git-send-email-s.hauer@pengutronix.de>
	<1281956870-12463-4-git-send-email-s.hauer@pengutronix.de>
	<20100823125704.GU27749@pengutronix.de>
	<AANLkTinYkXwKZwin8fsiepvJh=s47uti2+2gC8r3OEOk@mail.gmail.com>
Message-ID: <20100824065843.GY27749@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 23, 2010 at 07:30:34PM +0200, Linus Walleij wrote:
> 2010/8/23 Sascha Hauer <s.hauer@pengutronix.de>:
> 
> > This patch adds support for the Freescale i.MX SDMA engine.
> 
> Great progress!
> 
> > (...)
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > (...)
> > +/* SDMA registers */
> > +#define SDMA_H_C0PTR ? ? ? ? ? (sdma->regs + 0x000)
> > +#define SDMA_H_INTR ? ? ? ? ? ?(sdma->regs + 0x004)
> > +#define SDMA_H_STATSTOP ? ? ? ? ? ? ? ?(sdma->regs + 0x008)
> > +#define SDMA_H_START ? ? ? ? ? (sdma->regs + 0x00c)
> > +#define SDMA_H_EVTOVR ? ? ? ? ?(sdma->regs + 0x010)
> > +#define SDMA_H_DSPOVR ? ? ? ? ?(sdma->regs + 0x014)
> > +#define SDMA_H_HOSTOVR ? ? ? ? (sdma->regs + 0x018)
> > +#define SDMA_H_EVTPEND ? ? ? ? (sdma->regs + 0x01c)
> > +#define SDMA_H_DSPENBL ? ? ? ? (sdma->regs + 0x020)
> > +#define SDMA_H_RESET ? ? ? ? ? (sdma->regs + 0x024)
> > +#define SDMA_H_EVTERR ? ? ? ? ?(sdma->regs + 0x028)
> > +#define SDMA_H_INTRMSK ? ? ? ? (sdma->regs + 0x02c)
> > +#define SDMA_H_PSW ? ? ? ? ? ? (sdma->regs + 0x030)
> > +#define SDMA_H_EVTERRDBG ? ? ? (sdma->regs + 0x034)
> > +#define SDMA_H_CONFIG ? ? ? ? ?(sdma->regs + 0x038)
> > +#define SDMA_ONCE_ENB ? ? ? ? ?(sdma->regs + 0x040)
> > +#define SDMA_ONCE_DATA ? ? ? ? (sdma->regs + 0x044)
> > +#define SDMA_ONCE_INSTR ? ? ? ? ? ? ? ?(sdma->regs + 0x048)
> > +#define SDMA_ONCE_STAT ? ? ? ? (sdma->regs + 0x04c)
> > +#define SDMA_ONCE_CMD ? ? ? ? ?(sdma->regs + 0x050)
> > +#define SDMA_EVT_MIRROR ? ? ? ? ? ? ? ?(sdma->regs + 0x054)
> > +#define SDMA_ILLINSTADDR ? ? ? (sdma->regs + 0x058)
> > +#define SDMA_CHN0ADDR ? ? ? ? ?(sdma->regs + 0x05c)
> > +#define SDMA_ONCE_RTB ? ? ? ? ?(sdma->regs + 0x060)
> > +#define SDMA_XTRIG_CONF1 ? ? ? (sdma->regs + 0x070)
> > +#define SDMA_XTRIG_CONF2 ? ? ? (sdma->regs + 0x074)
> > +#define SDMA_CHNENBL_0 ? ? ? ? (sdma->regs + (sdma->version == 2 ? 0x200 : 0x80))
> > +#define SDMA_CHNPRI_0 ? ? ? ? ?(sdma->regs + 0x100)
> 
> These macros expand to the local variable "sdma" which must
> be present in all functions using them. I don't know what is
> considered moste readable, but I would certainly just
> 
> #define SDMA_FOO (0x0123)
> (...)
> u32 foo = readl(sdma->regs + SDMA_FOO);
> 
> That is more common I think.
> > +
> > +/*
> > + * This enumerates transfer types
> > + */
> > +enum {
> > + ? ? ? emi_2_per = 0, ? ? ? ? ?/* EMI memory to peripheral */
> > + ? ? ? emi_2_int, ? ? ? ? ? ? ?/* EMI memory to internal RAM */
> > + ? ? ? emi_2_emi, ? ? ? ? ? ? ?/* EMI memory to EMI memory */
> > + ? ? ? emi_2_dsp, ? ? ? ? ? ? ?/* EMI memory to DSP memory */
> > + ? ? ? per_2_int, ? ? ? ? ? ? ?/* Peripheral to internal RAM */
> > + ? ? ? per_2_emi, ? ? ? ? ? ? ?/* Peripheral to internal EMI memory */
> > + ? ? ? per_2_dsp, ? ? ? ? ? ? ?/* Peripheral to DSP memory */
> > + ? ? ? per_2_per, ? ? ? ? ? ? ?/* Peripheral to Peripheral */
> > + ? ? ? int_2_per, ? ? ? ? ? ? ?/* Internal RAM to peripheral */
> > + ? ? ? int_2_int, ? ? ? ? ? ? ?/* Internal RAM to Internal RAM */
> > + ? ? ? int_2_emi, ? ? ? ? ? ? ?/* Internal RAM to EMI memory */
> > + ? ? ? int_2_dsp, ? ? ? ? ? ? ?/* Internal RAM to DSP memory */
> > + ? ? ? dsp_2_per, ? ? ? ? ? ? ?/* DSP memory to peripheral */
> > + ? ? ? dsp_2_int, ? ? ? ? ? ? ?/* DSP memory to internal RAM */
> > + ? ? ? dsp_2_emi, ? ? ? ? ? ? ?/* DSP memory to EMI memory */
> > + ? ? ? dsp_2_dsp, ? ? ? ? ? ? ?/* DSP memory to DSP memory */
> > + ? ? ? emi_2_dsp_loop, ? ? ? ? /* EMI memory to DSP memory loopback */
> > + ? ? ? dsp_2_emi_loop, ? ? ? ? /* DSP memory to EMI memory loopback */
> > + ? ? ? dvfs_pll, ? ? ? ? ? ? ? /* DVFS script with PLL change ? ? ? */
> > + ? ? ? dvfs_pdr ? ? ? ? ? ? ? ?/* DVFS script without PLL change ? ?*/
> > +} sdma_transfer_type;
> 
> Picky me, but it's no type, its an enum. I understand that it is
> a technical term...
> 
> What about just calling is sdma_transfer? Short and nice.
> Or sdma_transfer_line?

This turned out to be unused anyway, so the simple fix was to remove it.

> 
> > (...)
> > +/*
> > + * Stores the start address of the SDMA scripts
> > + */
> > +static struct sdma_script_start_addrs __sdma_script_addrs;
> > +static struct sdma_script_start_addrs *sdma_script_addrs = &__sdma_script_addrs;
> 
> What's the rationale behind prefixing that variable with __?
> 
> The same name for struct and variable is perfectly viable.

The rationale was to statically allocate a struct
sdma_script_start_addrs and create a pointer to it so that I don't have
to use &__sdma_script_addrs in the code.

I forgot this one while converting the driver to multi instance, so this
is now part of struct sdma_engine.

Fixed the other stuff aswell, I will send an update shortly.

Regards,
  Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
