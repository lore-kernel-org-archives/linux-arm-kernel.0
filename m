From: stefan@agner.ch (Stefan Agner)
Date: Wed, 26 Aug 2015 18:10:05 -0700
Subject: [PATCH v10 1/5] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <20150825203412.GM81844@google.com>
References: <1438594050-4595-1-git-send-email-stefan@agner.ch>
 <1438594050-4595-2-git-send-email-stefan@agner.ch>
 <20150825203412.GM81844@google.com>
Message-ID: <a2060e9f1ad9f26e508af64549da52e7@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-08-25 13:34, Brian Norris wrote:
> One more thing...
> 
> On Mon, Aug 03, 2015 at 11:27:26AM +0200, Stefan Agner wrote:
>> --- /dev/null
>> +++ b/drivers/mtd/nand/vf610_nfc.c
>> @@ -0,0 +1,645 @@
> ...
>> +struct vf610_nfc {
>> +	struct mtd_info mtd;
>> +	struct nand_chip chip;
>> +	struct device *dev;
>> +	void __iomem *regs;
>> +	struct completion cmd_done;
>> +	uint buf_offset;
>> +	int page_sz;
> 
> AFAICT (even with the 2nd patch), you never really use this field. You
> just set it/increment it, but don't use it for anything. Kill it?

It is used in the write path, I think I meant to use it for subpage
writes, when I thought it would just mean to transfer only parts of the
page to the controller.

However, as the subpage discussion basically concluded in not using it
for now on this controller, we can as well transfer the complete page
(page_sz). Or is there another case in which vf610_nfc_write_buf could
be called with less than page_sz?

--
Stefan
