From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Apr 2012 09:53:59 +0200
Subject: [PATCH 07/15] ARM: ux500: Enable the SMSC9115 on Snowball via
 Device Tree
In-Reply-To: <1334867804-31942-8-git-send-email-lee.jones@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <1334867804-31942-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZzAQNJ9ejKJJQJhEPjO9VO+fPHmPeCErg8XOj-dLc3gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee can you please split this patch in one piece which is this:

On Thu, Apr 19, 2012 at 10:36 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Enable the Ethernet port by providing correct information via DT.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> ?arch/arm/boot/dts/snowball.dts ? ? | ? 10 ++++++++--
> ?arch/arm/mach-ux500/board-mop500.c | ? ?1 -
> ?2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
> index 0ba0955..22b82cc 100644
> --- a/arch/arm/boot/dts/snowball.dts
> +++ b/arch/arm/boot/dts/snowball.dts
> @@ -79,10 +79,16 @@
> ? ? ? ? ? ? ? ? ? ? ? ?ranges;
>
> ? ? ? ? ? ? ? ? ? ? ? ?ethernet at 50000000 {
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? compatible = "smsc,9111";
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? compatible = "smsc,lan9115";
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?reg = <0x50000000 0x10000>;
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? interrupts = <12 0x4>;
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? interrupts = <12 0x1>;
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?interrupt-parent = <&gpio4>;
> +
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? reg-shift = <1>;
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? reg-io-width = <2>;
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? smsc,force-internal-phy;
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? smsc,irq-active-high;
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? smsc,irq-push-pull;
> ? ? ? ? ? ? ? ? ? ? ? ?};
> ? ? ? ? ? ? ? ?};

So that patch only affects arch/arm/boot/dts/*

And this in another patch:

> diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
> index 50809af..9dbd34b 100644
> --- a/arch/arm/mach-ux500/board-mop500.c
> +++ b/arch/arm/mach-ux500/board-mop500.c
> @@ -612,7 +612,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
> ?static struct platform_device *snowball_of_platform_devs[] __initdata = {
> ? ? ? ?&snowball_led_dev,
> ? ? ? ?&snowball_key_dev,
> - ? ? ? &snowball_sbnet_dev,
> ? ? ? ?&ab8500_device,
> ?};

So I can accumulate changes to ux500 core code and Device Tree updates
on separate branches?

Yours,
Linus Walleij
