From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Mar 2017 15:10:23 +0100
Subject: [PATCH 1/5] ARM: tegra: WARN if flowctrl is not supported
In-Reply-To: <1489584715-23138-2-git-send-email-jonathanh@nvidia.com>
References: <1489584715-23138-1-git-send-email-jonathanh@nvidia.com>
 <1489584715-23138-2-git-send-email-jonathanh@nvidia.com>
Message-ID: <20170320141023.GB28203@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 01:31:51PM +0000, Jon Hunter wrote:
> If we fail to map the IO space for the Tegra flowctrl module in
> tegra_flowctrl_init(), then if any of the public APIs for the Tegra
> flowctrl driver are called we still still attempt to access the
> hardware. Fix this by only accessing the hardware if the
> 'tegra_flowctrl_base' address has not been setup correctly and warn
> if we attempt to access the hardware when it has not.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm/mach-tegra/flowctrl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-tegra/flowctrl.c b/arch/arm/mach-tegra/flowctrl.c
> index 475e783992fd..40b15e39f849 100644
> --- a/arch/arm/mach-tegra/flowctrl.c
> +++ b/arch/arm/mach-tegra/flowctrl.c
> @@ -47,6 +47,9 @@ static void __iomem *tegra_flowctrl_base;
>  
>  static void flowctrl_update(u8 offset, u32 value)
>  {
> +	if (WARN_ONCE(!tegra_flowctrl_base, "Tegra flowctrl not supported!"))

Technically I think this string needs a terminating "\n" because it is
eventually passed to printk(), even though the WARN_ONCE() will probably
format the output correctly even without it.

Also, "not supported" isn't a very accurate description. This has to do
with the flow controller not having been initialized yet.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/bc2710c7/attachment-0001.sig>
