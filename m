From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Tue, 11 Sep 2012 10:03:01 +0200
Subject: [PATCH 1/1] mxc_nand : allow swapping the Bad block Indicator
 for NFC v1.
In-Reply-To: <20120911071715.GB18243@pengutronix.de>
References: <1345811288.2848.308.camel@sauron.fi.intel.com>
 <1345825064-9147-1-git-send-email-gcembed@gmail.com>
 <201209061056.12386.jbe@pengutronix.de> <504DF9BB.8050509@gmail.com>
 <20120911071715.GB18243@pengutronix.de>
Message-ID: <504EF035.2090508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 09:17 AM, Sascha Hauer wrote:
> On Mon, Sep 10, 2012 at 04:31:23PM +0200, Ga?tan Carlier wrote:
>> Hi Juergen,
>> On 09/06/2012 10:56 AM, Juergen Beisert wrote:
>>> Hi Ga?tan,
>>>
>>> Ga?tan Carlier wrote:
>>>> Any comments for this patch ?
>>>
>>> Sorry, a little bit late.
>>>
>>>> Swap the BI-byte on position 0x7D0 with a data byte at 0x835.  To fix a bug
>>>> in Freescale imx NFC v1 SoC's for 2K page NAND flashes: imx27 and imx31.
>>>> Warning: The same solution needs to be applied to the boot loader and the
>>>> flash programmer.
>>>
>>> What sense does it make to swap the bytes at offset 0x7D0 and 0x835?
>>>
>>> Background: the NFC in the i.MX27/i.MX31 (NFCv1) and i.MX25/i.MX35 (NFCv2) can
>>> only handle 512 byte pages with 16 bit OOB at once. To get them work with 2 k
>>> page NANDs they only do the 512 + 16 step four times. The result is, a 2 k
>>> page NAND is not handled as 2 k data and 64 bytes OOB, its handled instead as
>>> a stream of 2112 bytes:
>>>
>>>                 |<-------- 2112 bytes --------->|
>>>                 512+16 | 512+16 | 512+16 | 512+16
>>>
>>> Which means the NFC mixes data and OOB/checksums into its internal SRAM. But
>>> all upper routines still use this SRAM content with a 2048 (data) + 64 (OOB)
>>> bytes layout (to be more precise also the NFC hardware uses this layout).
>>> Result is, the factory bad block markers are lost, because the NFC stores the
>>> first 48 bytes from each OOB into the SRAM's data area (beginning with offset
>>> 2000 (= 0x7D0) in the data area).
>>>
>>> So, the main goal of this swap patch should be to keep the factory bad block
>>> markers _and_ to make use of them.
>>>
>>> But the i.MX driver does not register its own bad block pattern description,
>>> so the default one is used with the BBM at position NAND_LARGE_BADBLOCK_POS
>>> (which means offset 0 in the OOB area).
>>>
>>> So, I think, all upper layers still search for the BBM at offset 0 of the OOB
>>> area, which results to SRAM's offset 0x800 (for NFCv1) and not 0x835. This
>>> means this patch keeps the factory bad block markers, but they won't still be
>>> used as expected.
>>>
>>> IMHO the bytes at SRAM's offset 0x7D0 and 0x800 for the NFCv1 must be swapped
>>> (and 0x7D0 and 0x1000 for the NFCv2) to keep the factory bad block markers
>>> _and_ to make use of them. Or am I wrong?
>>>
>>> Regards,
>>> Juergen
>>>
>> The point is not the necessity of swapping bytes if factory bad
>> block markers are not used.
>> In my case, the bytes must be swapped because all previous
>> operations on flash swapped these bytes :
>> * Flashes redboot (bootloader) via JTAG using OpenOCD which swaps bytes;
>> * Writes kernel and rootfs via TFTP using redboot which swaps bytes;
>> So to be able to read rootfs partition, mxc-nand driver have to swap
>> bytes otherwise, JFFS2 detects error on partition and is unable to
>> mount it.
>
> I am all in favour to be able to swap the factory bad block marker with
> the position the mtd framework expects it.
>
> That according to our understanding are bytes 0x7d0 in the main area
> and byte 0x0 in the spare area.
>
>>
>> I have not chosen to swap these bytes. In a training, I received
>> redboot and kernel 2.6.22 with set of patches to support i.MX27 and
>> these patches included swap of bytes in nand driver. So I start my
>> development with this workaround and it is now impossible to get
>> back because boards are already in production.
>
> So you are swapping the factory bad block marker with some position
> where the mtd layer does not expect the bad block marker. With this
> you preserve the factor bad block marker, but do not use it to detect
> bad blocks.
The factor bad block marker are used by redboot. I don't know how kernel 
handles them.
>
> In this form the patch is simply not correct and should be dropped.
>
> Sascha
>
Regards,
Ga?tan Carlier.
