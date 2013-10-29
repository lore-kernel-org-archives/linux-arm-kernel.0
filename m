From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 29 Oct 2013 13:40:26 -0600
Subject: [PATCH] clk: tegra: fix return value check in
 tegra_clk_register_pllc()
In-Reply-To: <CAPgLHd-wYa3Z7J93LmC0rvRPKsrjK+8DEZR+2f+e14RN+p_fPg@mail.gmail.com>
References: <CAPgLHd-wYa3Z7J93LmC0rvRPKsrjK+8DEZR+2f+e14RN+p_fPg@mail.gmail.com>
Message-ID: <52700F2A.1080004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2013 08:07 PM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function __clk_lookup() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should
> be replaced with NULL test.

>  	parent = __clk_lookup(parent_name);
> -	if (IS_ERR(parent)) {
> +	if (!parent) {

clk_get() returns an error-value. It'd be nice if the internal clk APIs
all did the same for consistency... Otherwise, the clock subsystem is
essentially using both NULL and error-values as errors, which is rather
frowned upon.
