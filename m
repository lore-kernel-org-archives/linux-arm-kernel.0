From: John.Linn@xilinx.com (John Linn)
Date: Fri, 8 Jul 2011 07:58:03 -0600
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
In-Reply-To: <20110708085954.GA2414@n2100.arm.linux.org.uk>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706230945.GA8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107062246130.14596@xanadu.home>
	<201107071817.11842.arnd@arndb.de>
	<81e4ac16-db7b-47a0-9f93-632a5d9f898d@VA3EHSMHS028
	<20110708085954.GA2414@n2100.arm.linux.org.uk>
Message-ID: <58279306-048d-4d63-896b-f002567b5478@VA3EHSMHS004.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Friday, July 08, 2011 3:00 AM
> To: John Linn
> Cc: Arnd Bergmann; linux-arm-kernel at lists.infradead.org; Nicolas
Pitre;
> grant.likely at secretlab.ca; Barry Song
> Subject: Re: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a
> variable
> 
> On Thu, Jul 07, 2011 at 11:08:38AM -0600, John Linn wrote:
> > If I'm following this right....
> >
> > We have a hole at the start of physical memory (when it's at 0) so
> that
> > DMA can't DMA into it.  Sounds like that won't work for us?
> 
> That depends what you mean by that.
> 
> If you're saying that your physical RAM starts at some non-zero
> address,
> then that isn't a problem.  We have lots of ARM platforms where that
is
> true.
> 
> If you're saying that the first N MB of RAM can't be DMA'd to, then
> that
> is a problem as the kernel has no way to be told about that
> restriction.
> The best we can manage is to avoid freeing that memory into the normal
> allocation pools.

Yes that is what I'm saying. Catalin and I had some conversation about
this
previously (my apologies if I just didn't get it Catalin).

> 
> We do have a very small number of platforms where that's true, but we
> 'work around' that by having the kernel occupy that space.  If N MB is
> less than sizeof(kernel) + 32K then you haven't lost much.

It's only at addresses 0 - 512K that's not DMA-able.  I am using a DMA
zone (with a hole at the front) to avoid this problem right now but
maybe I'm not really understanding it and it's not working correctly.
Testing looks good with the DMA zone.

I didn't like the other solution since we had to add another exception
where the kernel frees it's memory (not to free it).  But maybe this is
really the right solution as Catalin had tried to explain to me.

Thanks for the input,
John


Please ignore any legal footer at the bottom of this email, this problem
is still being worked.


  

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
