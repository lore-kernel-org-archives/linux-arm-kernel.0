From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 13 Jul 2017 23:25:37 +0200
Subject: [PATCH v3 4/6] ARM: meson: Add SMP bringup code for Meson8 and
 Meson8b
In-Reply-To: <CAFBinCBnQgnZQ3ogPBCxCxhTWzjSi1A4uSpdKO97NpBhQPryPw@mail.gmail.com>
References: <20170713103113.21560-1-martin.blumenstingl@googlemail.com>
 <20170713103113.21560-5-martin.blumenstingl@googlemail.com>
 <20170713131625.GC31807@n2100.armlinux.org.uk>
 <CAFBinCBnQgnZQ3ogPBCxCxhTWzjSi1A4uSpdKO97NpBhQPryPw@mail.gmail.com>
Message-ID: <CAFBinCDQpZM6+5tAsMHNhkESnKZx9Ox+mSs110KYiE-oUr1thg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 9:39 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> Hi Russel,
>
> On Thu, Jul 13, 2017 at 3:16 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>> On Thu, Jul 13, 2017 at 12:31:11PM +0200, Martin Blumenstingl wrote:
>>> +static DEFINE_SPINLOCK(boot_lock);
>>> +
>>> +/*
>>> + * Write pen_release in a way that is guaranteed to be visible to all
>>> + * observers, irrespective of whether they're taking part in coherency
>>> + * or not.  This is necessary for the hotplug code to work reliably.
>>> + */
>>> +static void write_pen_release(int val)
>>> +{
>>> +     pen_release = val;
>>> +     smp_wmb();
>>> +     sync_cache_w(&pen_release);
>>> +}
>>
>> Hi Martin,
>>
>> This looks like a classic case of cargo-cult copying of the early ARM
>> Ltd Realview SMP code, and people really need to understand that is
>> not a good implementation to copy.  The Realview platforms are very
>> limited in what they can do: there's no power control of the CPU cores,
>> and there's no individual reset.  These platforms are evaluation
>> platforms for the CPUs, where the CPUs themselves are often "test chips".
>> They are not production systems.
>>
>> The only way to control the cores on these platforms is via software
>> loops such as the holding pen and loops in the hotplug code, since the
>> CPUs always have to be executing some code somewhere.  There are other
>> issues too which required the boot_lock (to ensure local timer
>> calibration worked.)
>>
>> None of these issues apply to production SMP platforms, so you likely do
>> not need any of this - and I see from your code that you do have power
>> and reset controls for the CPUs.  What I'm basically saying here is:
>> please rip out the holding pen and boot_lock code from your SMP
>> implementation.
>>
>> If you do need it, please include a detailed explanation why it's
>> required - requiring it suggests that the hardware is broken, and
>> probably doesn't support hotplug and therefore does not support suspend/
>> resume.
> uh, I see - thank you for the explanation!
> you are probably right when you say that it's not needed - I added it
> when implementing Meson8 support (Carlo's series only handled
> Meson8b). I couldn't get it working on Meson8 at first, but that was
> before I found out that we have to enable power through SCU first.
>
> I will remove and re-test this later - many thanks for looking into
> this (and for the detailed explanation).
> this will probably make the code much easier to read :)
and indeed, you were right: it works fine without all this pen_release
/ smp_lock code!
this also allows us to get rid of meson8_smp_secondary_init()

> one more question:
> the code uses some memory barrier macros (smp_wmb(), smp_rmb(), mb()
> and dsb_sev()).
> unfortunately I'm not very familiar with these - could you please have
> a look at this and let me know which ones you would keep or remove?
> secondary_start_kernel() is already flushing some caches, so maybe
> those barriers can also be removed
deleting the pen_release / smp_lock code also gets rid of the
smp_wmb(), mb() and dsb_sev() invocation.
there's only a dsb(); dmb(); left in
meson_smp_finalize_secondary_boot() and an smp_rmb() in
{meson8,meson8b}_smp_cpu_kill()
