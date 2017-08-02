From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 2 Aug 2017 16:54:57 +0200
Subject: [patch v1 2/2] drivers: jtag: Add Aspeed SoC 24xx and 25xx
 families JTAG master driver
In-Reply-To: <1501679918-20486-3-git-send-email-oleksandrs@mellanox.com>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <1501679918-20486-3-git-send-email-oleksandrs@mellanox.com>
Message-ID: <CAK8P3a02O4Xrt+HECjs+GQLw8s9novYLdUUmk_V+oK=EX-HqfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 2, 2017 at 3:18 PM, Oleksandr Shamray
<oleksandrs@mellanox.com> wrote:
> Driver adds support of Aspeed 2500/2400 series SOC JTAG master controller.
>
> Driver implements the following jtag ops:
> - freq_get;
> - freq_set;
> - status_get;
> - idle;
> - xfer;
>
> It has been tested on Mellanox system with BMC equipped with
> Aspeed 2520 SoC for programming CPLD devices.
>
> Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>

Looking at this one before the subsystem. Overall looks really nice,
it seems you got a good abstraction between the subsystem and the
driver.

> +
> +static int aspeed_jtag_freq_set(struct jtag *jtag, unsigned long freq);
> +static int aspeed_jtag_freq_get(struct jtag *jtag, unsigned long *frq);
> +static int aspeed_jtag_status_get(struct jtag *jtag,
> +                                 enum jtag_endstate *status);
> +static int aspeed_jtag_idle(struct jtag *jtag,
> +                           struct jtag_run_test_idle *runtest);
> +static int aspeed_jtag_xfer(struct jtag *jtag, struct jtag_xfer *xfer);

Please try to reorder the functions definitions in a way that lets you
remove the forward declarations.

> +
> +static void aspeed_jtag_run_test_idle_sw(struct aspeed_jtag *aspeed_jtag,
> +                                        struct jtag_run_test_idle *runtest)
> +{
> +       char sm_pause_irpause[] = {1, 1, 1, 1, 0, 1, 0};
> +       char sm_pause_drpause[] = {1, 1, 1, 0, 1, 0};
> +       char sm_idle_irpause[] = {1, 1, 0, 1, 0};
> +       char sm_idle_drpause[] = {1, 0, 1, 0};
> +       char sm_pause_idle[] = {1, 1, 0};

These could be 'static const' if you adapt the aspeed_jtag_sm_cycle
prototype accordingly.

> +
> +static const struct of_device_id aspeed_jtag_of_match[] = {
> +       { .compatible = "aspeed,aspeed-jtag", },
> +       {}
> +};

The series should include a patch for the DT binding for this device.
You may want to be a little more specific here, to avoid problems if
aspeed ever makes an updated version of this device with a slightly
different register interface. Usually we include the full name of the
SoC in the "compatible" string for that.

       Arnd
