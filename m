From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Tue, 20 Oct 2015 08:54:29 +0200
Subject: [PATCH] fpga: zynq-fpga: Change fw format to handle bin instead
 of bit.
In-Reply-To: <1445299319-14921-2-git-send-email-moritz.fischer@ettus.com>
References: <1445299319-14921-1-git-send-email-moritz.fischer@ettus.com>
 <1445299319-14921-2-git-send-email-moritz.fischer@ettus.com>
Message-ID: <5625E525.2060806@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 20-10-15 02:01, Moritz Fischer wrote:
> This gets rid of the code to strip away the header and byteswap.
>
> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
> ---
>   drivers/fpga/zynq-fpga.c | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 617d382..916c551 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -104,6 +104,8 @@
>   #define INIT_POLL_TIMEOUT		2500000
>   /* Delay for polling reset bits */
>   #define INIT_POLL_DELAY			20
> +/* Sync sequence for firmware */
> +#define SYNC_SEQUENCE			"\x66\x55\x99\xAA"
>
>   /* Masks for controlling stuff in SLCR */
>   /* Disable all Level shifters */
> @@ -301,24 +303,19 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
>
>   	memcpy(kbuf, buf, count);
>
> -	/* look for the sync word */
> +	/* look for the sync sequence */
>   	for (i = 0; i < count - 4; i++) {
> -		if (memcmp(kbuf + i, "\xAA\x99\x55\x66", 4) == 0) {
> -			dev_dbg(priv->dev, "Found swapped sync word\n");
> +		if (memcmp(kbuf + i, SYNC_SEQUENCE, 4) == 0) {
> +			dev_dbg(priv->dev, "Found sync sequence");
>   			break;
>   		}
>   	}

Regarding this check, and judging from the code, I'd say that any file with a 
non word-aligned sync word is broken. So you could speed this up considerably 
by walking through the array word-by-word instread of byte-by-byte.

Checking the whole 4MB buffer from beginning to end doesn't make it really 
efficient either, if you're going to visit all that memory in case the stream 
is invalid, you might as well send it to the hardware, I wouldn't be surprised 
if that even takes less effort than going through it byte-by-byte.

I for one would rather see this check removed, the hardware handles it just 
fine and also catches more likely errors (e.g. sending a 7030 bitstream to a 
7015 chip is something that the driver cannot catch anyway, but the hardware 
detects that error just fine).

> -	/* remove the header, align the data on word boundary */
> -	if (i != count - 4) {
> -		count -= i;
> -		memmove(kbuf, kbuf + i, count);
> -	}
> -
> -	/* fixup endianness of the data */
> -	for (i = 0; i < count; i += 4) {
> -		u32 *p = (u32 *)&kbuf[i];
> -		*p = swab32(*p);
> +	/* if we detect something obviously broken, bail ... */
> +	if ((count - 4) == i) {
> +		dev_err(priv->dev, "No sync sequence found, invalid bitstream.");
> +		err = -EINVAL;
> +		goto out_free;
>   	}
>
>   	/* enable clock */
>



Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail

Visit us at : Aerospace Electrical Systems Expo Europe which will be held from 17.11.2015 till 19.11.2015, Findorffstra?e 101 Bremen, Germany, Hall 5, stand number C65
http://www.aesexpo.eu
