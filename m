From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 30 Mar 2018 15:13:17 +0100
Subject: [PATCH v6 0/3] add support for Socionext SynQuacer I2C controller
In-Reply-To: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu_7pRffEnoghf1926xzYmw2UWZx1_dLD4xy29emmW6_vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 March 2018 at 12:07, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Add a binding and a driver for the I2C IP found in the Socionext SynQuacer
> SoC, which is essentially a rebranded version of the Fujitsu F_I2C controller.
>
> v6:
> - use i2c_8bit_addr_from_msg() instead of open coding the address generation
> - switch to generic recovery using minimal helpers to drive the SDA/SCL lines
>   directly
> - use reinit_completion() and move init_completion() to probe function
> - replace bus free detection at the end of a transfer with a simple udelay()
>   for 2 clock periods
> - don't recover on every error
> - don't call synquacer_i2c_hw_init() from synquacer_i2c_hw_reset(), since it
>   will be always called twice in that case
> - add patch to sanity check i2c_transfer() arguments in core code (#3)
>

Hello Wolfram,

Any comments on this v6? Time is running out quickly for v4.17.

Thanks,
Ard.

> v5:
> - add Rob's ack to #1
> - drop unnecessary 'platform_set_drvdata(pdev, NULL)' in remove path (#2)
>
> v4:
> - clarify binding that only a single interrupt specifier is expected (#1)
> - check return value of clk_prepare_enable() on probe path (#2)
> - add Andy's R-b to patch #2
>
> v3:
> - incorporate more of Andy's review comments (#2), especially regarding the
>   bus speed and clock source handling for ACPI
> - patch #1 unchanged.
>
> v2:
> - incorporate Andy's review comments (#2)
> - patch #1 unchanged.
>
> Ard Biesheuvel (3):
>   dt-bindings: i2c: add binding for Socionext SynQuacer I2C
>   i2c: add support for Socionext SynQuacer I2C controller
>   i2c: add param sanity check to i2c_transfer()
>
>  Documentation/devicetree/bindings/i2c/i2c-synquacer.txt |  29 +
>  drivers/i2c/busses/Kconfig                              |  10 +
>  drivers/i2c/busses/Makefile                             |   1 +
>  drivers/i2c/busses/i2c-synquacer.c                      | 739 ++++++++++++++++++++
>  drivers/i2c/i2c-core-base.c                             |   3 +
>  5 files changed, 782 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
>  create mode 100644 drivers/i2c/busses/i2c-synquacer.c
>
> --
> 2.15.1
>
