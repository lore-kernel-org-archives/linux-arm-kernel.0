From: jbe@pengutronix.de (Juergen Beisert)
Date: Thu, 6 Sep 2012 10:56:12 +0200
Subject: [PATCH 1/1] mxc_nand : allow swapping the Bad block Indicator for
 NFC v1.
In-Reply-To: <1345825064-9147-1-git-send-email-gcembed@gmail.com>
References: <1345811288.2848.308.camel@sauron.fi.intel.com>
 <1345825064-9147-1-git-send-email-gcembed@gmail.com>
Message-ID: <201209061056.12386.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ga?tan,

Ga?tan Carlier wrote:
> Any comments for this patch ?

Sorry, a little bit late.

> Swap the BI-byte on position 0x7D0 with a data byte at 0x835.  To fix a bug
> in Freescale imx NFC v1 SoC's for 2K page NAND flashes: imx27 and imx31.
> Warning: The same solution needs to be applied to the boot loader and the
> flash programmer.

What sense does it make to swap the bytes at offset 0x7D0 and 0x835?

Background: the NFC in the i.MX27/i.MX31 (NFCv1) and i.MX25/i.MX35 (NFCv2) can 
only handle 512 byte pages with 16 bit OOB at once. To get them work with 2 k 
page NANDs they only do the 512 + 16 step four times. The result is, a 2 k 
page NAND is not handled as 2 k data and 64 bytes OOB, its handled instead as
a stream of 2112 bytes:

               |<-------- 2112 bytes --------->|
               512+16 | 512+16 | 512+16 | 512+16

Which means the NFC mixes data and OOB/checksums into its internal SRAM. But 
all upper routines still use this SRAM content with a 2048 (data) + 64 (OOB) 
bytes layout (to be more precise also the NFC hardware uses this layout). 
Result is, the factory bad block markers are lost, because the NFC stores the 
first 48 bytes from each OOB into the SRAM's data area (beginning with offset 
2000 (= 0x7D0) in the data area).

So, the main goal of this swap patch should be to keep the factory bad block 
markers _and_ to make use of them.

But the i.MX driver does not register its own bad block pattern description, 
so the default one is used with the BBM at position NAND_LARGE_BADBLOCK_POS 
(which means offset 0 in the OOB area).

So, I think, all upper layers still search for the BBM at offset 0 of the OOB 
area, which results to SRAM's offset 0x800 (for NFCv1) and not 0x835. This 
means this patch keeps the factory bad block markers, but they won't still be 
used as expected.

IMHO the bytes at SRAM's offset 0x7D0 and 0x800 for the NFCv1 must be swapped 
(and 0x7D0 and 0x1000 for the NFCv2) to keep the factory bad block markers 
_and_ to make use of them. Or am I wrong?

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
