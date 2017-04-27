From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 27 Apr 2017 21:20:11 +0200
Subject: [PATCH] [media] pxa_camera: fix module remove codepath for v4l2
 clock
In-Reply-To: <4391b498-0a75-ff42-6a7e-65aef0fada07@tul.cz> (Petr Cvek's
 message of "Tue, 25 Apr 2017 03:51:58 +0200")
References: <4391b498-0a75-ff42-6a7e-65aef0fada07@tul.cz>
Message-ID: <87efwd1wus.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> The conversion from soc_camera omitted a correct handling of the clock
> gating for a sensor. When the pxa_camera driver module was removed it
> tried to unregister clk, but this caused a similar warning:
>
>   WARNING: CPU: 0 PID: 6740 at drivers/media/v4l2-core/v4l2-clk.c:278
>   v4l2_clk_unregister(): Refusing to unregister ref-counted 0-0030 clock!
>
> The clock was at time still refcounted by the sensor driver. Before
> the removing of the pxa_camera the clock must be dropped by the sensor
> driver. This should be triggered by v4l2_async_notifier_unregister() call
> which removes sensor driver module too, calls unbind() function and then
> tries to probe sensor driver again. Inside unbind() we can safely
> unregister the v4l2 clock as the sensor driver got removed. The original
> v4l2_clk_unregister() should be put inside test as the clock can be
> already unregistered from unbind(). If there was not any bound sensor
> the clock is still present.
>
> The codepath is practically a copy from the old soc_camera. The bug was
> tested with a pxa_camera+ov9640 combination during the conversion
> of the ov9640 from the soc_camera.
>
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>

Yeah, it's way better with this patch, especially the insmod/rmmod/insmod/rmmod
test.

Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
