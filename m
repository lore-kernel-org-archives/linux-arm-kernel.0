From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 26 Sep 2015 20:40:26 +0200
Subject: pwm-bl: regression on all pxa platforms
In-Reply-To: <87vbb3pkss.fsf@belgarion.home> (Robert Jarzmik's message of
 "Mon, 21 Sep 2015 22:41:23 +0200")
References: <87vbb3pkss.fsf@belgarion.home>
Message-ID: <87vbaxf2hx.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Hi Thierry,
>
> Since a bit of time, the PWM backlight based pxa platforms are broken.
> All of these platforms rely on a registering such as the one in [1].
>
> At least I think the commit 68feaca0b13e ("backlight: pwm: Handle EPROBE_DEFER
> while requesting the PWM") breaks my platforms because :
>  (a) no pwm table is added (legacy platforms)
>  (b) in this case, in pwm_get(), pmw_lookup_list is empty, and therefore chosen
>       == NULL, and therefore pwm_get() returns NULL, and pwm_get() return
>       -EPROBE_DEFER
>  (c) as a consequence, this code is unreachable in pwm_bl.c :
> 	if (IS_ERR(pb->pwm)) {
> 		ret = PTR_ERR(pb->pwm);
> 		dev_info(&pdev->dev, "%s:%d(): %d\n", __func__, __LINE__, ret);
> 		if (ret == -EPROBE_DEFER)
> 			goto err_alloc;
>
> 		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
> 		pb->legacy = true;
> 		pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");
>
> Could you either revert 68feaca0b13e or find a better solution to repair the
> legacy platorms please ?
Ok, no answer, so I'll post the revert.

Cheers.

-- 
Robert
