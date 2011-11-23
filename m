From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Thu, 24 Nov 2011 00:04:03 +0100
Subject: [PATCH v3 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
 SSP/SPI) driver
In-Reply-To: <1322088363.18388.13.camel@flow>
References: <1322066725.99549.YahooMailClassic@web29017.mail.ird.yahoo.com>
 <1322088363.18388.13.camel@flow>
Message-ID: <CA+gwMcehFsxhua4QTXmtj7dYio+bOKsniC096Gs6YxhoJMrNiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 11:46 PM, Philipp Zabel <philipp.zabel@gmail.com> wrote:
> Am Mittwoch, den 23.11.2011, 16:45 +0000 schrieb Paul Parsons:
>> Add support for the Synaptics NavPoint touchpad connected to a PXA27x SSP port
>> in SPI slave mode. The driver implements a simple navigation pad. The four
>> raised dots are mapped to UP/DOWN/LEFT/RIGHT buttons and the centre of the
>> touchpad is mapped to the ENTER button.
>
> Looked good on first glance, but a quick test run of those two patches
> against v3.2-rc2 resulted in an Oops in navpoint_int as soon as I
> touched the navpoint:
>
> Unable to handle kernel paging request at virtual address 746e696f
> ...
> [<c0184f74>] (__dev_printk+0x24/0x88) from [<c018509c>] (dev_warn
> +0x34/0x48)
> [<c018509c>] (dev_warn+0x34/0x48) from [<c01c8c8c>] (navpoint_int
> +0xb0/0x1e0)
> ...
> (approximately, using CONFIG_FONT_MINI_4x6 from the
> magician_defconfig...)
>
> [...]
>> +static irqreturn_t navpoint_int(int irq, void *dev)
>> +{
>> + ? ? struct driver_data *drv_data = dev;
>> + ? ? struct ssp_device *ssp = drv_data->ssp;
>> + ? ? u32 status;
>> + ? ? irqreturn_t ret;
>> +
>> + ? ? status = pxa_ssp_read_reg(ssp, SSSR);
>> + ? ? ret = IRQ_NONE;
>> +
>> + ? ? if (status & sssr) {
>> + ? ? ? ? ? ? dev_warn(dev, "spurious interrupt: 0x%02x\n", status);
>
> I guess that's because you effectively pass drv_data into dev_warn as
> first argument here. Fix that and maybe rename the second parameter of
> navpoint_int to void *dev_id to avoid confusion.

Or maybe a better way would be to really pass the device into
irq_request and use dev_get_drvdata like in the suspend/resume
functions.
And to call platform_set_drvdata before irq_request in case it fires
immediately.

regards
Philipp
