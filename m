From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 17 Jul 2013 17:40:10 +0200
Subject: [PATCH 2/5] iio: at91: Use different prescal, startup mask in MR
 for different IP
In-Reply-To: <51E651D5.7050906@atmel.com>
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
 <1373789069-11604-3-git-send-email-josh.wu@atmel.com>
 <20130715125815.GC2962@lukather> <51E651D5.7050906@atmel.com>
Message-ID: <20130717154010.GB21549@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Wed, Jul 17, 2013 at 10:12:05AM +0200, Nicolas Ferre wrote:
> On 15/07/2013 14:58, Maxime Ripard :
> >On Sun, Jul 14, 2013 at 04:04:26PM +0800, Josh Wu wrote:
> >>+/*
> >>+ * Since atmel adc support different ip for touchscreen mode. Through the
> >>+ * IP check, we will know the touchscreen capbilities.
> >>+ */
> >>+static void atmel_adc_get_cap(struct at91_adc_state *st)
> >>+{
> >>+	unsigned int version;
> >>+	struct iio_dev *idev = iio_priv_to_dev(st);
> >>+
> >>+	version = at91_adc_readl(st, AT91_ADC_VERSION);
> >>+	dev_dbg(&idev->dev, "version: 0x%x\n", version);
> >>+
> >>+	st->caps.mr_prescal_mask = AT91_ADC_PRESCAL_9260;
> >>+	st->caps.mr_startup_mask = AT91_ADC_STARTUP_9260;
> >>+
> >>+	/* keep only major version number */
> >>+	switch (version & 0xf00) {
> >>+	case 0x500:	/* SAMA5D3 */
> >>+	case 0x400:	/* AT91SAM9X5/9N12 */
> >>+		st->caps.has_tsmr = 1;
> >>+		st->caps.mr_startup_mask = AT91_ADC_STARTUP;
> >>+	case 0x200:	/* AT91SAM9M10/9G45 */
> >>+		st->caps.mr_prescal_mask = AT91_ADC_PRESCAL;
> >>+
> >>+		if ((version & 0xf00) == 0x200)
> >>+			st->caps.mr_startup_mask = AT91_ADC_STARTUP_9G45;
> >>+	case 0x100:	/* AT91SAM9260/9G20 */
> >>+		break;
> >>+	default:
> >>+		dev_warn(&idev->dev,
> >>+				"Unmanaged adc version, use minimal capabilities\n");
> >>+		break;
> >>+	};
> >>+}
> >
> >Why don't you use different compatible names and derive your
> >capabilities from which compatible is declared.
> 
> Do not forget that we still have a handful of platforms that do not
> support DT (and never will).

You can do pretty much the same thing with board-file-probed device
drivers, using the id_table field of the platform_driver structure and
use the driver_data field of the associated platform_device_id array to
store the needed values.

(see for example drivers/gpio/gpio-mxs.c)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130717/71912aca/attachment-0001.sig>
