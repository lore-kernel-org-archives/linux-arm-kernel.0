From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Oct 2015 14:41:07 -0500
Subject: [RFC/PATCH 11/11] arm: boot: dts: omap: add missing default
 status for 32k counter
In-Reply-To: <20151005175230.GG18784@saruman.tx.rr.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <4815825.NCBBBMgLGf@wuerfel> <20150930141209.GB31865@saruman.tx.rr.com>
 <22213826.1MtkNIZ6W3@wuerfel> <20151005175230.GG18784@saruman.tx.rr.com>
Message-ID: <87io6lf6i4.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

> On Wed, Sep 30, 2015 at 11:58:16PM +0200, Arnd Bergmann wrote:
>> On Wednesday 30 September 2015 09:12:09 Felipe Balbi wrote:
>> > On Wed, Sep 30, 2015 at 10:15:25AM +0200, Arnd Bergmann wrote:
>> > > On Tuesday 29 September 2015 15:44:06 Felipe Balbi wrote:
>> > > > All devices should have a default status. Ignoring
>> > > > the arguments if it should be 'okay' or 'disabled'
>> > > > by default, let's set them all the 'disabled' and
>> > > > have boards enable 32k counter.
>> > > > 
>> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
>> > > > 
>> > > 
>> > > The patch looks good, but the description is slightly incorrect:
>> > > There is no reason to list "status='okay'" other than overriding
>> > > the 'disabled' status.
>> > > 
>> > > I'd phrase it something like:
>> > > 
>> > > "We want the use of the 32k counter to be a per-board setting,
>> > > so let's disable it by default in each dtsi file and override the
>> > > setting in the boards. Any board that does not wire up the counter
>> > > should leave it disabled".
>> > > 
>> > > However, if you really want all boards to provide the counter all
>> > > the time, I'd argue that we're better off dropping this patch. We
>> > > use the status="disabled" trick for anything that may or may not
>> > > be working based on the board design, but things that are present
>> > > everywhere don't need this.
>> > 
>> > okay, so here's the thing. While fiddling with the 32k counter, I noticed
>> > that even though there was no status listed, the thing still initializes
>> > fine. However, when moving 32k to drivers/clocksource and using
>> > CLOCKSOURCE_OF_DECLARE(), 32k would *NOT* probe unless I had an explicit
>> > status = "okay" in DT.
>> 
>> Very strange, that sounds like a bug in the clocksource probe code.
>> Can you check how this happens?
>
> seems like something overwrites counter's status field, here's a snippet of boot
> log:
>
> [    0.000000] ===> counter is available ??
> [    0.000000] ===> no status -> TRUE!!
> [    0.000000] ===> searching for timer
> [    0.000000] ===> timer is available ??
> [    0.000000] ===> no status -> TRUE!!
> [    0.000005] sched_clock: 64 bits at 1000MHz, resolution 1ns, wraps every 4398046511103ns
> [    0.000014] clocksource: arm_global_timer: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> [    0.000047] ===> searching for timer
> [    0.000051] ===> timer is available ??
> [    0.000054] ===> no status -> TRUE!!
> [    0.000307] ===> searching for counter
> [    0.000311] ===> counter is available ??
> [    0.000315] ===> counter status disabled
> [    0.000318] ====> counter NOT available
>
> note that first time around counter had no status and later it got a status
> disabled from somewhere.

found it. arch/arm/mach-omap2/timer.c is the culprit:

/**
 * omap_get_timer_dt - get a timer using device-tree
 * @match	- device-tree match structure for matching a device type
 * @property	- optional timer property to match
 *
 * Helper function to get a timer during early boot using device-tree for use
 * as kernel system timer. Optionally, the property argument can be used to
 * select a timer with a specific property. Once a timer is found then mark
 * the timer node in device-tree as disabled, to prevent the kernel from
 * registering this timer as a platform device and so no one else can use it.
 */
static struct device_node * __init omap_get_timer_dt(const struct of_device_id *match,
						     const char *property)
{
	struct device_node *np;

	for_each_matching_node(np, match) {
		if (!of_device_is_available(np))
			continue;

		if (property && !of_get_property(np, property, NULL))
			continue;

		if (!property && (of_get_property(np, "ti,timer-alwon", NULL) ||
				  of_get_property(np, "ti,timer-dsp", NULL) ||
				  of_get_property(np, "ti,timer-pwm", NULL) ||
				  of_get_property(np, "ti,timer-secure", NULL)))
			continue;

		of_add_property(np, &device_disabled);
		return np;
	}

	return NULL;
}

I'll patch this up and drop $subject

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/8966de69/attachment.sig>
