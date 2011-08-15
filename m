From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 15 Aug 2011 16:01:53 +0800
Subject: [PATCH v2 2/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x
	SSP/SPI) driver
In-Reply-To: <1313317918.74933.YahooMailClassic@web29014.mail.ird.yahoo.com>
References: <1313317918.74933.YahooMailClassic@web29014.mail.ird.yahoo.com>
Message-ID: <CAMPhdO8WOsnbCvqGGYqnCMiw71esp-OqXryXAS4Xeb0id2DG2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 14, 2011 at 6:31 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
> Hi Igor,
>
> Thanks for reviewing the driver. Specific responses below.
>
> ? ? This patch should be 1/n as the other patches depend on it,
> ? ? should not include the mfp stuff and should be sent also to
> ? ? linux-input list
> ? ? and the input subsystem maintainer (both added to CC).
>
> OK, will do.
>
> +/* Touchpad Controller */
> +#define GPIO102_NAVPOINT_PWR??? MFP_CFG_OUT(GPIO102, AF0, DRIVE_LOW)
> +
>
> ? ? The name is not generic, so IMO can't be placed in the generic file.
> ? ? Can't you use the already existing GPIO102_GPIO macro
> ? ? and then change the direction in the board or driver file?
>
> MFP_CFG_OUT(GPIO102, ...) had already moved from the patch v1 platform file to patch v2 mfp-pxa27x.h because it was suggested that MFP macros should not be used directly.
> Changing the direction in the platform file would surely require using the MFP macros again, so how to keep everyone happy? Maybe I should just define a more generic name such as GPIO102_GPIO_OUT?

I guess we need a new definition for this config, looks like SCLK here
is different from a normal configuration because the pxa27x is used
as a SPI slave here?

And checked a bit with the pxa27x developer manual, there is no SCLK
for this GPIO102????

>
> +config MOUSE_NAVPOINT_PXA27x
> +??? bool "Synaptics NavPoint (PXA27x SSP/SPI)"
> +??? depends on PXA27x && PXA_SSP
> +??? help
> +??? ? This option enables support for the Synaptics NavPoint connected to
> +??? ? a PXA27x SSP port in SPI slave mode. The driver implements a simple
> +??? ? navigation pad. The four raised dots are mapped to UP/DOWN/LEFT/RIGHT
> +??? ? buttons and the centre of the touchpad is mapped to the ENTER button.
> +??? ? Say Y to enable the Synaptics NavPoint on the HP iPAQ hx4700.
>
> ? ? There is no direct dependency for HP iPAQ hx4700,
> ? ? so in theory each board that want to use it can use it.
> ? ? I'd remove the "on the HP iPAQ ..." from the above sentence.
>
> I copied that wording from my earlier ASIC3 LED driver. I suppose my feeling was that it seemed unlikely that any other platform would ever use this driver (otherwise I wouldn't be the first to write it). I'm happy to remove it.
>
> +obj-$(CONFIG_MOUSE_NAVPOINT_PXA27x)??? += navpoint.o
>
> ? ? This does not look like mouse device... Why place it in the mouse
> ? ? directory?
> ? ? I think the most reasonable place would be drivers/input/keyboard
>
> Because the underlying hardware is a touchpad controller and most of the touchpad drivers live in the mouse directory. I could have added a mouse interface to this driver but chose not to (at least for now) because the hx4700 platform already has a working touchscreen controller; a second mouse device was not needed. If future platforms require a mouse interface then one could be added relatively easily; surely this would be preferable to replicating the whole driver.
>
> +struct driver_data {
> +??? struct ssp_device *ssp;
> +??? int??? ??? gpio;
> +??? struct input_dev *input;
> +??? int??? ??? index;
> +??? uint8_t??? ??? data[8];
> +??? int??? ??? pressed;??? /* 1 = pressed, 0 = released */
> +??? unsigned??? code;??? ??? /* Key code of the last key pressed */
>
> ? ? Why do you need it?
>
> The code field? To match a button release with a button press. See later.
>
> +#define WEST??? 2416??? ??? /* 1/3 width */
> +#define EAST??? 3904??? ??? /* 2/3 width */
> +#define SOUTH??? 2480??? ??? /* 1/3 height */
> +#define NORTH??? 3424??? ??? /* 2/3 height */
>
> ? ? May be supply those via the platform_data?
>
> OK, will do.
>
> +??? drv_data = dev;
>
> ? ? Can be done in the declaration line.
>
> OK.
>
> +??? ??? if (pressed)
> +??? ??? ??? drv_data->code = code;
>
> ? ? Why do you need to store the code? You don't use it in any place...
>
> I use it in the next line. The store is conditional whereas the read is unconditional. That's why I need to store it.
>
> +??? drv_data = dev;
>
> ? ? This can be done in the declaration line.
>
> OK.
>
> +??? status = pxa_ssp_read_reg(ssp, SSSR);
> +??? ret = (status & (sssr | SSSR_RFS)) ? IRQ_HANDLED : IRQ_NONE;
> +
> +??? if (status & sssr) {
> +??? ??? dev_warn(dev, "spurious interrupt: 0x%02x\n", status);
> +??? ??? pxa_ssp_write_reg(ssp, SSSR, (status & sssr));
> +??? }
> +
> +??? while (status & SSSR_RNE) {
> +??? ??? u32 data;
> +
> +??? ??? data = pxa_ssp_read_reg(ssp, SSDR);
> +??? ??? drv_data->data[drv_data->index + 0] = (data >> 8);
> +??? ??? drv_data->data[drv_data->index + 1] = data;
> +??? ??? drv_data->index += 2;
> +??? ??? if ((drv_data->data[0] & 0x07) < drv_data->index)
> +??? ??? ??? navpoint_packet(dev);
> +??? ??? status = pxa_ssp_read_reg(ssp, SSSR);
> +??? }
>
> ? ? Should all this really be done in the interrupt context?
>
> Yes. The FIFO controller triggers a CPU interrupt when the number of RX FIFO entries >= SSCR1.RFT (RX FIFO threshold), which I have set to 1. If I don't drain the RX FIFO then the interrupt source will not be cleared and the interrupt handler will be re-entered immediately (I have verified this). In short, draining the RX FIFO clears the interrupt.
>
> +??? drv_data = dev_get_drvdata(dev);
> +??? ssp = drv_data->ssp;
>
> ? ? The above two can be done in the declaration line...
>
> OK.
>
> +??? drv_data = dev_get_drvdata(dev);
> +??? ssp = drv_data->ssp;
>
> ? ? The above two can be done in the declaration line...
>
> OK.
>
> +??? drv_data->gpio = pdata->gpio;
>
> ? ? I'd suggest checking if the supplied gpio is valid
> ? ? and also may be configure it for output?
>
> The suspend and resume functions check that the gpio is valid (which is taken to be non-zero) before using it. The platform file has already configured the gpio for output; it's the GPIO102 discussed earlier.
>
> +??? (void) navpoint_resume(&pdev->dev);
>
> ? ? Will this compile if !CONFIG_SUSPEND?
>
> oops. OK.
>
> +??? drv_data = platform_get_drvdata(pdev);
> +??? ssp = drv_data->ssp;
> +??? input = drv_data->input;
>
> ? ? You need neither ssp nor input variables - you only use them once.
> ? ? This will remove 4 lines...
>
> Actually the ssp variable is used twice. Regardless, by declaring those two variables I ensured that most of navpoint_remove() was identical to the error return of navpoint_probe(). I suppose I value consistency more than saving lines. I'm happy to move those two assignments to the declaration line.
>
> +??? (void) navpoint_suspend(&pdev->dev);
>
> ? ? and will this compile if !CONFIG_SUSPEND?
>
> oops again. OK.
>
> Regards,
> Paul
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: gpio-102.png
Type: image/png
Size: 11983 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110815/231c65cf/attachment.png>
