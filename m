From: daniel.vetter@ffwll.ch (Daniel Vetter)
Date: Tue, 12 Dec 2017 19:14:18 +0100
Subject: mainline/master boot bisection: v4.15-rc3 on peach-pi
 #3228-staging
In-Reply-To: <8e506908-153f-2782-e7ef-7f2cc2c48662@samsung.com>
References: <680389204.71.1512980755810.JavaMail.jenkins@ip-172-30-0-246>
 <51e6d7fb-ac9e-a59f-ea63-ad06219b429d@collabora.com>
 <CAKMK7uFcGftSeQjkKu9SZmkQd8-irbUTMcOnUwi7HZtb5TePag@mail.gmail.com>
 <CGME20171211222845epcas3p25dca41e692c07c85f127ad946c4ec9a6@epcas3p2.samsung.com>
 <CABxcv=mUHgTxvYpOYstE7rQn8fKS3QGiTT=FzBUc8DREvVuTeQ@mail.gmail.com>
 <8e506908-153f-2782-e7ef-7f2cc2c48662@samsung.com>
Message-ID: <CAKMK7uF75WFrVMX=7zQyZp=y8GSZBQTMzjLDVf46rYqq=aFumQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 12:38 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi All,
>
>
> On 2017-12-11 23:28, Javier Martinez Canillas wrote:
>>
>> [adding Marek and Shuah to cc list]
>>
>> On Mon, Dec 11, 2017 at 6:05 PM, Daniel Vetter <daniel.vetter@ffwll.ch>
>> wrote:
>>>
>>> On Mon, Dec 11, 2017 at 11:30 AM, Guillaume Tucker
>>> <guillaume.tucker@collabora.com> wrote:
>>>>
>>>> Hi Daniel,
>>>>
>>>> Please see below, I've had several bisection results pointing at
>>>> that commit over the week-end on mainline but also on linux-next
>>>> and net-next.  While the peach-pi is a bit flaky at the moment
>>>> and is likely to have more than one issue, it does seem like this
>>>> commit is causing some well reproducible kernel hang.
>>>>
>>>> Here's a re-run with v4.15-rc3 showing the issue:
>>>>
>>>>    https://lava.collabora.co.uk/scheduler/job/1018478
>>>>
>>>> and here's another one with the change mentioned below reverted:
>>>>
>>>>    https://lava.collabora.co.uk/scheduler/job/1018479
>>>>
>>>> They both show a warning about "unbalanced disables for lcd_vdd",
>>>> I don't know if this is related as I haven't investigated any
>>>> further.  It does appear to reliably hang with v4.15-rc3 and
>>>> boot most of the time with the commit reverted though.
>>>>
>>>> The automated kernelci.org bisection is still an experimental
>>>> tool and it may well be a false positive, so please take this
>>>> result with a pinch of salt...
>>>
>>> The patch just very minimal moves the connector cleanup around (so
>>> timing change), but except when you unload a driver (or maybe that
>>> funny EPROBE_DEFER stuff) it shouldn't matter. So if you don't have
>>> more info than "seems to hang a bit more" I have no idea what's wrong.
>>> The patch itself should work, at least it survived quite some serious
>>> testing we do on everything.
>>> -Daniel
>>>
>> Marek was pointing to a different culprit [0] in this [1] thread. I
>> see that both commits made it to v4.15-rc3, which is the first version
>> where boot fails. So maybe is a combination of both? Or rather
>> reverting one patch masks the error in the other.
>>
>> I've access to the machine but unfortunately not a lot of time to dig
>> on this, I could try to do it in the weekend though.
>
>
> After a recent discussion on the Javier's patch:
> https://patchwork.kernel.org/patch/10106417/
> I've managed to reproduce this issue also on Exynos5250 based Samsung
> Snow Chromebook and investigate a bit.
>
> It is caused by a deadlock in the main kernel workqueue. Here are details:
>
> 1. Exynos DRM fails to initialize due to missing regulators and gets moved
> to deferred probe device list
>
> 2. Deferred probe is triggered and kernel "events" workqueue calls
> deferred_probe_work_func()
>
> 3. exynos_drm_bind() is called, component_bind_all() fails due to missing
> Exynos Mixer device
>
> 4. error handling path is executed in exynos_drm_bind(), which calls
> drm_mode_config_cleanup()
>
> 5. drm_mode_config_cleanup() calls flush_scheduled_work(), what causes
> deadlock.
>
> Do You have idea how to fix this issue properly?
>
> Taking a look at git blame, this indeed shows that the issue has been
> introduced by the commit a703c55004e1 ("drm: safely free connectors from
> connector_ite"), which added a call to flush_scheduled_work() in
> drm_mode_config_cleanup().
>
> drm_mode_config_cleanup() should avoid calling flush_scheduled_work() if
> called from the workqueue, but I don't have idea how to check that. The
> other way of fixing it would be to resurrect separate workqueue for DRM
> related events.

We need to flush the work there, or things will go wrong on unload. I
think the real fix is to make sure that the connector cleanup work
isn't run on the same work stuff as any driver bind stuff, which yes
means new separate workqueue just for this.

I guess the simple fix is to do that in the drm, but tbh I'm surprised
that driver bind/deferred probe hasn't run into this problem anywhere
else yet.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
