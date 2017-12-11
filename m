From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 11 Dec 2017 23:54:48 +0100
Subject: mainline/master boot bisection: v4.15-rc3 on peach-pi
 #3228-staging
In-Reply-To: <CABxcv=mUHgTxvYpOYstE7rQn8fKS3QGiTT=FzBUc8DREvVuTeQ@mail.gmail.com>
References: <680389204.71.1512980755810.JavaMail.jenkins@ip-172-30-0-246>
 <51e6d7fb-ac9e-a59f-ea63-ad06219b429d@collabora.com>
 <CAKMK7uFcGftSeQjkKu9SZmkQd8-irbUTMcOnUwi7HZtb5TePag@mail.gmail.com>
 <CABxcv=mUHgTxvYpOYstE7rQn8fKS3QGiTT=FzBUc8DREvVuTeQ@mail.gmail.com>
Message-ID: <CABxcv=m-fYZvYN4gLwBf8NwHvJb7PtNdVKR+SXgVKExZGtW4Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 11:28 PM, Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> [adding Marek and Shuah to cc list]

[snip]

>>>
>>> Please see below, I've had several bisection results pointing at
>>> that commit over the week-end on mainline but also on linux-next
>>> and net-next.  While the peach-pi is a bit flaky at the moment
>>> and is likely to have more than one issue, it does seem like this
>>> commit is causing some well reproducible kernel hang.
>>>
>>> Here's a re-run with v4.15-rc3 showing the issue:
>>>
>>>   https://lava.collabora.co.uk/scheduler/job/1018478
>>>
>>> and here's another one with the change mentioned below reverted:
>>>
>>>   https://lava.collabora.co.uk/scheduler/job/1018479
>>>
>>> They both show a warning about "unbalanced disables for lcd_vdd",
>>> I don't know if this is related as I haven't investigated any
>>> further.  It does appear to reliably hang with v4.15-rc3 and
>>> boot most of the time with the commit reverted though.
>>>
>>> The automated kernelci.org bisection is still an experimental
>>> tool and it may well be a false positive, so please take this
>>> result with a pinch of salt...
>>
>> The patch just very minimal moves the connector cleanup around (so
>> timing change), but except when you unload a driver (or maybe that
>> funny EPROBE_DEFER stuff) it shouldn't matter. So if you don't have
>> more info than "seems to hang a bit more" I have no idea what's wrong.
>> The patch itself should work, at least it survived quite some serious
>> testing we do on everything.
>> -Daniel
>>
>
> Marek was pointing to a different culprit [0] in this [1] thread. I
> see that both commits made it to v4.15-rc3, which is the first version
> where boot fails. So maybe is a combination of both? Or rather
> reverting one patch masks the error in the other.
>
> I've access to the machine but unfortunately not a lot of time to dig
> on this, I could try to do it in the weekend though.
>
> [0]: https://patchwork.kernel.org/patch/10067711/
> [1]: https://www.spinics.net/lists/arm-kernel/msg622152.html
>

So I gave a quick look to this, and at the very least there's a bug in
the Exynos5800 Peach Pi DTS caused by commit 1cb686c08d12 ("ARM: dts:
exynos: Add status property to Exynos 542x Mixer nodes").

I've posted a fix for that:

https://patchwork.kernel.org/patch/10105921/

I believe this could be also be the cause for the boot failure, since
I see in the boot log that things start to go wrong after exynos-drm
fails to bind the HDMI component:

[ 2.916347] exynos-drm exynos-drm: failed to bind 14530000.hdmi (ops
0xc1398690): -1

Anyway, I don't have access to the machine now, but it would be nice
if someone test. Or I would do in a few days.

Best regards,
Javier
