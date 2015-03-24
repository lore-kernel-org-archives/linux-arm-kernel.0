From: edubezval@gmail.com (Eduardo Valentin)
Date: Tue, 24 Mar 2015 12:30:34 -0400
Subject: [PATCHv2] ti-soc-thermal: request temperature periodically if hw
 can't do that itself
In-Reply-To: <20150118202447.GA29014@amd>
References: <20150103114632.GA21883@amd>
 <20150118202447.GA29014@amd>
Message-ID: <20150324163032.GA13813@developer.hsd1.ca.comcast.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 18, 2015 at 09:24:47PM +0100, Pavel Machek wrote:
> 
> When periodic mode is not enabled, it is neccessary to force reads.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

This is a malformed patch. here is patch output (or git am)
patching file drivers/thermal/ti-soc-thermal/ti-bandgap.c
patch: **** malformed patch at line 68: (english)
http://www.livejournal.com/~pavelmachek


I would really recommend you to use git to send your patches to avoid
such problems. Can you please resend this patch in its proper format?


> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index 634b6ce..2fde78c 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -43,6 +43,8 @@
>  
>  #include "ti-bandgap.h"
>  
> +static int ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id);
> +
>  /***   Helper functions to access registers and their bitfields   ***/
>  
>  /**
> @@ -852,14 +831,21 @@ int ti_bandgap_read_temperature(struct ti_bandgap *bgp, int id,
>  	if (ret)
>  		return ret;
>  
> +	if (!TI_BANDGAP_HAS(bgp, MODE_CONFIG)) {
> +		ret = ti_bandgap_force_single_read(bgp, id);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	spin_lock(&bgp->lock);
>  	temp = ti_bandgap_read_temp(bgp, id);
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/c2cd4055/attachment.sig>
