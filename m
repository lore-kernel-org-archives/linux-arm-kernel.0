From: ivo.clarysse@gmail.com (Ivo Clarysse)
Date: Fri, 25 Jun 2010 16:50:45 +0200
Subject: [PATCHv3 4/5] mtd: mxc_nand fixups
In-Reply-To: <807hloag6w.fsf@merkur.tec.linutronix.de>
References: <20100618205401.GA12115@pengutronix.de>
	<80sk4ivkga.fsf@merkur.tec.linutronix.de>
	<AANLkTimA7Rbm_nHpVYpEPqaPCjrOse9s8YyiInWlhfEK@mail.gmail.com>
	<80tyoyhxey.fsf_-_@merkur.tec.linutronix.de>
	<AANLkTikRj_dMkKLyFhW78yld9jIYAIFncfPaPAF8WqUY@mail.gmail.com>
	<80iq5bqd07.fsf_-_@merkur.tec.linutronix.de>
	<AANLkTimJKNEwOoKldq4a4_ufxNY6IY7r6tAfAM055hlW@mail.gmail.com>
	<80vd9ab0d2.fsf@merkur.tec.linutronix.de>
	<AANLkTinVaXjCneg-XpxB7YNlmGOwQFTnm5RUcetPdToI@mail.gmail.com>
	<80lja6awlb.fsf@merkur.tec.linutronix.de>
	<20100624072732.GQ12115@pengutronix.de>
	<807hloag6w.fsf@merkur.tec.linutronix.de>
Message-ID: <AANLkTilTbvlPxRhioMiKrBUNggcxZeboi1YpB8Y9Bdpm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 24, 2010 at 12:16 PM, John Ogness <john.ogness@linutronix.de> wrote:
> On 2010-06-24, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> Ok, if it's the only way out to have 5 cpu_is_* blocks, then lets go
>> for it.
>
> Here is a new patch that puts the behavior behind a "nfc_avoid_masking"
> macro. The macro is only used 3 times.
[...]

Tested on an MX21ADS board, and it still works.

> This patch is based on linux-next 20100618.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
> ?drivers/mtd/nand/mxc_nand.c | ? 81 +++++++++++++++++++++++++---------
> ?1 file changed, 61 insertions(+), 20 deletions(-)
>
> Index: linux-next-20100618/drivers/mtd/nand/mxc_nand.c
> ===================================================================
> --- linux-next-20100618.orig/drivers/mtd/nand/mxc_nand.c
> +++ linux-next-20100618/drivers/mtd/nand/mxc_nand.c
[...]
> @@ -100,6 +109,18 @@
>
> ?#define NFC_RSLTSPARE_AREA_MASK ?0xff
>
> +#define nfc_interrupt_set(_regs) \
> + ? ? ? ? ? ? ? (readw(_regs + NFC_CONFIG2) & NFC_INT)
> +#define nfc_clear_interrupt(_regs) \
> + ? ? ? ? ? ? ? writew(readw(_regs + NFC_CONFIG2) & ~NFC_INT, \
> + ? ? ? ? ? ? ? ? ? ? ?_regs + NFC_CONFIG2)

Naming is not very consistent; I'd suggest nfc_set_interrupt /
nfc_clear_interrupt

> +#define nfc_mask_irq(_regs) \
> + ? ? ? ? ? ? ? writew(readw(_regs + NFC_CONFIG1) | NFC_INT_MSK, \
> + ? ? ? ? ? ? ? ? ? ? ?_regs + NFC_CONFIG1)
> +#define nfc_unmask_irq(_regs) \
> + ? ? ? ? ? ? ? writew(readw(_regs + NFC_CONFIG1) & ~NFC_INT_MSK, \
> + ? ? ? ? ? ? ? ? ? ? ?_regs + NFC_CONFIG1)
> +
[...]
