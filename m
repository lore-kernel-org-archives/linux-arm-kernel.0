From: pawel@osciak.com (Pawel Osciak)
Date: Thu, 14 Aug 2014 16:25:51 +0900
Subject: [PATCH] videobuf2-core: modify the num of users
In-Reply-To: <1408000262-2774-1-git-send-email-panpan1.liu@samsung.com>
References: <1408000262-2774-1-git-send-email-panpan1.liu@samsung.com>
Message-ID: <CAMm-=zC5dHBarzoz+EdRd8oUU4WiJ1O-aKgZFybkveFroHVo1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 14, 2014 at 4:11 PM, panpan liu <panpan1.liu@samsung.com> wrote:
> If num_users returns 1 or more than 1, that means we are not the
> only user of the plane's memory.
>
> Signed-off-by: panpan liu <panpan1.liu@samsung.com>

NACK.

Please read the function documentation and how it is used. If the
number of users is 1, we are the only user and should be able to free
the queue. This will make us unable to do so.

> ---
>  drivers/media/v4l2-core/videobuf2-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/v4l2-core/videobuf2-core.c b/drivers/media/v4l2-core/videobuf2-core.c
> index c359006..d3a4b8f 100644
> --- a/drivers/media/v4l2-core/videobuf2-core.c
> +++ b/drivers/media/v4l2-core/videobuf2-core.c
> @@ -625,7 +625,7 @@ static bool __buffer_in_use(struct vb2_queue *q, struct vb2_buffer *vb)
>                  * case anyway. If num_users() returns more than 1,
>                  * we are not the only user of the plane's memory.
>                  */
> -               if (mem_priv && call_memop(vb, num_users, mem_priv) > 1)
> +               if (mem_priv && call_memop(vb, num_users, mem_priv) >= 1)
>                         return true;
>         }
>         return false;
> --
> 1.7.9.5

-- 
Thanks,
Pawel Osciak
