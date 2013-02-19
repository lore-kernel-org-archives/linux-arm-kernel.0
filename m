From: balbi@ti.com (Felipe Balbi)
Date: Tue, 19 Feb 2013 14:10:13 +0200
Subject: [PATCH, RFC 1/8] ARM: localtimer: return percpu clkevt on register
In-Reply-To: <e7cbb10903841ba23a93f71e7a06ae34a43adc70.1361186097.git.afzal@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
 <e7cbb10903841ba23a93f71e7a06ae34a43adc70.1361186097.git.afzal@ti.com>
Message-ID: <20130219121013.GO23197@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 18, 2013 at 05:06:39PM +0530, Afzal Mohammed wrote:
> @@ -315,6 +315,7 @@ static struct local_timer_ops twd_lt_ops __cpuinitdata = {
>  static int __init twd_local_timer_common_register(struct device_node *np)
>  {
>  	int err;
> +	struct clock_event_device *evt;
>  
>  	twd_evt = alloc_percpu(struct clock_event_device *);
>  	if (!twd_evt) {
> @@ -328,8 +329,8 @@ static int __init twd_local_timer_common_register(struct device_node *np)
>  		goto out_free;
>  	}
>  
> -	err = local_timer_register(&twd_lt_ops);
> -	if (err)
> +	evt = local_timer_register(&twd_lt_ops);
> +	if (IS_ERR(evt))
>  		goto out_irq;

this is wrong. Will return 0 even in the error case. Correct version
would be:

if (IS_ERR(evt)) {
	err = PTR_ERR(evt);
	goto out_irq;
}

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130219/f423e0b4/attachment.sig>
