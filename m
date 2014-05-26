From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 May 2014 14:32:30 -0700
Subject: [PATCH v3 01/10] platform_data: edma: Be precise with the paRAM
 struct
In-Reply-To: <1397475725-5036-2-git-send-email-peter.ujfalusi@ti.com>
References: <1397475725-5036-1-git-send-email-peter.ujfalusi@ti.com>
 <1397475725-5036-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <CAOesGMg43jT6D_ot2tKfRXXgAgwqs5Pu_tAFKc35yxLAczrzGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 14, 2014 at 4:41 AM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> The edmacc_param struct should follow the layout of the paRAM area in the
> HW. Be explicit on the size of the fields (u32) and also mark the struct
> as packed to avoid any padding on non 32bit architectures.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Joel Fernandes <joelf@ti.com>
> ---
>  include/linux/platform_data/edma.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
> index f50821cb64be..923f8a3e4ce0 100644
> --- a/include/linux/platform_data/edma.h
> +++ b/include/linux/platform_data/edma.h
> @@ -43,15 +43,15 @@
>
>  /* PaRAM slots are laid out like this */
>  struct edmacc_param {
> -       unsigned int opt;
> -       unsigned int src;
> -       unsigned int a_b_cnt;
> -       unsigned int dst;
> -       unsigned int src_dst_bidx;
> -       unsigned int link_bcntrld;
> -       unsigned int src_dst_cidx;
> -       unsigned int ccnt;
> -};
> +       u32 opt;
> +       u32 src;
> +       u32 a_b_cnt;
> +       u32 dst;
> +       u32 src_dst_bidx;
> +       u32 link_bcntrld;
> +       u32 src_dst_cidx;
> +       u32 ccnt;
> +} __packed;
>
>  /* fields in edmacc_param.opt */
>  #define SAM            BIT(0)

I came across this patch when I was looking at a pull request from
Sekhar for EDMA cleanups, and it made me look closer at the contents
of this file.

The include/linux/platform_data/ directory is meant to hold
platform_data definitions for drivers, and nothing more.
platform_data/edma.h also contains a whole bunch of interface
definitions for the driver. They do not belong there, and should be
moved to a different include file.

That also includes the above struct, because as far as I can tell it's
a runtime state structure, not something that is passed in with
platform data.

Can someone please clean this up? Thanks.


-Olof
