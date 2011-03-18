From: khilman@ti.com (Kevin Hilman)
Date: Fri, 18 Mar 2011 08:06:47 -0700
Subject: [PATCH v2 4/7] OMAP: PM CONSTRAINTS: implement the constraints
	management code
In-Reply-To: <AANLkTin4T1Tk88Ud-TSQ1SOEWuZnv-XXwm8V2wUSUvr_@mail.gmail.com>
	(Jean Pihet's message of "Fri, 18 Mar 2011 12:33:22 +0100")
References: <1299779247-20511-1-git-send-email-j-pihet@ti.com>
	<1299779247-20511-5-git-send-email-j-pihet@ti.com>
	<874o71zdpu.fsf@ti.com>
	<AANLkTin4T1Tk88Ud-TSQ1SOEWuZnv-XXwm8V2wUSUvr_@mail.gmail.com>
Message-ID: <87ipvgo4c8.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

[...]

>>> +exit_ok:
>>> + ? ? /* Find the strongest constraint for the given target */
>>> + ? ? ret = 0;
>>> + ? ? if (ascending) {
>>> + ? ? ? ? ? ? list_for_each_entry(user, &(constraints_list)->node_list,
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? node.plist.node_list) {
>>> + ? ? ? ? ? ? ? ? ? ? /* Find the lowest (i.e. first) value for the target */
>>> + ? ? ? ? ? ? ? ? ? ? if (user->target == target) {
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ret = user->constraint_value;
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
>>> + ? ? ? ? ? ? ? ? ? ? }
>>> + ? ? ? ? ? ? }
>>> + ? ? } else {
>>> + ? ? ? ? ? ? list_for_each_entry_reverse(user,
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &(constraints_list)->node_list,
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? node.plist.node_list) {
>>> + ? ? ? ? ? ? ? ? ? ? /* Find the highest (i.e. last) value for the target */
>>> + ? ? ? ? ? ? ? ? ? ? if (user->target == target) {
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ret = user->constraint_value;
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
>>> + ? ? ? ? ? ? ? ? ? ? }
>>> + ? ? ? ? ? ? }
>>> + ? ? }
>>
>> Hmm, why can't you use plist_first() and plist_last() here?
> Because the plist is sorted by the 'prio' field (which is 'value' in
> this code) and this function searches for the strongest constraint for
> a given target. So it is needed to iterate through the list in order
> to find the first (or last) constraint with the right target.

Hmm, still confusing.

The main thing I don't get is why you need the 'target' field in the
first place.  You should just keep a list of constraints per target
omap_device.  IOW, currently your _wkup_lat_constraints_list is a global
list, but instead it should be connected to the omap_device, and each
omap_device would have a plist for each class.


>>
>>> +exit_error:
>>> + ? ? mutex_unlock(&_constraints_mutex);
>>> +
>>> + ? ? return ret;
>>> +}
>>>
>>> ?/* Public functions for use by core code */
>>>
>>> ?/**
>>> + * omap_device_set_dev_constraint - set/release a device constraint
>>> + * @class: constraint class
>>> + * @req_dev: constraint requester, used for tracking the constraints
>>> + * @dev: device to apply the constraint to. Must have an associated omap_device
>>> + * @t: constraint value. A value of -1 removes the constraint.
>>> + *
>>> + * Using the primary hwmod, set/release a device constraint for the dev
>>> + * device, requested by the req_dev device. Depending of the constraint class
>>> + * this code calls the appropriate low level code, e.g. power domain for
>>> + * the wake-up latency constraints.
>>> + *
>>> + * If any hwmods exist for the omap_device assoiated with @dev,
>>> + * set/release the constraint for the corresponding hwmods, otherwise return
>>> + * -EINVAL.
>>> + */
>>> +int omap_device_set_dev_constraint(enum omap_pm_constraint_class class,
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct device *req_dev,
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct device *dev, long t)
>>> +{
>>> + ? ? struct omap_device *od;
>>> + ? ? struct omap_hwmod *oh;
>>> + ? ? struct platform_device *pdev;
>>> + ? ? struct powerdomain *pwrdm = NULL;
>>> + ? ? u32 ret = -EINVAL;
>>> +
>>> + ? ? /* Look for the platform device for dev */
>>> + ? ? pdev = to_platform_device(dev);
>>> +
>>> + ? ? /* Try to catch non platform devices. */
>>> + ? ? if (pdev->name == NULL) {
>>
>> This should check for a valid omap_device, not platform_device.
> This check remains but the check below is changed, see below.

What I mean is this should check for omap_device_parent to see if the
struct device is an omap_device.   IOW, you care whether or not it's an
omap_device, not whether or not it's a valid platform_device.

Kevin
