From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Mon, 2 Nov 2015 12:49:47 -0300
Subject: [PATCH v4 0/5] mtd: pxa3xx_nand: rework the timing setup
In-Reply-To: <20151022171259.57581575@free-electrons.com>
References: <1445416144-9194-1-git-send-email-antoine.tenart@free-electrons.com>
 <20151022171259.57581575@free-electrons.com>
Message-ID: <CAAEAJfDDxhiKyPAt+HY7HL4XJ5VZA87R2igA0EiO4FZyVL7wrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 October 2015 at 12:12, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello Antoine,
>
> On Wed, 21 Oct 2015 10:28:59 +0200, Antoine Tenart wrote:
>
>> Antoine Tenart (5):
>>   mtd: pxa3xx: prepare allowing compile test
>>   mtd: nand: allow compile test of MTD_NAND_PXA3xx
>>   mtd: pxa3xx_nand: add helpers to setup the timings
>>   mtd: pxa3xx_nand: rework flash detection and timing setup
>>   mtd: pxa3xx_nand: clean up the pxa3xx timings
>
> I tested your series on Armada 375 DB, which uses the same pxa3xx
> driver, but with the Armada 370 variant.
>
> With the current Device Tree which has nand,keep-config to keep the
> timing configuration from the bootloader, I don't see any problem, so
> there is no regression introduced by your series, at least on this
> platform.
>
> However, when I remove nand,keep-config to use the ONFI timings from
> the NAND, then things work fine (I can mount a UBIFS root filesystem),
> but there is a weird:
>
> pxa3xx-nand f10d0000.nand: Wait time out!!!
>
> After investigating a bit, the following steps occur:
>
>  * The timings are configured as ONFI mode 0
>  * Reset command is sent to the NAND (0xff), two times in a row.
>  * READID command is sent to the NAND (0x90), three times in a row.
>  * PARAM command is sent to the NAND (0xec) and it times out

This timeout happens because initial chunk_size is 512, but the PARAM
page read is now set to read  2048 (only on the NFCv2 controller variant).

I'll prepare a patchset soon.
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
