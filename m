From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 01 Jul 2014 15:21:41 +0200
Subject: [PATCH 4/4] ARM: mvebu: add armada drm init to Dove board setup
In-Reply-To: <20140701131026.GO32514@n2100.arm.linux.org.uk>
References: <1404219871-18419-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1404219871-18419-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140701131026.GO32514@n2100.arm.linux.org.uk>
Message-ID: <53B2B5E5.50502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2014 03:10 PM, Russell King - ARM Linux wrote:
> On Tue, Jul 01, 2014 at 03:04:31PM +0200, Sebastian Hesselbarth wrote:
>> +	pdev = platform_device_register_full(&armada_drm_dev_info);
>> +	/* assign last found lcd node to drm device for clk lookup */
>> +	pdev->dev.of_node = clknp;
>
> NAK.  This really isn't a good way to deal with this, even in a
> temporary basis.  While assigning a DT node to a manually created
> platform device does solve that problem, it also introduces the
> problem that this platform device will now match any platform driver
> which recognises the "marvell,dove-lcd" compatible type, which may
> occur _before_ we find the driver to match using the legacy strings.

Right, I never said it is a good solution but there is no driver for
"marvell,dove-lcd" *and* there is no way to assign clock aliases for
clocks not yet registered.

> There really isn't an easy solution to this other than doing the thing
> properly.

Well, you may have noticed that three moving subsystems plus new
bindings plus non-DT/DT drivers quickly create some kind of patch
deadlock. This is a dirty but tiny step to resolve one of those
deadlocks.

> The other problem in this series is that while you introduce some
> bindings which may work today, they're not going to work tomorrow, and
> that's a problem.  Don't do DT piecemeal like this and end up having to
> break the bindings (which we will have to do to add the endpoints.)

Adding new properties/subnodes never has been a problem for us at all.
New generic bindings were introduced *often* in the past and added to
existing bindings, e.g. clocks, gpio, pinctrl.

The proposed binding for dove-lcd simply reflects the tiny part that
is mandatory for identifying the lcd controllers. It only contains
reg and interrupts which would also be in the corresponding
platform_device.

> If you want to do this then you need to add the endpoints from the start
> even though the driver doesn't yet make use of them - or don't add the
> DT bits at all.

If you really think that way, I definitely give up on mainline Dove and
SolidRun Cubox. You are /really/ proposing to wait for *all* related
subsystem bindings to settle before even starting to add DT support?

Sebastian
