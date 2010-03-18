From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Mar 2010 09:30:04 +0100
Subject: [PATCH 2/2 v2] [ARM] [IMX]: Fix clock use counter from
	underflow on multiple clk_disable().
In-Reply-To: <1268823811-9035-1-git-send-email-vzapolskiy@gmail.com>
References: <20100317092042.GB16150@pengutronix.de>
	<1268823811-9035-1-git-send-email-vzapolskiy@gmail.com>
Message-ID: <20100318083004.GA1369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Wed, Mar 17, 2010 at 02:03:31PM +0300, Vladimir Zapolskiy wrote:
> If clk_disable() is called for already disabled clock clk->usecount
> value is decremented anyway. This leads to a problem that sequent
> clk_enable() call doesn't enable the clock as expected.
> 
> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/plat-mxc/clock.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
> index 2daec3c..3189275 100644
> --- a/arch/arm/plat-mxc/clock.c
> +++ b/arch/arm/plat-mxc/clock.c
> @@ -53,10 +53,14 @@ static void __clk_disable(struct clk *clk)
>  	if (clk == NULL || IS_ERR(clk))
>  		return;
>  
> +	if (!clk->usecount) {
> +		WARN(1, "Trying to disable a clock with 0 usecount\n");
> +		return;
> +	}
> +
The advantage of just using

	WARN(!clk->usecount, "Trying to disable a disabled clock\n");

is that the error isn't caught and so is more likely to be fixed :-)
I'n not a native English speaker, but I think "Trying to disable a clock
with 0 usecount" isn't a proper English sentence.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
