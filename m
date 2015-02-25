From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 25 Feb 2015 11:54:26 +0800
Subject: [PATCH v5 3/4] media: ov2640: add primary dt support
In-Reply-To: <CA+V-a8vkd2Q714s=o9WZZvPWJQATp=6POb8VYdSgarKxxEKqyQ@mail.gmail.com>
References: <1423560696-12304-1-git-send-email-josh.wu@atmel.com>
 <1423560696-12304-4-git-send-email-josh.wu@atmel.com>
 <CA+V-a8vkd2Q714s=o9WZZvPWJQATp=6POb8VYdSgarKxxEKqyQ@mail.gmail.com>
Message-ID: <54ED4772.902@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Prabhakar Lad

On 2/17/2015 12:48 AM, Lad, Prabhakar wrote:
> Hi Josh,
>
> Thanks for the patch.
>
> On Tue, Feb 10, 2015 at 9:31 AM, Josh Wu <josh.wu@atmel.com> wrote:
> [Snip]
>> -       priv->clk = v4l2_clk_get(&client->dev, "mclk");
>> +       priv->clk = v4l2_clk_get(&client->dev, "xvclk");
> with this change don?t you need to update the board file using this driver/
> the bridge driver ?
I think no.

First, my patch should be on top of the following two patches, which 
changed the *v4l2_clk_get()* behavior:
[v3,1/2] V4L: remove clock name from v4l2_clk API
https://patchwork.linuxtv.org/patch/28108/
[v4,2/2] V4L: add CCF support to the v4l2_clk API
https://patchwork.linuxtv.org/patch/28111/

After applied above two patches, v4l2_clk_get() function is changed. The 
name "mclk" is refer to a CCF clock of the ov2640 device.
If not found such a "mclk" CCF clock, v4l2_clk_get() will try to get the 
internal register clock in soc_camera.c.
As the CCF dt clock is not support by ov2640 until I add DT support, 
that means current ov2640 driver will always not found the "mclk" CCF 
clock, and they will use internal clock.
So after I changed the name "mclk" to "xvclk", the default behavior will 
not change (still using internal clock registered by soc-camera.c).

Best Regards,
Josh Wu

>
> Regards,
> --Prabhakar Lad
