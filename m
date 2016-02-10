From: stillcompiling@gmail.com (Joshua Clayton)
Date: Tue, 09 Feb 2016 19:06:06 -0800
Subject: [PATCH v3 1/9] Staging: rts5208: rtsx_transport.c: Cleanup
 comments
In-Reply-To: <1455072328-7033-2-git-send-email-shaun.ren@linux.com>
References: <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
 <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
 <1455072328-7033-2-git-send-email-shaun.ren@linux.com>
Message-ID: <4448620.TdHnN3dFWN@diplodocus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaun.
These comments now reflect common kernel style.
Thanks for addressing my comments.

Just one minor note below. It seems the word SCSI
SCSI got duplicated in one comment. (Noted below).

The rest look great to me.

On Tuesday, February 09, 2016 06:45:20 PM Shaun Ren wrote:
> This patch fixes all multiline comments to conform to the coding style,
> which states that multiline comments should start with "/*" and end
> with "*/" on a separate line.
> 
> Also cleans up some comments to make them more clear and/or reflect what
> the code is doing.
> 
> Signed-off-by: Shaun Ren <shaun.ren@linux.com>
> ---
> Changes since v2
>  * Cleaned up comments as per Joshua Clayton's suggestions
>  
>  drivers/staging/rts5208/rtsx_transport.c | 53 ++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
> index f27491e..5de8913 100644
> --- a/drivers/staging/rts5208/rtsx_transport.c
> +++ b/drivers/staging/rts5208/rtsx_transport.c
> @@ -1,4 +1,5 @@
> -/* Driver for Realtek PCI-Express card reader
> +/*
> + * Driver for Realtek PCI-Express card reader
>   *
>   * Copyright(c) 2009-2013 Realtek Semiconductor Corp. All rights reserved.
>   *
> @@ -30,13 +31,15 @@
>   * Scatter-gather transfer buffer access routines
>   ***********************************************************************/
>  
> -/* Copy a buffer of length buflen to/from the srb's transfer buffer.
> +/*
> + * Copy a buffer of length buflen to/from the srb's transfer buffer.
>   * (Note: for scatter-gather transfers (srb->use_sg > 0), srb->request_buffer
>   * points to a list of s-g entries and we ignore srb->request_bufflen.
>   * For non-scatter-gather transfers, srb->request_buffer points to the
>   * transfer buffer itself and srb->request_bufflen is the buffer's length.)
>   * Update the *index and *offset variables so that the next copy will
> - * pick up from where this one left off. */
> + * pick up from where this one left off.
> + */
>  
>  unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
>  	unsigned int buflen, struct scsi_cmnd *srb, unsigned int *index,
> @@ -44,8 +47,7 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
>  {
>  	unsigned int cnt;
>  
> -	/* If not using scatter-gather, just transfer the data directly.
> -	 * Make certain it will fit in the available buffer space. */
> +	/* If not using scatter-gather, just transfer the data directly. */
>  	if (scsi_sg_count(srb) == 0) {
>  		if (*offset >= scsi_bufflen(srb))
>  			return 0;
> @@ -58,22 +60,22 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
>  					*offset, cnt);
>  		*offset += cnt;
>  
> -	/* Using scatter-gather.  We have to go through the list one entry
> +	/*
> +	 * Using scatter-gather.  We have to go through the list one entry
>  	 * at a time.  Each s-g entry contains some number of pages, and
> -	 * each page has to be kmap()'ed separately.  If the page is already
> -	 * in kernel-addressable memory then kmap() will return its address.
> -	 * If the page is not directly accessible -- such as a user buffer
> -	 * located in high memory -- then kmap() will map it to a temporary
> -	 * position in the kernel's virtual address space. */
> +	 * each page has to be kmap()'ed separately.
> +	 */
>  	} else {
>  		struct scatterlist *sg =
>  				(struct scatterlist *) scsi_sglist(srb)
>  				+ *index;
>  
> -		/* This loop handles a single s-g list entry, which may
> +		/*
> +		 * This loop handles a single s-g list entry, which may
>  		 * include multiple pages.  Find the initial page structure
>  		 * and the starting offset within the page, and update
> -		 * the *offset and *index values for the next loop. */
> +		 * the *offset and *index values for the next loop.
> +		 */
>  		cnt = 0;
>  		while (cnt < buflen && *index < scsi_sg_count(srb)) {
>  			struct page *page = sg_page(sg) +
> @@ -95,9 +97,6 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
>  				++sg;
>  			}
>  
> -			/* Transfer the data for all the pages in this
> -			 * s-g entry.  For each page: call kmap(), do the
> -			 * transfer, and call kunmap() immediately after. */
>  			while (sglen > 0) {
>  				unsigned int plen = min(sglen, (unsigned int)
>  						PAGE_SIZE - poff);
> @@ -122,8 +121,10 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
>  	return cnt;
>  }
>  
> -/* Store the contents of buffer into srb's transfer buffer and set the
> -* SCSI residue. */
> +/*
> + * Store the contents of buffer into srb's transfer buffer and set the SCSI
> + * SCSI residue.
> + */

SCSI SCSI 

>  void rtsx_stor_set_xfer_buf(unsigned char *buffer,
>  	unsigned int buflen, struct scsi_cmnd *srb)
>  {
> @@ -151,7 +152,8 @@ void rtsx_stor_get_xfer_buf(unsigned char *buffer,
>   * Transport routines
>   ***********************************************************************/
>  
> -/* Invoke the transport and basic error-handling/recovery methods
> +/*
> + * Invoke the transport and basic error-handling/recovery methods
>   *
>   * This is used to send the message to the device and receive the response.
>   */
> @@ -161,8 +163,9 @@ void rtsx_invoke_transport(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>  
>  	result = rtsx_scsi_handler(srb, chip);
>  
> -	/* if the command gets aborted by the higher layers, we need to
> -	 * short-circuit all other processing
> +	/*
> +	 * if the command gets aborted by the higher layers, we need to
> +	 * short-circuit all other processing.
>  	 */
>  	if (rtsx_chk_stat(chip, RTSX_STAT_ABORT)) {
>  		dev_dbg(rtsx_dev(chip), "-- command was aborted\n");
> @@ -194,9 +197,6 @@ void rtsx_invoke_transport(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>  
>  	return;
>  
> -	/* Error and abort processing: try to resynchronize with the device
> -	 * by issuing a port reset.  If that fails, try a class-specific
> -	 * device reset. */
>  Handle_Errors:
>  	return;
>  }
> @@ -368,10 +368,11 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
>  	resid = size;
>  	sg_ptr = sg;
>  	chip->sgi = 0;
> -	/* Usually the next entry will be @sg@ + 1, but if this sg element
> +	/*
> +	 * Usually the next entry will be @sg@ + 1, but if this sg element
>  	 * is part of a chained scatterlist, it could jump to the start of
>  	 * a new scatterlist array. So here we use sg_next to move to
> -	 * the proper sg
> +	 * the proper sg.
>  	 */
>  	for (i = 0; i < *index; i++)
>  		sg_ptr = sg_next(sg_ptr);
> 
