From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 5 Nov 2011 15:05:32 -0400
Subject: [PATCH v2] ARM: pl330: Fix a race condition
In-Reply-To: <1317892206-3600-1-git-send-email-javi.merino@arm.com>
References: <4E8C5425.80303@arm.com>
	<1317892206-3600-1-git-send-email-javi.merino@arm.com>
Message-ID: <CAJuYYwTXf-XU0fdGT0+sggN-MEY3v7UHkfjNkM4+QUW464J9Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javi,

On 6 October 2011 05:10, Javi Merino <javi.merino@arm.com> wrote:
> If two requests have been submitted and one of them is running, if you
> call pl330_chan_ctrl(ch_id, PL330_OP_START), there's a window of time
> between the spin_lock_irqsave() and the _state() check in which the
> running transaction may finish. ?In that case, we don't receive the
> interrupt (because they are disabled), but _start() sees that the DMA
> is stopped, so it starts it. ?The problem is that it sends the
> transaction that has just finished again, because pl330_update()
> hasn't mark it as done yet.
>
> This patch fixes this race condition by not calling _start() if the
> DMA is already executing transactions. ?When interrupts are reenabled,
> pl330_update() will call _start().
>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> Acked-by: Jassi Brar <jassi.brar@samsung.com>
> ---
> ?arch/arm/common/pl330.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
> index 97912fa..7129cfb 100644
> --- a/arch/arm/common/pl330.c
> +++ b/arch/arm/common/pl330.c
> @@ -1546,7 +1546,7 @@ int pl330_chan_ctrl(void *ch_id, enum pl330_chan_op op)
>
> ? ? ? ? ? ? ? ?/* Start the next */
> ? ? ? ?case PL330_OP_START:
> - ? ? ? ? ? ? ? if (!_start(thrd))
> + ? ? ? ? ? ? ? if (!_thrd_active(thrd) && !_start(thrd))
> ? ? ? ? ? ? ? ? ? ? ? ?ret = -EIO;
> ? ? ? ? ? ? ? ?break;

On Samsung's Exynos4 platform, while testing audio playback with i2s
interface, the above change causes the playback to freeze. The
_thrd_active(thrd) call always returns '1' and hence _start(thrd) is
not getting called.

I have not debugged this much but if there is something that I am
missing, please let me know. Meanwhile, I will continue checking on
this.

Thanks,
Thomas.


>
> --
> 1.7.0.4
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
