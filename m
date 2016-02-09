From: stillcompiling@gmail.com (Joshua Clayton)
Date: Mon, 08 Feb 2016 19:05:31 -0800
Subject: [PATCH v2 1/9] Staging: rts5208: rtsx_transport.c: Fix comment
 style warnings
In-Reply-To: <1454981485-15686-2-git-send-email-shaun.ren@linux.com>
References: <1453775248-15965-1-git-send-email-shaun.ren@linux.com>
 <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
 <1454981485-15686-2-git-send-email-shaun.ren@linux.com>
Message-ID: <2111025.vcC3H3DjyZ@diplodocus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shaun,
/*
 * Multiline comments (except in the net subsystem) should 
 * start with "/*" on a separate line. see Documentation/CodingStyle
 */
If you are going to fix the comments you should get both the beginning
and the end.
More comments inline. 

On Monday, February 08, 2016 05:31:17 PM Shaun Ren wrote:
> This patch fixes all comment style warnings in rtsx_transport.c reported by
> checkpatch.pl:
> 
> WARNING: Block comments use a trailing */ on a separate line
> 
> Signed-off-by: Shaun Ren <shaun.ren@linux.com>
> ---
>  drivers/staging/rts5208/rtsx_transport.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
> index f27491e..3e3f6fb 100644
> --- a/drivers/staging/rts5208/rtsx_transport.c
> +++ b/drivers/staging/rts5208/rtsx_transport.c
> @@ -36,7 +36,8 @@
>   * For non-scatter-gather transfers, srb->request_buffer points to the
>   * transfer buffer itself and srb->request_bufflen is the buffer's length.)
>   * Update the *index and *offset variables so that the next copy will
> - * pick up from where this one left off. */
> + * pick up from where this one left off.
> + */
> 
Fix the beginning too, as mentioned above.
 
>  unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
>  	unsigned int buflen, struct scsi_cmnd *srb, unsigned int *index,
> @@ -45,7 +46,8 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
>  	unsigned int cnt;
>  
>  	/* If not using scatter-gather, just transfer the data directly.
> -	 * Make certain it will fit in the available buffer space. */
> +	 * Make certain it will fit in the available buffer space.
> +	 */

Either fix the beginning...  or better yet, get rid of the useless
(obvious) second line so it can be a single line comment.

>  	if (scsi_sg_count(srb) == 0) {
>  		if (*offset >= scsi_bufflen(srb))
>  			return 0;
> @@ -64,7 +66,8 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
>  	 * in kernel-addressable memory then kmap() will return its address.
>  	 * If the page is not directly accessible -- such as a user buffer
>  	 * located in high memory -- then kmap() will map it to a temporary
> -	 * position in the kernel's virtual address space. */
> +	 * position in the kernel's virtual address space.
> +	 */

Fix the beginning of this comment as well.
Also,  from "If the page is already in kernel -addressible memory..."
on is just  a description of what kmap() does.
I'd get rid of those lines. 

>  	} else {
>  		struct scatterlist *sg =
>  				(struct scatterlist *) scsi_sglist(srb)
> @@ -73,7 +76,8 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
>  		/* This loop handles a single s-g list entry, which may
>  		 * include multiple pages.  Find the initial page structure
>  		 * and the starting offset within the page, and update
> -		 * the *offset and *index values for the next loop. */
> +		 * the *offset and *index values for the next loop.
> +		 */

Fix the beginning of this comment.

>  		cnt = 0;
>  		while (cnt < buflen && *index < scsi_sg_count(srb)) {
>  			struct page *page = sg_page(sg) +
> @@ -97,7 +101,8 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
>  
>  			/* Transfer the data for all the pages in this
>  			 * s-g entry.  For each page: call kmap(), do the
> -			 * transfer, and call kunmap() immediately after. */
> +			 * transfer, and call kunmap() immediately after.
> +			 */

I'd get rid of this comment. It parrots what the code does, but does not
add any information.

>  			while (sglen > 0) {
>  				unsigned int plen = min(sglen, (unsigned int)
>  						PAGE_SIZE - poff);
> @@ -123,7 +128,8 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
>  }
>  
>  /* Store the contents of buffer into srb's transfer buffer and set the
> -* SCSI residue. */
> + * SCSI residue.
> + */

Fix the beginning as well.

>  void rtsx_stor_set_xfer_buf(unsigned char *buffer,
>  	unsigned int buflen, struct scsi_cmnd *srb)
>  {
> @@ -196,7 +202,8 @@ void rtsx_invoke_transport(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>  
>  	/* Error and abort processing: try to resynchronize with the device
>  	 * by issuing a port reset.  If that fails, try a class-specific
> -	 * device reset. */
> +	 * device reset.
> +	 */

This comment  describes something that does not
happen in this function. Perhaps it did at one point. 
Regardless, It should be removed.

>  Handle_Errors:
>  	return;
>  }
> 
