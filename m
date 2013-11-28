From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 28 Nov 2013 15:10:29 +0200
Subject: [PATCH] clk: tegra: fix return value check in
 tegra_clk_register_pllc()
In-Reply-To: <CAPgLHd-wYa3Z7J93LmC0rvRPKsrjK+8DEZR+2f+e14RN+p_fPg@mail.gmail.com>
References: <CAPgLHd-wYa3Z7J93LmC0rvRPKsrjK+8DEZR+2f+e14RN+p_fPg@mail.gmail.com>
Message-ID: <20131128131029.GT26617@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 03:07:57AM +0100, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function __clk_lookup() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should
> be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/clk/tegra/clk-pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> index 197074a..a99bef7 100644
> --- a/drivers/clk/tegra/clk-pll.c
> +++ b/drivers/clk/tegra/clk-pll.c
> @@ -1507,7 +1507,7 @@ struct clk *tegra_clk_register_pllc(const char *name, const char *parent_name,
>  		return ERR_PTR(-EINVAL);
>  
>  	parent = __clk_lookup(parent_name);
> -	if (IS_ERR(parent)) {
> +	if (!parent) {
>  		WARN(1, "parent clk %s of %s must be registered first\n",
>  			name, parent_name);
>  		return ERR_PTR(-EINVAL);
> 

Ah :( There are a few more instances of this. I will fix them all.
