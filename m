From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 8 May 2017 22:26:49 +0200
Subject: [PATCH 1/4] ata: Add DT bindings for Faraday Technology FTIDE010
In-Reply-To: <1678111.DmiVNKW3dQ@amdc3058>
References: <CGME20170506121118epcas2p1b2a2d1a8005a37582a73c0e7be4b1a1b@epcas2p1.samsung.com>
 <20170506121053.11554-1-linus.walleij@linaro.org>
 <1678111.DmiVNKW3dQ@amdc3058>
Message-ID: <CACRpkdbmOsrxKX8=a7bvcF+c=Q2tfwYQVt0=cz+_jhDyadwa2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 8, 2017 at 12:47 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:

> Also for all current drivers we just put timing values (or a logic
> to calculate them from the standard ATA timings) into the driver
> itself and not device tree (as they are based on values are dictated
> by ATA standard and should not change for a given controller type).

I had it like that at first (and I can of course switch it back). But I
came to think this is better.

I was looking at these values from the point that it depends a bit
on the silicon where it is synthesized. So the vendor tree has
things like this:

#ifndef SL2312_FPGA_IDE
static unsigned char PIO_TIMING[5] = { 0xaa, 0xa3, 0xa1, 0x33, 0x31 };
static unsigned char TIMING_MDMA_50M[3] = { 0x66, 0x22, 0x21 };
static unsigned char TIMING_MDMA_66M[3] = { 0x88, 0x32, 0x31 };
static unsigned char TIMING_UDMA_50M[6] = { 0x33, 0x31, 0x21, 0x21,
0x11, 0x91 };
static unsigned char TIMING_UDMA_66M[7] = { 0x44, 0x42, 0x31, 0x21,
0x11, 0x91,  0x91};
#else
static unsigned char PIO_TIMING[5] = { 0x88, 0x82, 0x81, 0x32, 0x21 };
static unsigned char TIMING_MDMA_50M[3] = { 0x33, 0x11, 0x11 };
static unsigned char TIMING_MDMA_66M[3] = { 0x33, 0x11, 0x11 };
static unsigned char TIMING_UDMA_50M[6] = { 0x22, 0x11, 0x11, 0x11 };
static unsigned char TIMING_UDMA_66M[7] = { 0x22, 0x11, 0x11, 0x11 };
#endif

(From D-Link DIR-685 source release from Storlink/Cortina board support.)

So depending on whether they use an FPGA or an ASIC the values are
different, no matter what frequency (50 or 66 MHz) is used. So it is not
derived from frequency.

So I think it makes most sense to have it in the device tree as we don't
know what designs are out there.

Yours,
Linus Walleij
