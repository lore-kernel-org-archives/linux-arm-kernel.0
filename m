From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 3 Feb 2017 21:05:28 +0100
Subject: [PATCH] phy: meson8b-usb2: fix offsets for some of the registers
In-Reply-To: <20170113185358.8362-1-martin.blumenstingl@googlemail.com>
References: <20170113185358.8362-1-martin.blumenstingl@googlemail.com>
Message-ID: <CAFBinCAWsXqPHdKwgFLceqpMKGmUpTxGtksfZd46EYAxvWdDpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon, Hi Kevin,

did you have time to look into this yet?

On Fri, Jan 13, 2017 at 7:53 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> The register offsets for REG_DBG_UART (and all following) were off by
> 0x4. This was not a problem yet because these registers are currently
> not used by the driver.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/phy/phy-meson8b-usb2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/phy/phy-meson8b-usb2.c b/drivers/phy/phy-meson8b-usb2.c
> index 33c9f4ba157d..30f56a6a411f 100644
> --- a/drivers/phy/phy-meson8b-usb2.c
> +++ b/drivers/phy/phy-meson8b-usb2.c
> @@ -81,9 +81,9 @@
>         #define REG_ADP_BC_ACA_PIN_GND                  BIT(25)
>         #define REG_ADP_BC_ACA_PIN_FLOAT                BIT(26)
>
> -#define REG_DBG_UART                                   0x14
> +#define REG_DBG_UART                                   0x10
>
> -#define REG_TEST                                       0x18
> +#define REG_TEST                                       0x14
>         #define REG_TEST_DATA_IN_MASK                   GENMASK(3, 0)
>         #define REG_TEST_EN_MASK                        GENMASK(7, 4)
>         #define REG_TEST_ADDR_MASK                      GENMASK(11, 8)
> @@ -93,7 +93,7 @@
>         #define REG_TEST_DATA_OUT_MASK                  GENMASK(19, 16)
>         #define REG_TEST_DISABLE_ID_PULLUP              BIT(20)
>
> -#define REG_TUNE                                       0x1c
> +#define REG_TUNE                                       0x18
>         #define REG_TUNE_TX_RES_TUNE_MASK               GENMASK(1, 0)
>         #define REG_TUNE_TX_HSXV_TUNE_MASK              GENMASK(3, 2)
>         #define REG_TUNE_TX_VREF_TUNE_MASK              GENMASK(7, 4)
> --
> 2.11.0
>
this is the struct (which represents the register mapping) from
Amlogic's kernel sources [0]:
typedef struct usb_peri_reg {
    volatile uint32_t config;
    volatile uint32_t ctrl;
    volatile uint32_t endp_intr;
    volatile uint32_t adp_bc;
    volatile uint32_t dbg_uart;
    volatile uint32_t test;
    volatile uint32_t tune;
    volatile uint32_t reserved;
} usb_peri_reg_t;


[0] https://github.com/khadas/linux/blob/b328e86796b96f3d421edba89cb015e30b0711dd/include/linux/amlogic/usb-meson8.h#L24
