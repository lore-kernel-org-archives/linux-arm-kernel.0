From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sat, 15 Jun 2013 05:14:49 +0300
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <1371251781-17167-2-git-send-email-oliver+list@schinagl.nl>
References: <1371251781-17167-1-git-send-email-oliver+list@schinagl.nl>
 <1371251781-17167-2-git-send-email-oliver+list@schinagl.nl>
Message-ID: <CAHp75VdOrSA8EomPruMKzMgnSaVdtEEV0uB9bRpRGv7LiBsRPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 15, 2013 at 2:16 AM, Oliver Schinagl
<oliver+list@schinagl.nl> wrote:
> From: Oliver Schinagl <oliver@schinagl.nl>
>
> Allwinner has electric fuses (efuse) on their line of chips. This driver
> reads those fuses, seeds the kernel entropy and exports them as a sysfs node.
>
> These fuses are most likly to be programmed at the factory, encoding
> things like Chip ID, some sort of serial number etc and appear to be
> reasonable unique.
> While in theory, these should be writeable by the user, it will probably
> be inconvinient to do so. Allwinner recommends that a certain input pin,
> labeled 'efuse_vddq', be connected to GND. To write these fuses, 2.5 V
> needs to be applied to this pin.
>
> Even so, they can still be used to generate a board-unique mac from, board
> unique RSA key and seed the kernel RNG.
>
> Currently supported are the following known chips:
> Allwinner sun4i (A10)
> Allwinner sun5i (A10s, A13)

Few comments below.

> +++ b/drivers/misc/eeprom/sunxi_sid.c

> +#include <linux/compiler.h>

Are you sure this has to be explicitly mentioned?

> +#define SID_SIZE (SID_KEYS * 4)
> +
> +

Extra line.

> +/* We read the entire key, but only return the requested byte. This is of
> + * course slower then it could be and uses 4 times more reads as needed but
> + * keeps code simpler.

May be better to rewrite this logic and save CPU and I/O resources?

> + */
> +static u8 sunxi_sid_read_byte(const void __iomem *sid_reg_base,
> +                             const unsigned int offset)
> +{
> +       u32 sid_key = 0;
> +
> +       if (offset >= SID_SIZE)
> +               goto exit;

Just return here.

> +       sid_key = ioread32be(sid_reg_base + round_down(offset, 4));
> +       sid_key >>= (offset % 4) * 8;
> +       sid_key &= 0xff;

Redundant 0xff.

> +       /* fall through */
> +
> +exit:
> +       return (u8)sid_key;

No need to have explicit casting here.

> +       pdev = (struct platform_device *)to_platform_device(kobj_to_dev(kobj));

Ditto.

> +       sid_reg_base = (void __iomem *)platform_get_drvdata(pdev);

Ditto.

> +static int sunxi_sid_remove(struct platform_device *pdev)
> +{
> +       device_remove_bin_file(&pdev->dev, &sid_bin_attr);
> +       dev_info(&pdev->dev, "sunxi SID driver unloaded\n");

Often this is useless message. In what case this is crucial?

> +static int __init sunxi_sid_probe(struct platform_device *pdev)
> +{
> +       int entropy[SID_SIZE], i;
> +       struct resource *res;
> +       void __iomem *sid_reg_base;
> +       int ret;
> +
> +       if (!pdev->dev.of_node) {
> +               dev_err(&pdev->dev, "No devicetree data available\n");
> +               ret = -ENXIO;
> +               goto exit;

You have only return, use it. It's common practice in the .probe() function.

> +       if (IS_ERR(sid_reg_base)) {
> +               ret = PTR_ERR(sid_reg_base);
> +               goto exit;

Ditto.

> +       ret = device_create_bin_file(&pdev->dev, &sid_bin_attr);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Unable to create sysfs bin entry\n");
> +               goto exit;

Ditto.

> +       dev_info(&pdev->dev, "sunxi SID ver %s loaded\n", DRV_VERSION);
> +       ret = 0;
> +       /* fall through */

Ditto.

> +
> +exit:
> +       return ret;

Useless lines.

> +module_platform_driver(sunxi_sid_driver);
> +
> +

Extra line.


--
With Best Regards,
Andy Shevchenko
