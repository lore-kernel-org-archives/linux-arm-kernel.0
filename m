From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2009 17:02:00 +0000
Subject: [PATCH 08/17] ARM: pxa/raumfeld: add one-wire function
In-Reply-To: <1259145751-3331-9-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-9-git-send-email-daniel@caiaq.de>
Message-ID: <20091125170200.GF5136@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 11:42:22AM +0100, Daniel Mack wrote:
> +/**
> + * One-wire (W1 bus) support
> + */
> +static void w1_enable_external_pullup(int enable)
> +{
> +	gpio_set_value(mfp_to_gpio(GPIO_W1_PULLUP_ENABLE), enable);
> +	schedule_timeout(HZ);

Shouldn't you be using msleep() here?  schedule_timeout() can terminate
prematurely, particularly if there's a signal pending.  msleep() will
wait for the full timeout.
