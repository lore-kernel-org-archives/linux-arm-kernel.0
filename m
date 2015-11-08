From: jdmason@kudzu.us (Jon Mason)
Date: Sun, 8 Nov 2015 16:24:18 -0500
Subject: [PATCH] NTB: fix 32-bit compiler warning
In-Reply-To: <10263287.Brd9HPYQJD@wuerfel>
References: <10263287.Brd9HPYQJD@wuerfel>
Message-ID: <20151108212416.GA16867@kudzu.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 09:59:34AM +0200, Arnd Bergmann wrote:
> resource_size_t may be 32-bit wide on some architectures, which causes
> this warning when building the NTB code:
> 
> drivers/ntb/ntb_transport.c: In function 'ntb_transport_link_work':
> drivers/ntb/ntb_transport.c:828:46: warning: right shift count >= width of type [-Wshift-count-overflow]
> 
> The warning is harmless but can be avoided by using the upper_32_bits()
> macro.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")

Pulled in to the next release (coming out shortly).

Thanks,
Jon

> ---
> Found while building ARM allmodconfig
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 6e3ee907d186..700f3ae833c2 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -825,10 +825,10 @@ static void ntb_transport_link_work(struct work_struct *work)
>  			size = max_mw_size;
>  
>  		spad = MW0_SZ_HIGH + (i * 2);
> -		ntb_peer_spad_write(ndev, spad, (u32)(size >> 32));
> +		ntb_peer_spad_write(ndev, spad, upper_32_bits(size));
>  
>  		spad = MW0_SZ_LOW + (i * 2);
> -		ntb_peer_spad_write(ndev, spad, (u32)size);
> +		ntb_peer_spad_write(ndev, spad, lower_32_bits(size));
>  	}
>  
>  	ntb_peer_spad_write(ndev, NUM_MWS, nt->mw_count);
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe at googlegroups.com.
> To post to this group, send email to linux-ntb at googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/10263287.Brd9HPYQJD%40wuerfel.
> For more options, visit https://groups.google.com/d/optout.
