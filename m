From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Tue, 27 Jan 2015 11:00:51 +0100
Subject: [PATCH 11/18] spi/xilinx: Remove rx_fn and tx_fn pointer
In-Reply-To: <20150127000903.GM21293@sirena.org.uk>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422029330-10971-12-git-send-email-ricardo.ribalda@gmail.com>
 <20150127000903.GM21293@sirena.org.uk>
Message-ID: <CAPybu_3gF1BXhq4j5Z3DfM8_PxuK72Pshm6_5qVKH-ZyYTpgig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark


> Perhaps I'm missing something here but we only seem to be incrementing
> rx_ptr for the 32 bit case here...

The unified diff is a bit confusing this time.

This is how the function looks after the patch.
All the modes are handled in a generic way.

Which I believe it is right:

static void xilinx_spi_rx(struct xilinx_spi *xspi)
{
u32 data = xspi->read_fn(xspi->regs + XSPI_RXD_OFFSET);

if (!xspi->rx_ptr)
    return;

switch (xspi->bits_per_word) {
case 8:
    *(u8 *)(xspi->rx_ptr) = data;
break;
case 16:
    *(u16 *)(xspi->rx_ptr) = data;
break;
case 32:
    *(u32 *)(xspi->rx_ptr) = data;
break;
}

xspi->rx_ptr += xspi->bits_per_word/8;
}



>
>> +     xspi->rx_ptr += xspi->bits_per_word/8;
>
> ...which looks to duplicate this which handles all cases.  Also there's
> a coding style thing - spaces around the / please.

I am fixing this on the next version. (and  xspi->tx_ptr +=
xspi->bits_per_word/8;)

I am also cc: the maintainers of checkpatch, because for whatever
reason, this was not found by the script

ricardo at neopili:~/curro/qtec/linux-upstream$ scripts/checkpatch.pl
xilinx-spi2/0011-spi-xilinx-Remove-rx_fn-and-tx_fn-pointer.patch
total: 0 errors, 0 warnings, 109 lines checked

xilinx-spi2/0011-spi-xilinx-Remove-rx_fn-and-tx_fn-pointer.patch has
no obvious style problems and is ready for submission.

Thanks!


-- 
Ricardo Ribalda
