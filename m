From: wangx@marvell.com (Xiang Wang)
Date: Wed, 21 Aug 2013 19:35:29 +0800
Subject: [PATCH v4 3/4] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <1376672707-24527-4-git-send-email-zonque@gmail.com>
References: <1376672707-24527-1-git-send-email-zonque@gmail.com>
 <1376672707-24527-4-git-send-email-zonque@gmail.com>
Message-ID: <5214A601.1010607@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2013 01:05 AM, Daniel Mack wrote:
> In order to report the channel's residue, we walk the list of running
> descriptors, look for those which match the cookie, and then try to find
> the descriptor which defines upper and lower boundaries that embrace the
> current transport pointer.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>   drivers/dma/mmp_pdma.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 75 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c

Hi, Daniel
One thing I want to check with you and all:
If we have these descriptors in the running chain:
D1T1 -> D2T1 -> D3T1 => D1T2 -> D2T2 -> D3T2
|    Transaction 1    | Transaction 2      |

And DMA currently running to D2T1, if we provide the cookie of D3T2, 
what the residual value we should get? All unfinished bytes in T1+T2 or 
only unfinished bytes in T2 (seems not easy to implement)?

> index 0be99a6..b29b581 100644
> --- a/drivers/dma/mmp_pdma.c
> +++ b/drivers/dma/mmp_pdma.c
> @@ -28,8 +28,8 @@
>   #define DALGN		0x00a0
>   #define DINT		0x00f0
>   #define DDADR		0x0200
> -#define DSADR		0x0204
> -#define DTADR		0x0208
> +#define DSADR(n)	(0x0204 + ((n) << 4))
> +#define DTADR(n)	(0x0208 + ((n) << 4))
>   #define DCMD		0x020c
>
>   #define DCSR_RUN	(1 << 31)	/* Run Bit (read / write) */
> @@ -759,6 +759,78 @@ static int mmp_pdma_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
>   	return ret;
>   }
>
> +static unsigned int mmp_pdma_residue(struct mmp_pdma_chan *chan,
> +				     dma_cookie_t cookie)
> +{
> +	struct mmp_pdma_desc_sw *sw;
> +	u32 curr, residue = 0;
> +	bool passed = false;
> +	bool cyclic = chan->cyclic_first != NULL;
> +
> +	/*
> +	 * If the channel does not have a phy pointer anymore, it has already
> +	 * been completed. Therefore, its residue is 0.
> +	 */
> +	if (!chan->phy)
> +		return 0;

 From my point of view, there is one concern:
If we want to use the End-of-Receive Interrupt (EORIRQEN in DCSR), when 
an interrupt comes, usually it doesn't mean there is no bytes left.

We talked about this in this thread:
http://thread.gmane.org/gmane.linux.kernel/1500713

I posted a patch some time ago:
http://thread.gmane.org/gmane.linux.kernel/1510435
There were some comments suggested by Vinod.
Thanks!

-- 
Regards,
Xiang
