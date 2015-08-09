From: timur@codeaurora.org (Timur Tabi)
Date: Sat, 8 Aug 2015 17:59:00 -0700
Subject: [PATCH v5 05/11] drivers: PL011: refactor pl011_probe()
In-Reply-To: <1432225584-4655-6-git-send-email-andre.przywara@arm.com>
References: <1432225584-4655-1-git-send-email-andre.przywara@arm.com>
 <1432225584-4655-6-git-send-email-andre.przywara@arm.com>
Message-ID: <CAOZdJXVgRQZhEfYY9YdpiQ=n1D56yYL84s42V4hd2=YX2k48ZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 9:26 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> +static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
> +{
> +       struct uart_amba_port *uap;
> +       struct vendor_data *vendor = id->data;
> +       int portnr, ret;
> +
> +       portnr = pl011_find_free_port();
> +       if (portnr < 0)
> +               return portnr;
> +
> +       uap = devm_kzalloc(&dev->dev, sizeof(struct uart_amba_port),
> +                          GFP_KERNEL);
> +       if (!uap)
> +               return -ENOMEM;
> +
> +       uap->clk = devm_clk_get(&dev->dev, NULL);
> +       if (IS_ERR(uap->clk))
> +               return PTR_ERR(uap->clk);
> +
> +       = vendor;

I'm having trouble with this.  Specifically, I can't get SBSA early
console to work, because uap->vendor is uninitialized when
pl011_early_write() is called.

I don't have a non-SBSA system to test, but looking at the code, I'm
not sure how early console is supposed to work any more.  In both SBSA
and non-SBSA cases, uap->vendor is not initialized until the probe
function is called.  Isn't that too late?  I thought early console was
supposed to be running before the driver is probed.

If I make this change, then early console works on SBSA systems (with
earlycon=pl011,<address>).  But of course, this only works for SBSA
and breaks regular PL011.

--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2326,9 +2326,15 @@ static void pl011_early_write(struct console *con, const
 static int __init pl011_early_console_setup(struct earlycon_device *device,
                                            const char *opt)
 {
+       struct uart_amba_port *uap =
+           container_of(&device->port, struct uart_amba_port, port);
+
        if (!device->port.membase)
                return -ENODEV;
+       if (!uap->vendor)
+               uap->vendor = &vendor_sbsa;
+
        device->con->write = pl011_early_write;
        return 0;
 }

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
