From: joel@jms.id.au (Joel Stanley)
Date: Thu, 26 Apr 2018 11:25:33 +0930
Subject: [PATCH linux dev-4.13] clk:aspeed: Fix reset bits for PCI/VGA and
 PECI
In-Reply-To: <20180424224056.23384-1-jae.hyun.yoo@linux.intel.com>
References: <20180424224056.23384-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <CACPK8Xe99zZ9Q0Y2HqoaGDXigBaZpkTcbfRe=gvsR5x6XMWzYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jae,

On 25 April 2018 at 08:10, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
> This commit fixes incorrect setting of reset bits for PCI/VGA and
> PECI modules.
>
> 1. Reset bit for PCI/VGA is 8.
> 2. PECI reset logic is missing so added bit 10 as its reset bit.

Great find!

Can you please send these upstream as a fix? Apply to 4.17-rc2, and
use get_maintainers.pl to identify the lists to send it to.

Also add:

Fixes: 15ed8ce5f84e ("clk: aspeed: Register gated clocks")
Cc: stable <stable@vger.kernel.org>

> +++ b/include/dt-bindings/clock/aspeed-clock.h
> @@ -43,8 +43,8 @@
>  #define ASPEED_RESET_ADC               2
>  #define ASPEED_RESET_JTAG_MASTER       3
>  #define ASPEED_RESET_MIC               4
> -#define ASPEED_RESET_PWM               5
> -#define ASPEED_RESET_PCIVGA            6
> +#define ASPEED_RESET_PECI              5
> +#define ASPEED_RESET_PWM               6

This numbers form the kernel ABI, so we shouldn't be changing them.
However, none of the mainline device trees use PCIVGA, so we can
rename that without breaking any one.

If we leave PWM as 5, and rename PCIVGA to PECI, we won't break any
existing device trees.

Cheers,

Joel


>  #define ASPEED_RESET_I2C               7
>  #define ASPEED_RESET_AHB               8
>  #define ASPEED_RESET_CRT1              9
> --
> 2.7.4
>
