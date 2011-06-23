From: inki.dae@samsung.com (daeinki)
Date: Thu, 23 Jun 2011 10:55:50 +0900
Subject: Some questions about DRM(Direct Rendering Manager)
In-Reply-To: <BANLkTinv1uGUPBX4RE2DGw4Ca_P5x0g+DA@mail.gmail.com>
References: <4E016EDC.30200@samsung.com> <4E0185E7.8020708@samsung.com>
	<BANLkTim6xvD5U9GJ2pHu-=OrYccRHSj7Fg@mail.gmail.com>
	<BANLkTinv1uGUPBX4RE2DGw4Ca_P5x0g+DA@mail.gmail.com>
Message-ID: <4E029D26.1050902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob Clark,

I'm sorry for that my mean didn't convey to you so I condensed that into
brief again.

I know drm_fb_helper_single_fb_probe() calls register_framebuffer(),
My question is that it's right way to call only drm_fb_helper_set_par()
if fb_helper->funcs->fb_probe() returns nonzero.

In this case, if fb_helper->funcs->fb_probe() returns zero then
register_framebuffer() isn't called and this means linux framebuffer
isn't used anymore.

one more question, otherwise if it uses drm based framebuffer,
register_framebuffer() should be called necessarily at booting time?

Thank you.

Rob Clark ? ?:
> fwiw, drm_fb_helper_single_fb_probe() calls register_framebuffer() (if
> that was the question?)
> 
> BR,
> -R
> 
> 2011/6/22 InKi Dae <daeinki@gmail.com>:
>> It adds dri-devel at lists.freedesktop.org to this mail thread.
>> Thank you.
>>
>> 2011? 6? 22? ?? 3:04, daeinki <inki.dae@samsung.com>?? ?:
>>> below is additional comments.
>>>
>>> daeinki ? ?:
>>>> Hi all,
>>>>
>>>> I'm writing Samsung SoC based DRM framework and this one includes FIMD
>>>> and HDMI driver as hardware dependent modules. and for now, encoder,
>>>> connector, crtc and fb module has been materialized almost. but I'm
>>>> contending with  framebuffer setting issue(created fb_info should be
>>>> registered to linux framebuffer through register_framebuffer() or not)as
>>>> default framebuffer at booting time.
>>>>
>>>> at drm_fb_helper_single_fb_probe() of drm_fb_helper.c file, fb_helper's
>>>> fb_probe callback is called and this one creates new framebuffer and
>>>> returns a value more then 0 if true. internally, this process creates an
>>>> fb_info object and drm_framebuffer and then drm_framebuffer would be
>>>> added to mode_config.fb_list of the drm_device.
>>>>
>>> it's my mistake. return value is 0 if true, nonzero otherwise.
>>>
>>>> a value returned, new_fb is used to decide that it calls
>>>> register_framebuffer() or drm_fb_helper_set_par(). at this point, I am
>>>> confused it's a good way to call register_framebuffer() otherwise
>>>> drm_fb_helper_set_par(). if register_framebuffer() is called then I
>>>> guess drm_fb_helper_set_par() or drm_crtc_helper_set_config() should be
>>>> called somewhere subsequently to apply this one to real hardware because
>>>> previous process is just for maintaining data logically.(not set up data
>>>> to h/w)
>>>>
>>>> it's a right way to call register_framebuffer() and then
>>>> drm_fb_helper_set_par() or drm_crtc_helper_set_config()? otherwise just
>>>> only drm_fb_helper_set_par() or drm_crtc_helper_set_config() ignoring
>>>> register_framebuffer()? and what is the purpose of using
>>>> register_framebuffer()?
>>>>
>>> I understood that if fb_probe() callback is fail then fb_info object is
>>> registered to linux framebuffer through register_framebuffer()
>>> otherwise(if true) hardware configuration would be completed by
>>> drm_fb_helper_set_par() so the reason of using register_framebuffer() is
>>> that the case of failing fb_probe() callback, it is for drawing on only
>>> linux framebuffer. is it right?
>>>
>>>> In my case, first, register_framebuffer() is called and then if desired
>>>> default crtc id is matched with drm_fb_helper->crtc_info[0 ~ n].crtc_id,
>>>> it gets mode_set of drm_fb_helper->crtc_info[n] and then  it calls
>>>> drm_crtc_helper_set_config(mode_set). at this time, all the hardware
>>>> configurations would be completed.
>>>>
>>>> thank you in advance.
>>>>
>>>> Best Regards
>>>> Inki Dae.
>>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel at lists.freedesktop.org
>> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
> 
