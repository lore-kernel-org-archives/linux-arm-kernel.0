From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 30 Oct 2015 11:15:18 -0700
Subject: [PATCH v5 2/3] mtd: mtk-nor: mtk serial flash controller driver
In-Reply-To: <1445866839-31063-3-git-send-email-bayi.cheng@mediatek.com>
References: <1445866839-31063-1-git-send-email-bayi.cheng@mediatek.com>
 <1445866839-31063-3-git-send-email-bayi.cheng@mediatek.com>
Message-ID: <20151030181518.GG13239@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bayi,

In reviewing your updated instructions on how to read 6 bytes of ID, I
have one more question about how the PRGDATA and SHREG registers are
supposed to work.

On Mon, Oct 26, 2015 at 09:40:38PM +0800, Bayi Cheng wrote:
[...]
> +static void mt8173_nor_set_read_mode(struct mt8173_nor *mt8173_nor)
> +{
> +	struct spi_nor *nor = &mt8173_nor->nor;
> +
> +	writeb(nor->read_opcode, mt8173_nor->base + MTK_NOR_PRGDATA3_REG);

So far, I've generalized your code to say that except for a few commands
that are treated specially by your controller, all other opcodes are
queued up in the program/shift register this:

(1) total number of bits to send/receive goes in the COUNT register (so
    far, as many as 7*8=56?)
(2) opcode is written to PRGDATA5
(3) other "transmit" data (like addresses), if any, are placed on PRGDATA4..0
(4) command is sent (execute_cmd())
(5) data is read back in SHREG{X..0}, if needed

However, I see that

(a) here in mt8173_nor_set_read_mode(), you use only PRGDATA3 (i.e.,
this is different than step (2) above). Why is that different? Is this
just a quirk of the read mode, which is different than the other
arbitrary opcodes (like READ ID)?

(b) it's really unclear how to determine 'X' in step (5). It seems like
it might just be the number of bytes minus 1, since the first byte
aligns with the "opcode" cycle. But I'm not really sure, since in one
case (the 'default' in mt8173_nor_read_reg()) you seemingly randomly
chose to read *only* from SHREG2. That looks wrong to me, but I don't
actually know, because your SoC is very unclear.

My patch at the end of this [1] tries to encapsulate (1)-(5) as best as
I could, but it's really missing out on the answer to (b).

Anyway, I'd really appreciate a good answer to these questions. We
really need to get this stuff right, so your driver can handle NOR flash
opcodes as generically as possible. Right now, your driver mostly looks
like a series of cobbled together switch/case statements to handle the
couple of opcodes you've tested.

Regard,
Brian

[1] http://lists.infradead.org/pipermail/linux-mtd/2015-October/062919.html

> +	switch (nor->flash_read) {
> +	case SPI_NOR_FAST:
> +		writeb(MTK_NOR_FAST_READ, mt8173_nor->base +
> +		       MTK_NOR_CFG1_REG);
> +		break;
> +	case SPI_NOR_DUAL:
> +		writeb(MTK_NOR_DUAL_READ_EN, mt8173_nor->base +
> +		       MTK_NOR_DUAL_REG);
> +		break;
> +	case SPI_NOR_QUAD:
> +		writeb(MTK_NOR_QUAD_READ_EN, mt8173_nor->base +
> +		       MTK_NOR_DUAL_REG);
> +		break;
> +	default:
> +		writeb(MTK_NOR_DUAL_DISABLE, mt8173_nor->base +
> +		       MTK_NOR_DUAL_REG);
> +		break;
> +	}
> +}
