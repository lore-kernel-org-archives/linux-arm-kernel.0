From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 3 Nov 2009 17:32:26 +0800
Subject: [PATCH 2/6] pxa: frame buffer support both pxa168 and pxa910
In-Reply-To: <7c34ac520911022245o4c8fd276vcaf0d8d106b77da3@mail.gmail.com>
References: <7c34ac520911022245o4c8fd276vcaf0d8d106b77da3@mail.gmail.com>
Message-ID: <f17812d70911030132o1a3d5022o9b166898b29285c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 3, 2009 at 2:45 PM, Jun Nie <niej0001@gmail.com> wrote:
> pxa: frame buffer support both pxa168 and pxa910
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> ?drivers/video/pxa168fb.c | ? ?6 ++++++
> ?1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index 27bdf2b..2ba1444 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -875,12 +875,18 @@ failed:
> ? ? ? ?return ret;
> ?}
>
> + static const struct platform_device_id mmpfb_id_table[] = {
> + ? ? ? ?{"pxa168-fb", 0},
> + ? ? ? ?{"pxa910-fb", 1},
> + };
> +

Not sure '0' and '1' means anything here? Otherwise can just be '0'.
Intended usage could be some flags difference between processors,
let's say pxa910-fb supports YUV, one can have something like:

{ "pxa168-fb", FB_SUPPORT_RGB },
{ "pxa910-fb", FB_SUPPORT_RGB | FB_SUPPORT_YUV },

Just examples.

> ?static struct platform_driver pxa168fb_driver = {
> ? ? ? ?.driver ? ? ? ? = {
> ? ? ? ? ? ? ? ?.name ? = "pxa168-fb",
> ? ? ? ? ? ? ? ?.owner ?= THIS_MODULE,
> ? ? ? ?},
> ? ? ? ?.probe ? ? ? ? ?= pxa168fb_probe,
> + ? ? ? .id_table ? ? ? = mmpfb_id_table,
> ?};
>
> ?static int __devinit pxa168fb_init(void)
> --
> 1.5.4.3
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
