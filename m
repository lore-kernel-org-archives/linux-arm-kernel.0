From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 26 May 2010 19:07:06 +0200
Subject: [PATCH 7/17] arch/arm/common: Add missing spin_unlock_irqrestore
In-Reply-To: <Pine.LNX.4.64.1005261756000.23743@ask.diku.dk>
References: <Pine.LNX.4.64.1005261756000.23743@ask.diku.dk>
Message-ID: <201005261907.06198.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne St 26. kv?tna 2010 17:56:14 Julia Lawall napsal(a):
> From: Julia Lawall <julia@diku.dk>
> 
> Add a spin_unlock_irqrestore missing on the error path.  Although the lock
> is destroyed with the rest of the sachip structure in the function
> __sa1111_remove, it still seems useful to restore the interrupt state.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression E1;
> @@
> 
> * spin_lock_irqsave(E1,...);
>   <+... when != E1
>   if (...) {
>     ... when != E1
> *   return ...;
>   }
>   ...+>
> * spin_unlock_irqrestore(E1,...);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
> ---
> Perhaps the unlock is now too early?
> 
>  arch/arm/common/sa1111.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
> index a52a27c..59e38ff 100644
> --- a/arch/arm/common/sa1111.c
> +++ b/arch/arm/common/sa1111.c
> @@ -959,6 +959,7 @@ static int sa1111_resume(struct platform_device *dev)
>  	 */
>  	id = sa1111_readl(sachip->base + SA1111_SKID);
>  	if ((id & SKID_ID_MASK) != SKID_SA1111_ID) {
> +		spin_unlock_irqrestore(&sachip->lock, flags);
>  		__sa1111_remove(sachip);
>  		platform_set_drvdata(dev, NULL);
>  		kfree(save);

Why are "readl"s protected by spinlock anyway ? Can't we just move the locking 
past the code above ?

I'm no sa1111 expert though, Russell ?

Cheers
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
