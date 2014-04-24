From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 24 Apr 2014 12:52:42 +0300
Subject: [PATCHv3 19/41] OMAPDSS: panel-dpi: Add DT support
In-Reply-To: <20140418155107.GB5354@atomide.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <1390301833-24944-20-git-send-email-tomi.valkeinen@ti.com>
 <20140418155107.GB5354@atomide.com>
Message-ID: <5358DEEA.1000506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/14 18:51, Tony Lindgren wrote:

>> +	gpio = of_get_gpio(node, 0);
>> +	if (gpio_is_valid(gpio) || gpio == -ENOENT) {
>> +		ddata->enable_gpio = gpio;
>> +	} else {
>> +		dev_err(&pdev->dev, "failed to parse enable gpio\n");
>> +		return gpio;
>> +	}
> 
> We should set the GPIO polarity based on the OF_GPIO_ACTIVE_LOW like
> gpio_backlight_probe_dt is doing. 

Instead of doing it with the old gpio API, and checking the 'active'
flag everywhere, I think we can use the new gpiod API which handles the
polarity automatically.

I attached prototype patches (based on -rc2) for panel dpi using that
approach. It's a bit messier than I'd like, because for non-DT boot we
need to request the gpio using the old API, and then convert it to
gpio_desc. We can remove that code when all the boards use DT.

I've compiled tested this only, as I don't have DPI panels I could use.
I did try similar approach for TFP410, and it seemed to work fine.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-panel-dpi-use-gpiod-for-enable-gpio.patch
Type: text/x-patch
Size: 2954 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140424/be49b8c6/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-OMAPDSS-panel-dpi-Add-DT-support.patch
Type: text/x-patch
Size: 3338 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140424/be49b8c6/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140424/be49b8c6/attachment.sig>
