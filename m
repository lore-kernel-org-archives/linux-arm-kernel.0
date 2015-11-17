From: hare@suse.de (Hannes Reinecke)
Date: Tue, 17 Nov 2015 07:46:01 +0100
Subject: [PATCH, resend] scsi: advansys: fix big-endian builds
In-Reply-To: <4411376.blKgWIg75B@wuerfel>
References: <4411376.blKgWIg75B@wuerfel>
Message-ID: <564ACD29.3090007@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2015 05:49 PM, Arnd Bergmann wrote:
> Building the advansys driver in a big-endian configuration such as
> ARM allmodconfig shows a warning:
> 
>  drivers/scsi/advansys.c: In function 'adv_build_req':
>  include/uapi/linux/byteorder/big_endian.h:32:26: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>   #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
>  drivers/scsi/advansys.c:7806:22: note: in expansion of macro 'cpu_to_le32'
>    scsiqp->sense_len = cpu_to_le32(SCSI_SENSE_BUFFERSIZE);
> 
> It turns out that the commit that introduced this used the cpu_to_le32()
> incorrectly on an 8-bit field, which results in the sense_len to always
> be set to zero, as the SCSI_SENSE_BUFFERSIZE value gets moved to upper
> byte of the 32-bit intermediate.
> 
> This removes the cpu_to_le32() call to restore the original version.
> 
> I found this only by looking at the compiler output and have not done
> a full review for possible further endianess bugs in the same driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 811ddc057aac ("advansys: use DMA-API for mapping sense buffer")
> Cc: stable at vger.kernel.org # v4.2+
> ---
> Using willy at linux.intel.com, as the address listed in MAINTAINERS
> failed:
> 
> Failed to transport message. Message sending failed since the following recipients were rejected by the server: matthew at wil.cx (The server responded: Requested action not taken: mailbox unavailable invalid DNS MX or A/AAAA resource record)
> 
> Geert found the same bug and submitted the same patch earlier:
> https://lkml.org/lkml/2015/6/24/89
> 
> Neither one has been reviewed or accepted so far. Can we get one of the
> two merged please?
> 
> diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
> index 4305178e4e01..1c1cd657c380 100644
> --- a/drivers/scsi/advansys.c
> +++ b/drivers/scsi/advansys.c
> @@ -7803,7 +7803,7 @@ adv_build_req(struct asc_board *boardp, struct scsi_cmnd *scp,
>  		return ASC_BUSY;
>  	}
>  	scsiqp->sense_addr = cpu_to_le32(sense_addr);
> -	scsiqp->sense_len = cpu_to_le32(SCSI_SENSE_BUFFERSIZE);
> +	scsiqp->sense_len = SCSI_SENSE_BUFFERSIZE;
>  
>  	/* Build ADV_SCSI_REQ_Q */
>  
> 
Ho-hum. You are right.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
