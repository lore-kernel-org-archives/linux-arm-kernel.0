From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Sun, 13 May 2018 21:06:46 +0530
Subject: [PATCH 6/8] serial: Add Tegra Combined UART driver
In-Reply-To: <20180508114403.14499-7-mperttunen@nvidia.com>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-7-mperttunen@nvidia.com>
Message-ID: <CABb+yY3snB9o4e14by4xui+o_Vhqpe2zh6Pp_e0t-DCTKvMHWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 8, 2018 at 5:14 PM, Mikko Perttunen <mperttunen@nvidia.com> wrote:

....
>
> +config SERIAL_TEGRA_TCU
> +       tristate "NVIDIA Tegra Combined UART"
> +       depends on ARCH_TEGRA && MAILBOX
> +       select SERIAL_CORE
> +       help
> +         Support for the mailbox-based TCU (Tegra Combined UART) serial port.
> +         TCU is a virtual serial port that allows multiplexing multiple data
> +         streams into a single hardware serial port.
> +
Maybe make it depend upon TEGRA_HSP_MBOX ?

......

> +
> +static void tegra_tcu_write(const char *s, unsigned int count)
> +{
> +       struct tegra_tcu *tcu = tegra_tcu_uart_port.private_data;
> +       unsigned int written = 0, i = 0;
> +       bool insert_nl = false;
> +       uint32_t value = 0;
> +
> +       while (i < count) {
> +               if (insert_nl) {
> +                       value |= '\n' << (written++ * 8);
> +                       insert_nl = false;
> +                       i++;
> +               } else if (s[i] == '\n') {
> +                       value |= '\r' << (written++ * 8);
> +                       insert_nl = true;
> +               } else {
> +                       value |= s[i++] << (written++ * 8);
> +               }
> +
> +               if (written == 3) {
> +                       value |= 3 << 24;
> +                       value |= BIT(26);
> +                       mbox_send_message(tcu->tx, &value);
>
How is this supposed to work? tegra_hsp_doorbell_send_data() ignores
the second argument.
