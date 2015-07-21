From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 21 Jul 2015 18:38:44 +0200 (CEST)
Subject: [PATCH v8 8/9] nvmem: sunxi: Move the SID driver to the nvmem
 framework
In-Reply-To: <1437403462-4432-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1437403352-4091-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1437403462-4432-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <2114639619.71276.1437496724946.JavaMail.open-xchange@oxbsltgw08.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> hat am 20. Juli 2015 um
> 16:44 geschrieben:
>
>
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> Now that we have the nvmem framework, we can consolidate the common
> driver code. Move the driver to the framework, and hopefully, it will
> fix the sysfs file creation race.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> [srinivas.kandagatla: Moved to regmap based EEPROM framework]
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Documentation/ABI/testing/sysfs-driver-sunxi-sid | 22 ---
> .../bindings/misc/allwinner,sunxi-sid.txt | 17 ---
> .../bindings/nvmem/allwinner,sunxi-sid.txt | 21 +++
> drivers/misc/eeprom/Kconfig | 13 --
> drivers/misc/eeprom/Makefile | 1 -
> drivers/misc/eeprom/sunxi_sid.c | 156 --------------------
> drivers/nvmem/Kconfig | 11 ++
> drivers/nvmem/Makefile | 2 +
> drivers/nvmem/sunxi_sid.c | 159 +++++++++++++++++++++
> 9 files changed, 193 insertions(+), 209 deletions(-)
> delete mode 100644 Documentation/ABI/testing/sysfs-driver-sunxi-sid
> delete mode 100644
> Documentation/devicetree/bindings/misc/allwinner,sunxi-sid.txt
> create mode 100644
> Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> delete mode 100644 drivers/misc/eeprom/sunxi_sid.c
> create mode 100644 drivers/nvmem/sunxi_sid.c
>
> [...]
> -static int sunxi_sid_probe(struct platform_device *pdev)
> -{
> - struct sunxi_sid_data *sid_data;
> - struct resource *res;
> - const struct of_device_id *of_dev_id;
> - u8 *entropy;
> - unsigned int i;
> -
> - sid_data = devm_kzalloc(&pdev->dev, sizeof(struct sunxi_sid_data),
> - GFP_KERNEL);
> - if (!sid_data)
> - return -ENOMEM;
> -
> - res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> - sid_data->reg_base = devm_ioremap_resource(&pdev->dev, res);
> - if (IS_ERR(sid_data->reg_base))
> - return PTR_ERR(sid_data->reg_base);
> -
> - of_dev_id = of_match_device(sunxi_sid_of_match, &pdev->dev);
> - if (!of_dev_id)
> - return -ENODEV;
> - sid_data->keysize = (int)of_dev_id->data;
> -
> - platform_set_drvdata(pdev, sid_data);
> -
> - sid_bin_attr.size = sid_data->keysize;
> - if (device_create_bin_file(&pdev->dev, &sid_bin_attr))
> - return -ENODEV;
> -
> - entropy = kzalloc(sizeof(u8) * sid_data->keysize, GFP_KERNEL);
> - for (i = 0; i < sid_data->keysize; i++)
> - entropy[i] = sunxi_sid_read_byte(sid_data, i);
> - add_device_randomness(entropy, sid_data->keysize);
> - kfree(entropy);
> -

in case of porting a driver to a new framework, i would expect the same
features.
The ported driver do not add the Security ID to the device randomness.

What's the reason for this difference?

Regards
Stefan
