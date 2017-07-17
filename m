From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Jul 2017 15:45:37 +0200
Subject: [PATCH 6/7] staging: fsl-mc: rewrite mc command send/receive to
 work on 32-bits
In-Reply-To: <20170717132646.3020-7-laurentiu.tudor@nxp.com>
References: <20170717132646.3020-1-laurentiu.tudor@nxp.com>
 <20170717132646.3020-7-laurentiu.tudor@nxp.com>
Message-ID: <CAK8P3a3KDh=MgfjG+sKNqcrQwq1yf-DgQN0=HigPaPYYJq0Uug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 3:26 PM,  <laurentiu.tudor@nxp.com> wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Split the 64-bit accesses in 32-bit accesses because there's no real
> constrain in MC to do only atomic 64-bit. There's only one place
> where ordering is important: when writing the MC command header the
> first 32-bit part of the header must be written last.
> We do this switch in order to allow compiling the driver on 32-bit.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/staging/fsl-mc/bus/mc-sys.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/staging/fsl-mc/bus/mc-sys.c b/drivers/staging/fsl-mc/bus/mc-sys.c
> index 195d9f3..dd2828e 100644
> --- a/drivers/staging/fsl-mc/bus/mc-sys.c
> +++ b/drivers/staging/fsl-mc/bus/mc-sys.c
> @@ -124,14 +124,15 @@ static inline void mc_write_command(struct mc_command __iomem *portal,
>  {
>         int i;
>
> -       /* copy command parameters into the portal */
> -       for (i = 0; i < MC_CMD_NUM_OF_PARAMS; i++)
> -               __raw_writeq(cmd->params[i], &portal->params[i]);
> -       /* ensure command params are committed before submitting it */
> -       wmb();
> -
> -       /* submit the command by writing the header */
> -       __raw_writeq(cmd->header, &portal->header);
> +       /*
> +        * copy command parameters into the portal. Final write
> +        * triggers the submission of the command.
> +        */
> +       for (i = sizeof(struct mc_command) / sizeof(u32) - 1; i >= 0; i--) {
> +               __raw_writel(((u32 *)cmd)[i], &((u32 *)portal)[i]);
> +               /* ensure command params are committed before submitting it */
> +               wmb();
> +       }
>  }

What is the byte order requirement on this buffer? If this is a byte string
rather than individual registers, you should probably just use
memcpy_toio(), but if these are separate registers, then using the
__raw_* accessors is still wrong, at least on kernels that have a
different byteorder from the hardware.

Also, are you sure that adding those six extra barriers has no
performance impact?

      Arnd
