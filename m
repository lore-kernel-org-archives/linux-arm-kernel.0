From: s-anna@ti.com (Suman Anna)
Date: Tue, 13 Jan 2015 16:53:38 -0600
Subject: [RFC PATCH 2/3] core: platform: fix an invalid kfree during
 of_platform_depopulate
In-Reply-To: <CAL_JsqK8ZAUZwd1zjjZ57MQZ+KD-_qiCyMXnhQ-zZ38wxUtf-g@mail.gmail.com>
References: <1420651854-17768-1-git-send-email-s-anna@ti.com>
 <1420651854-17768-3-git-send-email-s-anna@ti.com>
 <CAL_JsqK8ZAUZwd1zjjZ57MQZ+KD-_qiCyMXnhQ-zZ38wxUtf-g@mail.gmail.com>
Message-ID: <54B5A1F2.8010207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 01/13/2015 04:27 PM, Rob Herring wrote:
> On Wed, Jan 7, 2015 at 11:30 AM, Suman Anna <s-anna@ti.com> wrote:
>> Drivers can use of_platform_populate() to create platform devices
>> for children of the device main node, and a complementary API
>> of_platform_depopulate() is provided to delete these child devices.
>> Any platform_data supplied for the OF devices through auxdata lookup
>> data is populated directly in the device's platform_data field, unlike
>> those created using platform API. The of_platform_depopulate()
>> leverages the platform code for cleanup, and this will result in a
>> kernel oops due to an invalid kfree on this direct populated
>> platform_data.
>>
>> Fix this by resetting the platform data for OF devices during
>> platform device cleanup.
> 
> We should probably copy the platform_data like is done for non-OF
> platform devices. I'm sure there was some reason for it. 

Yeah, that was my first thought too, but went with adding a checking
here as I am not aware of the original reason for not copying it, and it
seemed like unnecessary copying of static data without any real gain.

> It looks strange doing this in release.
> 
> However, I'm inclined to not fix this and force users to move off of
> auxdata. That's intended to be a temporary migration path and there
> are only 54 instances of it that have platform_data. What device do
> you care about?

I use this mainly for the remoteproc devices (mainly differentiating
multiple instances of the same compatible type on the same SoC), but
fair enough, I can rework my driver to use some lookup based match data
instead. So far, none of the drivers who use of_platform_populate() did
supply platform data, so this particular crash is not seen/common.
platform_data does get used in the OMAP pdata-quirks, though
of_platform_depopulate() won't be called on those, as this is called in
init_machine.

regards
Suman

> 
> Rob
> 
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  drivers/base/platform.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index 9421fed40905..129e69c8c894 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -200,6 +200,8 @@ static void platform_device_release(struct device *dev)
>>         struct platform_object *pa = container_of(dev, struct platform_object,
>>                                                   pdev.dev);
>>
>> +       if (pa->pdev.dev.of_node)
>> +               pa->pdev.dev.platform_data = NULL;
>>         of_device_node_put(&pa->pdev.dev);
>>         kfree(pa->pdev.dev.platform_data);
>>         kfree(pa->pdev.mfd_cell);
>> --
>> 2.2.1
>>
