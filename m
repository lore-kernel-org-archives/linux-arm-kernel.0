From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Nov 2014 11:45:41 +0000
Subject: [PATCH] ARM: Add unwinding support for memmove function
In-Reply-To: <1416836757-30547-1-git-send-email-linyongting@gmail.com>
References: <1416836757-30547-1-git-send-email-linyongting@gmail.com>
Message-ID: <20141125114541.GE3836@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 09:45:56PM +0800, Lin Yongting wrote:
> @@ -27,12 +28,17 @@
>   */
>  
>  ENTRY(memmove)
> +	UNWIND(	.fnstart			)
>  
>  		subs	ip, r0, r1
>  		cmphi	r2, ip
>  		bls	memcpy
>  
>  		stmfd	sp!, {r0, r4, lr}
> +	UNWIND(	.fnend				)
> +
> +	UNWIND(	.fnstart			)
> +	UNWIND(	.save	{r0, r4, lr}		) @ in first stmfd block

This is pretty horrid, but I guess it's necessary due to how the unwinder
works.  If no one has any objections, please drop it in the patch system
and I'll queue it for the next merge window.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
