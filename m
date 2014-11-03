From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 03 Nov 2014 09:00:29 -0800
Subject: pm_runtime_enable() in ->probe()
In-Reply-To: <3099111.MYm8ByzLAF@vostro.rjw.lan> (Rafael J. Wysocki's message
 of "Sat, 01 Nov 2014 02:14:14 +0100")
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <5370046.DXkB0EA6xC@vostro.rjw.lan>
 <42875843.yieZ2al8Y2@vostro.rjw.lan>
 <3099111.MYm8ByzLAF@vostro.rjw.lan>
Message-ID: <7hwq7ci5hu.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Saturday, November 01, 2014 02:08:57 AM Rafael J. Wysocki wrote:
>> On Saturday, November 01, 2014 01:20:38 AM Rafael J. Wysocki wrote:
>> > On Friday, October 31, 2014 10:16:14 AM Ulf Hansson wrote:
>> > > On 24 October 2014 18:12, Kevin Hilman <khilman@kernel.org> wrote:
>> 
>> [cut]
>> 
>> > > 
>> > > 1)
>> > > It's bad practice to use pm_runtime_get_sync() in the ->probe() path,
>> > 
>> > Honestly, I'm no longer amused.
>> > 
>> > > to bring your resources to full power. The consequence would be a
>> > > driver that requires CONFIG_PM_RUNTIME to be even functional, which
>> > > just isn't acceptable.
>> > 
>> > Sorry, but this is utter nonsense.
>> > 
>> > CONFIG_PM_RUNTIME unset means "no runtime PM at all", so all drivers can expect
>> > everything they need to be always on.  If that is not the case, then someone is
>> > doing runtime PM behind the scenes and therefore cheating.  Or in different
>> > words, for CONFIG_PM_RUNTIME unset bus types, platforms etc must ensure that
>> > everything is on from the drivers' perspective.
>> > 
>> > If that is the case, then calling pm_runtime_get_sync() from ->probe
>> > for CONFIG_PM_RUNTIME unset simply doesn't matter.
>> > 
>> > Now, for CONFIG_PM_RUNTIME enabled, if power domains are in use, doing
>> > pm_runtime_get_sync() from ->probe is the only way the driver can ensure
>> > in a non-racy way that the device will be accessible going forward.
>> > 
>> > Why?  Simply because the probing need not happen during system initialization.
>> > It very well may take places when the other devices in the same domain have
>> > beein in use for quite a while and have been using runtime PM (in which
>> > case the domain may go off at any time unless it is explicityly prevented from
>> > doing that).
>> > 
>> > One thing that you may be missing is that, for CONFIG_PM_RUNTIME set,
>> > runtime PM has to be either enabled or disabled for all devices in one
>> > domain (and if it is disabled, then the domain needs to be always on for
>> > all practical purposes).  Otherwise you can't just make all of them happy
>> > at the same time.  The documentation doesn't cover this, because it had been
>> > written before we even started to consider power domains.
>> > 
>> > > Drivers that behaves well within this context, follows the runtime PM
>> > > documentation/recommendation.
>> > 
>> > So please go to Documentation/power/runtime_pm.txt and read it again.  Quote:
>> > 
>> > "If the default initial runtime PM status of the device (i.e. 'suspended')
>> > reflects the actual state of the device, its bus type's or its driver's
>> > ->probe() callback will likely need to wake it up using one of the PM core's
>> > helper functions described in Section 4.  In that case, pm_runtime_resume()
>> > should be used.  Of course, for this purpose the device's runtime PM has to be
>> > enabled earlier by calling pm_runtime_enable()."
>> 
>> All that said there is a logical error related to calling pm_runtime_enable()
>> and its derivatives from ->probe() that I've been overlooking pretty much
>> from the start.
>> 
>> Namely, really_probe() sets dev->driver to drv before calling ->probe()
>> for either the bus type or the driver itself, so if the driver's probe
>> calls pm_runtime_enable(), it will execute the driver's own runtime PM
>> resume callback before the driver can check whether or not it wants to handle
>> the device in the first place.  That doesn't sound quite right to me.
>> 
>> This means we need a different mechanism to ensure that the device will
>> be accessible to the driver and/or the bus type in ->probe().
>> 
>> At one point we had pm_runtime_get_sync() before really_probe() in
>> driver_proble_device() IIRC, but people complained about it, so we dropped it
>> and put a barrier in there instead, but that's not sufficient.
>
> So we actually had pm_runtime_get_noresume() before the barrier, but then
> we dropped it due to complaints.
>
>> We need to explicitly ensure that the device won't be powered off while
>> ->probe() is in progress *but* we need to avoid calling the driver's runtime
>> PM resume callback before ->probe() returns.
>
> I wonder, then, if we just need to do pm_runtime_get_sync() instead of the
> barrier and then pm_runtime_put() instead of pm_request_idle() in
> driver_probe_device()?

Won't we still have the same problems in the case of ->probe failure
that were fixed by removing those calls[1]?

IOW, after the driver's ->probe returns failure, it's no longer safe to
call the driver's runtime PM callbacks, since they may be accessing
resources that no longer exits.

Hmm, thinking a little more, maybe this kind of failure is a good time
for the driver to use pm_runtime_force_suspend(), then later when the PM
core does the _put(), it will see the device aleady suspended and there
shouldn't be any problems.

So I think I'm OK with this approach, in theory.

Kevin

[1]
commit eed5d2150752bd08b22333d739f3120151773d28
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Thu Jul 12 11:51:48 2012 +0200

    PM / Runtime: Do not increment device usage counts before probing

    The pm_runtime_get_noresume() calls before really_probe() and
    before executing __device_attach() for each driver on the
    device's bus cause problems to happen if probing fails and if the
    driver has enabled runtime PM for the device in its .probe()
    callback.  Namely, in that case, if the device has been resumed
    by the driver after enabling its runtime PM and if it turns out that
    .probe() should return an error, the driver is supposed to suspend
    the device and disable its runtime PM before exiting .probe().
    However, because the device's runtime PM usage counter was
    incremented by the core before calling .probe(), the driver's attempt
    to suspend the device will not succeed and the device will remain in
    the full-power state after the failing .probe() has returned.

    To fix this issue, remove the pm_runtime_get_noresume() calls from
    driver_probe_device() and from device_attach() and replace the
    corresponding pm_runtime_put_sync() calls with pm_runtime_idle()
    to preserve the existing behavior (which is to check if the device
    is idle and to suspend it eventually in that case after probing).

    Reported-and-tested-by: Kevin Hilman <khilman@ti.com>
    Reviewed-by: Kevin Hilman <khilman@ti.com>
    Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
