From: hare@suse.de (Hannes Reinecke)
Date: Mon, 14 Mar 2016 08:36:22 +0100
Subject: [PATCH 09/22] ncr5380: Adopt uniform DMA setup convention
In-Reply-To: <20160314042702.976019738@telegraphics.com.au>
References: <20160314042700.596192247@telegraphics.com.au>
 <20160314042702.976019738@telegraphics.com.au>
Message-ID: <56E669F6.8070407@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2016 05:27 AM, Finn Thain wrote:
> Standardize the DMA setup hooks so that the DMA implementation in
> atari_NCR5380.c can be reconciled with pseudo DMA implementation in
> NCR5380.c.
> 
> Calls to NCR5380_dma_recv_setup() and NCR5380_dma_send_setup() return
> a negative value on failure, zero on PDMA transfer success and a positive
> byte count for DMA setup success.
> 
> This convention is not entirely new, but is now applied consistently.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> ---
>  drivers/scsi/NCR5380.c      |   21 ++++++++++-----------
>  drivers/scsi/arm/cumana_1.c |   10 ++++++++--
>  drivers/scsi/arm/oak.c      |    4 ++--
>  drivers/scsi/atari_scsi.c   |    3 ---
>  4 files changed, 20 insertions(+), 18 deletions(-)
> 
> Index: linux/drivers/scsi/NCR5380.c
> ===================================================================
> --- linux.orig/drivers/scsi/NCR5380.c	2016-03-14 15:26:34.000000000 +1100
> +++ linux/drivers/scsi/NCR5380.c	2016-03-14 15:26:37.000000000 +1100
> @@ -1431,7 +1431,7 @@ static int NCR5380_transfer_dma(struct S
>  	register unsigned char p = *phase;
>  	register unsigned char *d = *data;
>  	unsigned char tmp;
> -	int foo;
> +	int result;
>  
>  	if ((tmp = (NCR5380_read(STATUS_REG) & PHASE_MASK)) != p) {
>  		*phase = tmp;
> @@ -1505,9 +1505,9 @@ static int NCR5380_transfer_dma(struct S
>   */
>  
>  	if (p & SR_IO) {
> -		foo = NCR5380_dma_recv_setup(instance, d,
> +		result = NCR5380_dma_recv_setup(instance, d,
>  			hostdata->flags & FLAG_DMA_FIXUP ? c - 1 : c);
> -		if (!foo && (hostdata->flags & FLAG_DMA_FIXUP)) {
> +		if (!result && (hostdata->flags & FLAG_DMA_FIXUP)) {
>  			/*
>  			 * The workaround was to transfer fewer bytes than we
>  			 * intended to with the pseudo-DMA read function, wait for
> @@ -1525,19 +1525,19 @@ static int NCR5380_transfer_dma(struct S
>  
>  			if (NCR5380_poll_politely(instance, BUS_AND_STATUS_REG,
>  			                          BASR_DRQ, BASR_DRQ, HZ) < 0) {
> -				foo = -1;
> +				result = -1;
>  				shost_printk(KERN_ERR, instance, "PDMA read: DRQ timeout\n");
>  			}
>  			if (NCR5380_poll_politely(instance, STATUS_REG,
>  			                          SR_REQ, 0, HZ) < 0) {
> -				foo = -1;
> +				result = -1;
>  				shost_printk(KERN_ERR, instance, "PDMA read: !REQ timeout\n");
>  			}
>  			d[c - 1] = NCR5380_read(INPUT_DATA_REG);
>  		}
>  	} else {
> -		foo = NCR5380_dma_send_setup(instance, d, c);
> -		if (!foo && (hostdata->flags & FLAG_DMA_FIXUP)) {
> +		result = NCR5380_dma_send_setup(instance, d, c);
> +		if (!result && (hostdata->flags & FLAG_DMA_FIXUP)) {
>  			/*
>  			 * Wait for the last byte to be sent.  If REQ is being asserted for
>  			 * the byte we're interested, we'll ACK it and it will go false.
> @@ -1545,7 +1545,7 @@ static int NCR5380_transfer_dma(struct S
>  			if (NCR5380_poll_politely2(instance,
>  			     BUS_AND_STATUS_REG, BASR_DRQ, BASR_DRQ,
>  			     BUS_AND_STATUS_REG, BASR_PHASE_MATCH, 0, HZ) < 0) {
> -				foo = -1;
> +				result = -1;
>  				shost_printk(KERN_ERR, instance, "PDMA write: DRQ and phase timeout\n");
>  			}
>  		}
> @@ -1555,8 +1555,7 @@ static int NCR5380_transfer_dma(struct S
>  	NCR5380_read(RESET_PARITY_INTERRUPT_REG);
>  	*data = d + c;
>  	*count = 0;
> -	*phase = NCR5380_read(STATUS_REG) & PHASE_MASK;
> -	return foo;
> +	return result;
>  }
>  
>  /*

Don't you miss a phase update here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
