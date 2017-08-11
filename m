From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri, 11 Aug 2017 10:39:03 -0500
Subject: [PATCH v2 1/5] reset: add reset-simple to unify socfpga, stm32,
 sunxi, and zx2967
In-Reply-To: <20170811130618.3676-2-p.zabel@pengutronix.de>
References: <20170811130618.3676-1-p.zabel@pengutronix.de>
 <20170811130618.3676-2-p.zabel@pengutronix.de>
Message-ID: <ee7dd180-b1be-d780-00dc-7a5199833810@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Phillip,

This patch is failing to apply on both v4.13-rc4 and linux-next:

error: patch failed: drivers/reset/reset-sunxi.c:108
error: drivers/reset/reset-sunxi.c: patch does not apply
Patch failed at 0001 reset: add reset-simple to unify socfpga, stm32,
sunxi, and zx2967


On 08/11/2017 08:06 AM, Philipp Zabel wrote:
> Split reusable parts out of the sunxi driver, to add a driver for simple
> reset controllers with reset lines that can be controlled by toggling
> bits in exclusive, contiguous register ranges using read-modify-write
> cycles under a spinlock. The separate sunxi driver still remains to
> register the early reset controllers, but it reuses the reset-simple
> ops.
> 
> The following patches will replace compatible reset drivers with
> reset-simple, extending it where necessary.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> Changes since v1:
> - Turn reset-simple into a complete platform driver.
> - Move common code out of assert and deassert ops into a helper function.
> - Add inverted flag to support both clear- and set-to-assert reset bits.
> - Remove status readback, will be added in the next patch.
> - Split out SoCFPGA and STM32 conversion into separate patches.
> ---

[snip]

> @@ -108,8 +55,9 @@ static int sunxi_reset_init(struct device_node *np)
>  
>  	data->rcdev.owner = THIS_MODULE;
>  	data->rcdev.nr_resets = size * 8;

I think the problem the above line. On both linux-next and v4.13-rc4:

data->rcdev.nr_resets = size * 32;

Dinh
