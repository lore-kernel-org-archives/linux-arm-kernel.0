From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 10 Jun 2013 22:36:42 +0200
Subject: [PATCH 1/2] memory: tegra20-mc: Fix hang in IRQ handler.
In-Reply-To: <1370855624-30564-2-git-send-email-ttynkkynen@nvidia.com>
References: <1370855624-30564-1-git-send-email-ttynkkynen@nvidia.com>
 <1370855624-30564-2-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <20130610203641.GA26036@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 12:13:43PM +0300, Tuomas Tynkkynen wrote:
> In Tegra20 memory controller any MC interrupt would cause an
> infinite loop in the IRQ handler.
> 
> Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
> ---
>  drivers/memory/tegra20-mc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/tegra20-mc.c b/drivers/memory/tegra20-mc.c
> index 2ca5f28..bd5a553 100644
> --- a/drivers/memory/tegra20-mc.c
> +++ b/drivers/memory/tegra20-mc.c
> @@ -193,8 +193,11 @@ static irqreturn_t tegra20_mc_isr(int irq, void *data)
>  	mask &= stat;
>  	if (!mask)
>  		return IRQ_NONE;
> -	while ((bit = ffs(mask)) != 0)
> +	while ((bit = ffs(mask)) != 0) {
>  		tegra20_mc_decode(mc, bit - 1);
> +		mask &= BIT(bit);

Shouldn't this be "mask &= ~BIT(bit);"? The intent of the code is to
clear the bit which was handled by the loop body, right? The above
clears all other bits instead.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130610/04128b32/attachment.sig>
