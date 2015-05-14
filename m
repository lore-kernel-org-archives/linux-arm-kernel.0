From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 May 2015 20:38:53 +0200
Subject: [PATCH v3 6/6] Documentation: dmaengine: document DMA_CTRL_ACK
In-Reply-To: <1431626006-1708-6-git-send-email-robert.jarzmik@free.fr>
References: <1431626006-1708-1-git-send-email-robert.jarzmik@free.fr>
 <1431626006-1708-6-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150514183853.GN4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On Thu, May 14, 2015 at 07:53:26PM +0200, Robert Jarzmik wrote:
> Add documentation about acking the transfers, and their
> reusability.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  Documentation/dmaengine/provider.txt | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/dmaengine/provider.txt b/Documentation/dmaengine/provider.txt
> index 05d2280..33a81ce 100644
> --- a/Documentation/dmaengine/provider.txt
> +++ b/Documentation/dmaengine/provider.txt
> @@ -345,11 +345,12 @@ where to put them)
>        that abstracts it away.
>  
>    * DMA_CTRL_ACK
> -    - Undocumented feature
> -    - No one really has an idea of what it's about, besides being
> -      related to reusing the DMA transaction descriptors or having
> -      additional transactions added to it in the async-tx API
> -    - Useless in the case of the slave API
> +    - if set, the TX transfer can be reused after being completed.

Your sentences should start with an upper-case letter.

> +    - there is a guarantee the TX won't be freed until it is acked
> +      by async_tx_ack()

We never talked about what a "TX transfer" is in the
documentation. That should be documented.

> +    - as a consequence, if a device driver wants to skip the dma_map_sg() and
> +      dma_unmap_sg() because the DMA'd data wasn't used, it can resubmit the
> +      transfer right after its completion.

>From a provider PoV, the data should always be mapped and / or
allocated in coherent way, so I'm not sure how does that's relevant in
the provider doc.

Also, we should still mention that it's !slave API only.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150514/2d03763a/attachment.sig>
