From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Dec 2014 22:37:23 +0000
Subject: CCF locking problems
In-Reply-To: <548B38FB.8060605@codeaurora.org>
References: <20141212173726.GV11285@n2100.arm.linux.org.uk>
 <548B38FB.8060605@codeaurora.org>
Message-ID: <20141212223723.GW11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 12, 2014 at 10:50:35AM -0800, Stephen Boyd wrote:
> Do you have a lockdep splat? What kernel version are you running?

I could if I dug it out of the syslog files... but your patch would also
fix it - it's pretty close to what I'm now running.  Mine was found on
a v3.18 based kernel.

> but I'm not sure if you have that patch or if more recent changes to the
> framework have caused this problem to reoccur. I think I missed the part
> where clk_debug_register() is called after clk_debug_init() though, so
> perhaps you have clocks that are getting registered after late init?
> Here's an untested patch.
> 
> ----8<-----
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 44cdc47a6cc5..c9430653ddc9 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -240,12 +240,13 @@ static const struct file_operations clk_dump_fops = {
>  	.release	= single_release,
>  };
>  
> -/* caller must hold prepare_lock */
>  static int clk_debug_create_one(struct clk *clk, struct dentry *pdentry)
>  {
>  	struct dentry *d;
>  	int ret = -ENOMEM;
>  
> +	lockdep_assert_held(clk_debug_lock);
> +
>  	if (!clk || !pdentry) {
>  		ret = -EINVAL;
>  		goto out;
> @@ -1944,7 +1945,6 @@ int __clk_init(struct device *dev, struct clk *clk)
>  	else
>  		clk->rate = 0;
>  
> -	clk_debug_register(clk);
>  	/*
>  	 * walk the list of orphan clocks and reparent any that are children of
>  	 * this clock
> @@ -1979,6 +1979,9 @@ int __clk_init(struct device *dev, struct clk *clk)
>  out:
>  	clk_prepare_unlock();
>  
> +	if (!ret)
> +		clk_debug_register(clk);
> +
>  	return ret;
>  }

Apart from the lockdep_assert_held(), this is basically what I'm
currently running, which does fix the problem.  I was intending to send
my patch, but pub with good beer, gliding syndicate, and Christmas food
intervened tonight.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
