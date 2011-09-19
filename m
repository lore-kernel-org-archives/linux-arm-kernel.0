From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Sep 2011 12:13:54 +0100
Subject: [PATCH] CLKDEV: Reduce scaning time
In-Reply-To: <1316182452-14061-1-git-send-email-jhbird.choi@gmail.com>
References: <1316182452-14061-1-git-send-email-jhbird.choi@gmail.com>
Message-ID: <20110919111354.GM16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 11:14:12PM +0900, Jonghwan Choi wrote:
> If ether dev_id or con_id is NULL. it is not necessary that match point
> should be 3.  it just takes a long time.

clk_get() shouldn't be used in fast paths anyway - drivers should 'get'
the clock and hold a reference to the clock while they're using it and
all the time that they're needing it to be enabled.

I think I'd like to keep the code as-is to discourage its use in fast
paths.  In any case:

> @@ -52,10 +58,10 @@ static struct clk_lookup *clk_find(const char *dev_id, const char *con_id)
>  
>  		if (match > best) {
>  			cl = p;
> -			if (match != 3)
> -				best = match;
> -			else
> +			if (match == point)
>  				break;
> +			else
> +				best = match;

Why not just change the '3' to be 'point' here - why restructure the code?
