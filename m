From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 27 Aug 2015 09:47:36 -0700
Subject: [PATCH v10 1/5] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <a2060e9f1ad9f26e508af64549da52e7@agner.ch>
References: <1438594050-4595-1-git-send-email-stefan@agner.ch>
 <1438594050-4595-2-git-send-email-stefan@agner.ch>
 <20150825203412.GM81844@google.com>
 <a2060e9f1ad9f26e508af64549da52e7@agner.ch>
Message-ID: <20150827164736.GY81844@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 06:10:05PM -0700, Stefan Agner wrote:
> On 2015-08-25 13:34, Brian Norris wrote:
> > One more thing...
> > 
> > On Mon, Aug 03, 2015 at 11:27:26AM +0200, Stefan Agner wrote:
> >> --- /dev/null
> >> +++ b/drivers/mtd/nand/vf610_nfc.c
> >> @@ -0,0 +1,645 @@
> > ...
> >> +struct vf610_nfc {
> >> +	struct mtd_info mtd;
> >> +	struct nand_chip chip;
> >> +	struct device *dev;
> >> +	void __iomem *regs;
> >> +	struct completion cmd_done;
> >> +	uint buf_offset;
> >> +	int page_sz;
> > 
> > AFAICT (even with the 2nd patch), you never really use this field. You
> > just set it/increment it, but don't use it for anything. Kill it?
> 
> It is used in the write path, I think I meant to use it for subpage
> writes, when I thought it would just mean to transfer only parts of the
> page to the controller.

Ah, you're right. Sorry, I missed that. I got mixed up seeing most of
your uses of 'page_sz' were for a local variable of the same name, not
this field.

> However, as the subpage discussion basically concluded in not using it
> for now on this controller, we can as well transfer the complete page
> (page_sz). Or is there another case in which vf610_nfc_write_buf could
> be called with less than page_sz?

I'll leave that up to you. I'm perfectly fine leaving it in, now that I
see its proper use. Just in case things change in the future, I think it
does help to clarify the flow of information a little. Although, I might
recommend a change in naming, since it could get confused with the
actual page size -- which is normally constant -- whereas this field
changes dynamically depending on the command-in-flight.

Perhaps the struct could have 'write_len' (to help represent an action)
and the local variable in vf610_nfc_command() could be 'tfr_len' (to
distinguish how it isn't necessarily identical to 'write_len')? Just
throwing (likely bad) ideas out there.

Regards,
Brian
