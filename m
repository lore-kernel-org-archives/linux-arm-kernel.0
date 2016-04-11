From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 11 Apr 2016 09:31:38 +0530
Subject: [PATCH 0/7] PM / devfreq: Add NoCP devfreq-event and support
 busfreq on exyno5422-odroidxu3
In-Reply-To: <570B08F2.50302@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <CANAwSgQuWBRiRhjd-E-WaSdhe2njE262CEG8uVH83jJDGFJVKA@mail.gmail.com>
 <CAGTfZH2gd5zhr4_JioSXTcpf8Fgu6r_Y9gPOJo-mYGTjAJsFyg@mail.gmail.com>
 <570B08F2.50302@samsung.com>
Message-ID: <CANAwSgRuw9ieoyu5AYFSSAcK3wgjy1-So0TA_y8bVHBa_BF7ig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 11 April 2016 at 07:46, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> Hi Anand,
>
> On 2016? 04? 09? 03:24, Chanwoo Choi wrote:
>> Hi Anand,
>>
>> On Sat, Apr 9, 2016 at 3:11 AM, Anand Moon <linux.amoon@gmail.com> wrote:
>>> Hi Chanwoo,
>>>
>
> [snip]
>
>>>>
>>>
>>> I am observing following deadlock. Both on Odroid U3 and Odroid XU4.
>>
>> Thanks for your test. I'll test it again and fix it.
>
> This possible recursive locking is fixed with following diff:
>
> Thanks for your report. I'll fix it on next patchset[1] (v9).
> [1] https://lkml.org/lkml/2016/4/8/14
>
>
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 28a9ae32d330..a4b0b02ee797 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -102,7 +102,7 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
>         if (!devfreq->governor)
>                 return -EINVAL;
>
> -       mutex_lock(&devfreq->lock);
> +       mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
>
>         ret = devfreq->governor->get_target_freq(devfreq, &freq);
>         if (ret < 0)
>
> Best Regards,
> Chanwoo Choi
>

Thanks you for these patches on devfreq.
These changes fix the warning.

Tested-by: Anand Moon <linux.amoon@gmail.com>

Tested on Odroid XU4 and Odroid U3.

Best Regards
-Anand Moon
