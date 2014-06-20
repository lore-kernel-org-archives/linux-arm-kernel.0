From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sat, 21 Jun 2014 01:30:42 +0200
Subject: [PATCHv4 1/4] ARM: Kirkwood: Add setup file for netxbig LEDs
In-Reply-To: <1401132591-26305-2-git-send-email-andrew@lunn.ch>
References: <1401132591-26305-1-git-send-email-andrew@lunn.ch>
 <1401132591-26305-2-git-send-email-andrew@lunn.ch>
Message-ID: <20140620233042.GU20207@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 09:29:48PM +0200, Andrew Lunn wrote:
> There is currently no DT binding for the CPLD which controls the LEDs
> on the Net 2Big and Net 5Big. So use a platform device.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> v3-v4:
>   rename board-nextbig.c to nextbig.c
> ---
>  arch/arm/mach-mvebu/Kconfig    |   7 ++
>  arch/arm/mach-mvebu/Makefile   |   1 +
>  arch/arm/mach-mvebu/board.h    |   5 ++
>  arch/arm/mach-mvebu/kirkwood.c |   3 +
>  arch/arm/mach-mvebu/netxbig.c  | 191 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 207 insertions(+)
>  create mode 100644 arch/arm/mach-mvebu/netxbig.c

...

> diff --git a/arch/arm/mach-mvebu/netxbig.c b/arch/arm/mach-mvebu/netxbig.c
> new file mode 100644
> index 000000000000..e6f2f547b1c7
> --- /dev/null
> +++ b/arch/arm/mach-mvebu/netxbig.c
> @@ -0,0 +1,191 @@

...

> +
> +static struct netxbig_led net5big_v2_leds_ctrl[] = {
> +	NETXBIG_LED("net5big-v2:blue:power", 0, netxbig_v2_blue_pwr_mled,  1),
> +	NETXBIG_LED("net5big-v2:red:power",  0, netxbig_v2_red_mled,       1),
> +	NETXBIG_LED("net5big-v2:blue:sata0", 3, netxbig_v2_blue_sata_mled, 2),
> +	NETXBIG_LED("net5big-v2:red:sata0",  3, netxbig_v2_red_mled,       2),
> +	NETXBIG_LED("net5big-v2:blue:sata1", 4, netxbig_v2_blue_sata_mled, 2),
> +	NETXBIG_LED("net5big-v2:red:sata1",  4, netxbig_v2_red_mled,       2),
> +	NETXBIG_LED("net5big-v2:blue:sata2", 5, netxbig_v2_blue_sata_mled, 2),
> +	NETXBIG_LED("net5big-v2:red:sata2",  5, netxbig_v2_red_mled,       2),
> +	NETXBIG_LED("net5big-v2:blue:sata3", 6, netxbig_v2_blue_sata_mled, 2),
> +	NETXBIG_LED("net5big-v2:red:sata3",  6, netxbig_v2_red_mled,       2),
> +	NETXBIG_LED("net5big-v2:blue:sata4", 7, netxbig_v2_blue_sata_mled, 2),
> +	NETXBIG_LED("net5big-v2:red:sata5",  7, netxbig_v2_red_mled,       2),

There is a slight typo here (introduced by myself):
"net5big-v2:red:sata5" should be "net5big-v2:red:sata4".

> +};
> +
> +static struct netxbig_led_platform_data net5big_v2_leds_data = {
> +	.gpio_ext	= &netxbig_v2_gpio_ext,
> +	.timer		= netxbig_v2_led_timer,
> +	.num_timer	= ARRAY_SIZE(netxbig_v2_led_timer),
> +	.leds		= net5big_v2_leds_ctrl,
> +	.num_leds	= ARRAY_SIZE(net5big_v2_leds_ctrl),
> +};
> +
> +static struct platform_device netxbig_v2_leds = {
> +	.name		= "leds-netxbig",
> +	.id		= -1,
> +	.dev		= {
> +		.platform_data	= &net2big_v2_leds_data,
> +	},
> +};
> +
> +void __init netxbig_init(void)
> +{
> +
> +	if (of_machine_is_compatible("lacie,net5big"))

Here "lacie,net5big" must be replaced with "lacie,net5big_v2".

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140621/256082a3/attachment.sig>
