From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 27 Jan 2012 11:08:01 -0800
Subject: [PATCH RFC 1/2] mtd : Prevent the NULL pointer access
In-Reply-To: <1327306361-9803-2-git-send-email-shubhrajyoti@ti.com>
References: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com>
 <1327306361-9803-2-git-send-email-shubhrajyoti@ti.com>
Message-ID: <CAN8TOE9a=OUcs-37RtDJE6ig-aZdFkSmfOrzL2PAyEgbQ+dJjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 12:12 AM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> This patch intends to fix the null pointer access.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> ?drivers/mtd/mtdcore.c | ? ?5 +++--
> ?1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 6ae9ca0..2b3bda7 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -118,8 +118,9 @@ static void mtd_release(struct device *dev)
> ?static int mtd_cls_suspend(struct device *dev, pm_message_t state)
> ?{
> ? ? ? ?struct mtd_info *mtd = dev_get_drvdata(dev);
> -
> - ? ? ? return mtd_suspend(mtd);
> + ? ? ? if (mtd)
> + ? ? ? ? ? ? ? return mtd_suspend(mtd);
> + ? ? ? return 0;
> ?}
>
> ?static int mtd_cls_resume(struct device *dev)

Forgot this patch was here; this fix is also covered in
l2-mtd-2.6.git, waiting for inclusion in the 3.3-rcX release cycle.
Thanks for the work though!

Brian
