From: rafael@kernel.org (Rafael J. Wysocki)
Date: Sat, 24 Feb 2018 10:47:26 +0100
Subject: [PATCH] PCIe bridge deferred probe breaks suspend resume
In-Reply-To: <CAJZ5v0hDM=DtBZA1awz7ao62cpe4CAhUz1L7KkLTv=G3YQhuEw@mail.gmail.com>
References: <1519433209-14581-1-git-send-email-fkan@apm.com>
 <CAJZ5v0hDM=DtBZA1awz7ao62cpe4CAhUz1L7KkLTv=G3YQhuEw@mail.gmail.com>
Message-ID: <CAJZ5v0jJMODOsZV41Jn18LCtttMemFQyXonJxZnUgXday8_4iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 24, 2018 at 10:35 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Sat, Feb 24, 2018 at 1:46 AM, Feng Kan <fkan@apm.com> wrote:
>> This is not a patch, but rather a question regarding the deferred
>> probe's effect on PCIe PM ordering. This happens on our system
>> which defer the probing of root bridge due to  the IOMMU not being
>> ready. Because of the deferred action, the bridge is moved to the
>> end of the dpm_list which results in incorrect suspend and resume
>> sequence.
>>
>> In the cases I have seen, the bridge is always reordered because of
>> startup sequence. They are always place after the endpoint. If that
>> is the case the following code should be able to prevent such cases.
>> However, is there some cases here that would violate such situation?
>
> The code in dd.c assumes that the device being probed has no children
> (or consumers, for that matter) and so it is safe to move it to the
> end of the list.
>
> If the device has children (or consumers), moving it to the end of the
> list by itself doesn't work, which is the case for you.
>
>> ---
>>  drivers/base/dd.c | 20 +++++++++++---------
>>  1 file changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index de6fd09..5b96d5c 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -116,15 +116,17 @@ static void deferred_probe_work_func(struct work_struct *work)
>>                  */
>>                 mutex_unlock(&deferred_probe_mutex);
>>
>> -               /*
>> -                * Force the device to the end of the dpm_list since
>> -                * the PM code assumes that the order we add things to
>> -                * the list is a good order for suspend but deferred
>> -                * probe makes that very unsafe.
>> -                */
>> -               device_pm_lock();
>> -               device_pm_move_last(dev);
>> -               device_pm_unlock();
>> +                if (!dev_is_pci(dev)) {
>
> You can't do this here.
>
> It is not clear why all PCI devices should be an exception in the
> first place.  There may be PCI devices without children that need to
> be moved to the end of the list and you'd break that case.
>
>> +                        /*
>> +                         * Force the device to the end of the dpm_list since
>> +                         * the PM code assumes that the order we add things to
>> +                         * the list is a good order for suspend but deferred
>> +                         * probe makes that very unsafe.
>> +                         */
>> +                        device_pm_lock();
>> +                        device_pm_move_last(dev);
>> +                        device_pm_unlock();
>> +                }
>>
>>                 dev_dbg(dev, "Retrying from deferred list\n");
>>                 if (initcall_debug && !initcalls_done)
>> --
>
> You can try to replace the device_pm_move_last(dev) in
> deferred_probe_work_func(struct() with device_reorder_to_tail(), but
> that has to be called under device_links_read_lock/unloc () and
> device_pm_lock/unloc() (in the right order).

Alternatively, you can replace your !dev_is_pci(dev) check with a
check for the presence of children or consumers and only move the
device to the end of the PM list if there are not any.  That would
kind of make sense, but it may break other assumptions in the deferred
probing mechanism which I don't recall ATM.

Or avoid deferred probing of the host bridge driver entirely.  I guess
you can use it with limited functionality until the IOMMU driver is
ready and switch over to the fully functional operation mode when that
happens, but that would need to hook into the IOMMU code somehow.
