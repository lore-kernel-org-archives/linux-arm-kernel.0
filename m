From: joe@perches.com (Joe Perches)
Date: Tue, 09 Feb 2016 18:58:11 -0800
Subject: [PATCH v3 2/9] Staging: rts5208: rtsx_transport.c: Align to
 open parenthesis
In-Reply-To: <1455072328-7033-3-git-send-email-shaun.ren@linux.com>
References: <1454981485-15686-1-git-send-email-shaun.ren@linux.com>
 <1455072328-7033-1-git-send-email-shaun.ren@linux.com>
 <1455072328-7033-3-git-send-email-shaun.ren@linux.com>
Message-ID: <1455073091.3333.24.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-02-09 at 18:45 -0800, Shaun Ren wrote:
> This patch fixes the alignment issue reported by checkpatch.pl:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Shaun Ren <shaun.ren@linux.com>
> ---
> ?drivers/staging/rts5208/rtsx_transport.c | 61 ++++++++++++++++++--------------
> ?1 file changed, 35 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
> index 5de8913..17bea8a 100644
> --- a/drivers/staging/rts5208/rtsx_transport.c
> +++ b/drivers/staging/rts5208/rtsx_transport.c
> @@ -42,8 +42,11 @@
> ? */
> ?
> ?unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
> -	unsigned int buflen, struct scsi_cmnd *srb, unsigned int *index,
> -	unsigned int *offset, enum xfer_buf_dir dir)
> +				???????unsigned int buflen,
> +				???????struct scsi_cmnd *srb,
> +				???????unsigned int *index,
> +				???????unsigned int *offset,
> +				?????enum xfer_buf_dir dir)

Doesn't this look odd to you?

> ?{
> ?	unsigned int cnt;
> ?
> @@ -54,10 +57,10 @@ unsigned int rtsx_stor_access_xfer_buf(unsigned char *buffer,
> ?		cnt = min(buflen, scsi_bufflen(srb) - *offset);
> ?		if (dir == TO_XFER_BUF)
> ?			memcpy((unsigned char *) scsi_sglist(srb) + *offset,
> -					buffer, cnt);
> +			???????buffer, cnt);
> ?		else
> ?			memcpy(buffer, (unsigned char *) scsi_sglist(srb) +
> -					*offset, cnt);
> +			???????*offset, cnt);

If you really want to make this look nicer and more
intelligible, it's probably be better to use a more
symmetric form like:

		if (dir == TO_XFER_BUF)
			memcpy((unsigned char *)scsi_sglist(srb) + *offset,
			       buffer,
			       cnt);
		else
			memcpy(buffer,
			       (unsigned char *)scsi_sglist(srb) + *offset,
			       cnt);
or maybe

		void *to;
		void *from;

		[...]

		if (dir == TO_XFER_BUF) {
			to = (unsigned char *)scsi_sglist(srb) + *offset;
			from = buffer;
		} else {
			to = buffer;
			from = (unsigned char *)scsi_sglist(srb) +
*offset;
		}
		memcpy(to, from, cnt);

or maybe

		void *to;
		void *from;

		[...]

		to = (unsigned char *)scsi_sglist(srb) + *offset;
		from = buffer;
		if (dir != TO_XFER_BUF)
			swap(to, from);

		memcpy(to, from, cnt);
