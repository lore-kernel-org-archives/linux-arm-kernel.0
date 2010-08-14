From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 Aug 2010 19:55:45 +0100
Subject: [PATCH v4] OpenRD: Enable SD/UART selection for serial port 1
In-Reply-To: <1281531799-11145-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <1281531799-11145-1-git-send-email-tanmay.upadhyay@einfochips.com>
Message-ID: <20100814185545.GB1999@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 06:33:19PM +0530, Tanmay Upadhyay wrote:
> +static int __init uart1_mpp_config(void)
> +{
> +	/* Configure MPP for UART1 */
> +	unsigned int uart1_mpp_config[] = {

As the code currently stands, the compiler's output would be similar to
the output created by this:

	static unsigned int uart1_mpp_config_init[] = { ... };
	unsigned int uart1_mpp_config[ARRAY_SIZE(uart1_mpp_config_init)];
	memcpy(uart1_mpp_config, uart1_mpp_config_init, sizeof(uart1_mpp_config));

So instead:

	static unsigned int uart1_mpp_config[] __initdata = {

and either keep it inside or move it outside the function.

Sometimes, it's worth learning about compiler implementations so that
you can avoid these kinds of inefficiencies.
