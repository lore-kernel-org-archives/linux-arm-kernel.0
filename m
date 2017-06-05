From: atull@kernel.org (Alan Tull)
Date: Mon, 5 Jun 2017 10:13:07 -0500
Subject: [PATCH v12 6/6] fpga-manager: altera-ps-spi: use bitrev8x4
In-Reply-To: <9486718188ff6ec3d4cb4e196b4caa33c5af48e1.1496434383.git.stillcompiling@gmail.com>
References: <20170525172911.11467-1-stillcompiling@gmail.com>
 <684ea151ba9aa2c6555a299daf56552ddc11f596.1496434383.git.stillcompiling@gmail.com>
 <9486718188ff6ec3d4cb4e196b4caa33c5af48e1.1496434383.git.stillcompiling@gmail.com>
Message-ID: <CANk1AXQW3kYLjafW+-f_y8+frAhy_ivxPT2nKg4xpjnJJ=36yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 2, 2017 at 3:30 PM, Joshua Clayton <stillcompiling@gmail.com> wrote:

Hi Joshua,

Thanks for your work on this!

Alan

> Speed up bit reversal by using hardware bit reversal
> Add extra code to handle less than 4byte remnants, if any
>
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>

Signed-off-by: Alan Tull <atull@kernel.org>

> ---
>  drivers/fpga/altera-ps-spi.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index 0db8def668ed..14f14efdf0d5 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -149,12 +149,23 @@ static int altera_ps_write_init(struct fpga_manager *mgr,
>
>  static void rev_buf(char *buf, size_t len)
>  {
> -       const char *fw_end = (buf + len);
> +       u32 *fw32 = (u32 *)buf;
> +       size_t extra_bytes = (len & 0x03);
> +       const u32 *fw_end = (u32 *)(buf + len - extra_bytes);
>
>         /* set buffer to lsb first */
> -       while (buf < fw_end) {
> -               *buf = bitrev8(*buf);
> -               buf++;
> +       while (fw32 < fw_end) {
> +               *fw32 = bitrev8x4(*fw32);
> +               fw32++;
> +       }
> +
> +       if (extra_bytes) {
> +               buf = (char *)fw_end;
> +               while (extra_bytes) {
> +                       *buf = bitrev8(*buf);
> +                       buf++;
> +                       extra_bytes--;
> +               }
>         }
>  }
>
> --
> 2.11.0
>
