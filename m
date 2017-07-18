From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jul 2017 16:18:21 +0200
Subject: [PATCH v2 6/8] staging: fsl-mc: don't use raw device io functions
In-Reply-To: <20170718133723.12709-7-laurentiu.tudor@nxp.com>
References: <20170718133723.12709-1-laurentiu.tudor@nxp.com>
 <20170718133723.12709-7-laurentiu.tudor@nxp.com>
Message-ID: <CAK8P3a0zH1nVoppNkT=uVgFp-NUkmenZ0AVc9vOwHEe_VEt_cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 3:37 PM,  <laurentiu.tudor@nxp.com> wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> As raw device io functions are not portable and don't handle byte-order
> (triggering suspicion that endianness isn't handled well) switch to
> using the standard api.
> Since MC expects LE byte-order and the upper layers already take care
> of that, we need to trick the device io api by doing a LE -> CPU
> conversion just before calling it. This way, the CPU -> LE conversion
> done in the api puts the data back in the right byte-order. Obviously,
> for reads the extra step is mirrored: there's a CPU -> LE conversion
> following the API call.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
> Notes:
>     -v2
>       -new patch replacing https://lkml.org/lkml/2017/7/17/419
>
>  drivers/staging/fsl-mc/bus/mc-sys.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/fsl-mc/bus/mc-sys.c b/drivers/staging/fsl-mc/bus/mc-sys.c
> index 195d9f3..8a6dc47 100644
> --- a/drivers/staging/fsl-mc/bus/mc-sys.c
> +++ b/drivers/staging/fsl-mc/bus/mc-sys.c
> @@ -126,12 +126,15 @@ static inline void mc_write_command(struct mc_command __iomem *portal,
>
>         /* copy command parameters into the portal */
>         for (i = 0; i < MC_CMD_NUM_OF_PARAMS; i++)
> -               __raw_writeq(cmd->params[i], &portal->params[i]);
> -       /* ensure command params are committed before submitting it */
> -       wmb();
> +               /*
> +                * Data is already in the expected LE byte-order. Do an
> +                * extra LE -> CPU conversion so that the CPU -> LE done in
> +                * the device io write api puts it back in the right order.
> +                */
> +               writeq_relaxed(le64_to_cpu(cmd->params[i]), &portal->params[i]);
>
>         /* submit the command by writing the header */
> -       __raw_writeq(cmd->header, &portal->header);
> +       writeq(le64_to_cpu(cmd->header), &portal->header);
>  }

Looks good, but just to be sure this is what you intended:

On 32-bit systems, this will now write val>>32 to cmd->header+4,
followed by writing val&0xffffffff to cmd->header.

You said earlier that the command is triggered when the final
four bytes are written, but it looks like the order is wrong now.

Should you use io-64-nonatomic-lo-hi.h instead of
io-64-nonatomic-hi-lo.h then?

        Arnd
