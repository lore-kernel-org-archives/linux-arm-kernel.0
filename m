From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Feb 2015 11:29:14 +0100
Subject: [PATCH v3 1/2] mtd: nand: pxa3xx: Fix PIO FIFO draining
In-Reply-To: <54E22168.7070703@free-electrons.com>
References: <1424091072-7738-1-git-send-email-maxime.ripard@free-electrons.com>
 <1424091072-7738-2-git-send-email-maxime.ripard@free-electrons.com>
 <20150216172753.5e92739a@free-electrons.com>
 <20150216164134.GE25269@lukather>
 <54E22168.7070703@free-electrons.com>
Message-ID: <20150217102914.GJ25269@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 16, 2015 at 01:57:12PM -0300, Ezequiel Garcia wrote:
> On 02/16/2015 01:41 PM, Maxime Ripard wrote:
> > On Mon, Feb 16, 2015 at 05:27:53PM +0100, Thomas Petazzoni wrote:
> >> Dear Maxime Ripard,
> >>
> >> On Mon, 16 Feb 2015 13:51:11 +0100, Maxime Ripard wrote:
> >>
> >>> +		while (index < (len * 4)) {
> >>> +			u32 timeout;
> >>> +
> >>> +			__raw_readsl(info->mmio_base + NDDB, data + index, 8);
> >>
> >> Are you guaranteed that 'len' is a multiple of 32 bytes?
> > 
> > I don't know if you're guaranteed of anything, but the controller
> > supports only 512, 2k, 4k and 8k pages, which are all mutiples of 32
> > bytes.
> > 
> 
> 'len' here comes from:
> 
> do_bytes = min(info->data_size, info->chunk_size);
> 
> and
> 
> DIV_ROUND_UP(do_bytes, 4)
> 
> Where chunk_size is the size we want to read/write in each command step
> (keep in mind that with extended commands we issue multiple commands, and
> read/write data in chunks for each page).
> 
> And data_size is initialized at mtd->writesize (i.e. the size of a page).
> 
> Given all the flash pages I'm aware of are multiples of 32-bytes, and
> given a chunk is either a quarter or half a page... I'd say it's
> guaranteed to be 32-byte multiple, but perhaps it's a good idea to enforce it.

I've fixed the function to both support non-aligned reading, just in
case, and to not poll on the last chunk, as Boris suggested.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150217/cb438b6c/attachment.sig>
