From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Dec 2013 22:42:49 +0000
Subject: [PATCH] dma: mv_xor: fix kernel crash on probe error
In-Reply-To: <1386882715-16433-1-git-send-email-aaro.koskinen@iki.fi>
References: <1386882715-16433-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20131212224249.GX4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 11:11:55PM +0200, Aaro Koskinen wrote:
> If the non-DT channel add path fails, the kernel will crash as the
> channel is not set to NULL and it will try to release the channel using
> the error value. Fix that.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/dma/mv_xor.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index 7807f0ef4e20..2cb35a62c7f0 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -1227,6 +1227,7 @@ static int mv_xor_probe(struct platform_device *pdev)
>  						   cd->cap_mask, irq);
>  			if (IS_ERR(xordev->channels[i])) {
>  				ret = PTR_ERR(xordev->channels[i]);
> +				xordev->channels[i] = NULL;
>  				goto err_channel_add;
>  			}
>  		}

Yes, I found this too, and although this is _a_ fix, it's not my
preferred.  I'd much prefer this instead - avoid writing invalid
channels to xordev->channels[i] in the first place...  Slightly
larger patch but IMHO more correct.

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 7807f0ef4e20..a7e91090443e 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1176,6 +1176,7 @@ static int mv_xor_probe(struct platform_device *pdev)
 		int i = 0;
 
 		for_each_child_of_node(pdev->dev.of_node, np) {
+			struct mv_xor_chan *chan;
 			dma_cap_mask_t cap_mask;
 			int irq;
 
@@ -1193,21 +1194,21 @@ static int mv_xor_probe(struct platform_device *pdev)
 				goto err_channel_add;
 			}
 
-			xordev->channels[i] =
-				mv_xor_channel_add(xordev, pdev, i,
-						   cap_mask, irq);
-			if (IS_ERR(xordev->channels[i])) {
-				ret = PTR_ERR(xordev->channels[i]);
-				xordev->channels[i] = NULL;
+			chan = mv_xor_channel_add(xordev, pdev, i,
+						  cap_mask, irq);
+			if (IS_ERR(chan)) {
+				ret = PTR_ERR(chan);
 				irq_dispose_mapping(irq);
 				goto err_channel_add;
 			}
 
+			xordev->channels[i] = chan;
 			i++;
 		}
 	} else if (pdata && pdata->channels) {
 		for (i = 0; i < MV_XOR_MAX_CHANNELS; i++) {
 			struct mv_xor_channel_data *cd;
+			struct mv_xor_chan *chan;
 			int irq;
 
 			cd = &pdata->channels[i];
@@ -1222,13 +1223,14 @@ static int mv_xor_probe(struct platform_device *pdev)
 				goto err_channel_add;
 			}
 
-			xordev->channels[i] =
-				mv_xor_channel_add(xordev, pdev, i,
-						   cd->cap_mask, irq);
-			if (IS_ERR(xordev->channels[i])) {
-				ret = PTR_ERR(xordev->channels[i]);
+			chan = mv_xor_channel_add(xordev, pdev, i,
+						  cd->cap_mask, irq);
+			if (IS_ERR(chan)) {
+				ret = PTR_ERR(chan);
 				goto err_channel_add;
 			}
+
+			xordev->channels[i] = chan;
 		}
 	}
 
