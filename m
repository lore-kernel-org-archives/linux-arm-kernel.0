From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu, 21 May 2015 22:39:47 +0800
Subject: [PATCH v9 0/3] ARM: mediatek: Add driver for Mediatek I2C
In-Reply-To: <1432198410-6576-1-git-send-email-eddie.huang@mediatek.com>
References: <1432198410-6576-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <CAGS+omB7UMrEdZiJXVK78ENEqH6fL_25-Q5Fj1Z0Buzjwp60JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 4:53 PM, Eddie Huang <eddie.huang@mediatek.com> wrote:
> This series is for Mediatek SoCs I2C controller common bus driver.
>
> Earlier MTK SoC (for example, MT6589, MT8135) I2C HW has some limitations.
> New generation SoC like MT8173 fix following limitations:
>
> 1. Only support one i2c_msg number. One exception is WRRD (write then read)
> mode. WRRD can have two i2c_msg numbers.
>
> 2. Mediatek I2C controller support WRRD(write then read) mode, in WRRD
> mode the Repeat Start will be issued between 2 messages.
> In this driver if 2 messages is first write then read, the driver will
> combine 2 messages using Write-Read mode so the RS will be issued between
> the 2 messages.
>
> 3. The max transfer data length is 255 in one message. In WRRD mode, the
> max data length of second msg is 31.
>
> MT8135 and MT6589 can control I2C pins on PMIC(MT6397) by setting the i2c
> registers in MT8135 side. In this case, driver should set OFFSET_PATH_DIR
> bit first, the operation on other registers are still the same.
> For now MT6589/MT8135 support this, MT6577/MT6595/MT8127 do not support.
> For example, If want to use I2C4/5/6 pins on MT8135 just need to enable
> the pinmux, else if want to use I2C pins on PMIC(MT6397) need to add
> "mediatek,have-pmic" property in the .dts file of each platform.
>
> This driver is based on 4.1-rc1.
>
> Change in v9:
> Fix Uwe and Matthias review comment: optimize calculate speed function, avoid
> write I2C_RS_TRANSFER to unsupport SoC, and do some code clean up.
>
> Change in v8:
> Fix Wolfram's review comments like sort include file order, remove thin
> wrapper functions, remove define number that only use once, and revise
> error return value.
>
> Change in v7:
> Fix mtk_i2c_of_match in wrong patch bug.
>
> Change in v6:
> 1. Update binding document not use default clock-frequency as example.
> 2. Add mtk_i2c_compatible struct and pass hardware capabilities
>    through of_device_id
> 3. Remove some hardware setting in mtk_i2c_do_transfer to mtk_i2c_init_hw
>    so just init one time.
> 4. Correct mtk_i2c_parse_dt don't set default clock bug.
>
> Change in v5:
> Apply new i2c_adapter_quirks patch [2]. Change to use dam_map_single to map
> dma buffer. Add spinlock to fix race condition. Check of_property_read_u32
> return value. Remove I2C_FUNC_10BIT_ADDR capability due to driver not implement.
> Add MT8173 I2C driver.
>
> Change in v4:
> Modify to support i2c_adapter_quirks base on Wolfram's patch [1].
> Remove check transfer size and WRRD combine code. Instead, fill quirk
> property and let i2c_check_for_quirks to do the filter.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/314804.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/325744.html
>
> Eddie Huang (1):
>   I2C: mediatek: Add driver for MediaTek MT8173 I2C controller
>
> Xudong Chen (2):
>   dt-bindings: Add I2C bindings for mt65xx/mt81xx.
>   I2C: mediatek: Add driver for MediaTek I2C controller

Hi Eddie,
Is there a reason why this series does not include a patch to add i2c
nodes and i2c pinctrl nodes for mt8173.dtsi?

Thanks,
-Dan

>
>  .../devicetree/bindings/i2c/i2c-mt6577.txt         |  41 ++
>  drivers/i2c/busses/Kconfig                         |   9 +
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-mt65xx.c                    | 731 +++++++++++++++++++++
>  4 files changed, 782 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
>  create mode 100644 drivers/i2c/busses/i2c-mt65xx.c
>
> --
> 1.8.1.1.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
