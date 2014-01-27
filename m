From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 27 Jan 2014 12:28:55 +0100
Subject: [PATCH v5 07/14] ahci-platform: "Library-ise" ahci_probe
 functionality
In-Reply-To: <52E63D08.6080704@ti.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com>
 <1390417489-5354-8-git-send-email-hdegoede@redhat.com>
 <52E63778.5000509@ti.com> <52E63A1F.6080301@redhat.com>
 <52E63D08.6080704@ti.com>
Message-ID: <52E642F7.3000308@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/27/2014 12:03 PM, Roger Quadros wrote:
> On 01/27/2014 12:51 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 01/27/2014 11:39 AM, Roger Quadros wrote:
>>> Hi,
>>>
>>> On 01/22/2014 09:04 PM, Hans de Goede wrote:
>>
>> <snip>
>>
>>>> --- a/include/linux/ahci_platform.h
>>>> +++ b/include/linux/ahci_platform.h
>>>> @@ -20,7 +20,13 @@
>>>>    struct device;
>>>>    struct ata_port_info;
>>>>    struct ahci_host_priv;
>>>> +struct platform_device;
>>>>
>>>> +/*
>>>> + * Note ahci_platform_data is deprecated. New drivers which need to override
>>>> + * any of these, should instead declare there own platform_driver struct, and
>>>> + * use ahci_platform* functions in their own probe, suspend and resume methods.
>>>> + */
>>>>    struct ahci_platform_data {
>>>>        int (*init)(struct device *dev, struct ahci_host_priv *hpriv);
>>>>        void (*exit)(struct device *dev);
>>>> @@ -35,5 +41,13 @@ int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
>>>>    void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
>>>>    int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
>>>>    void ahci_platform_disable_resources(struct ahci_host_priv *hpriv);
>>>> +struct ahci_host_priv *ahci_platform_get_resources(
>>>> +    struct platform_device *pdev);
>>>
>>> Why not use 'struct device' as the argument?
>>
>> Because of calls to platform_get_resource inside the function.
>>
>>>> +void ahci_platform_put_resources(struct ahci_host_priv *hpriv);
>>>
>>> Can we have 'struct device' as the argument? Else it becomes
>>> impossible to get 'struct device' from 'hpriv' if we need to call e.g.
>>> pm_runtime_*() APIs.
>>
>> The plan for is for this function to go away once we have a
>> devm version of of_clk_get, so if you need to put pm_runtime_calls
>> somewhere, please don't put them here. This sounds like something which
>> should go in enable / disable resources instead ?
>
> OK. I need to add pm_runtime_enable() + pm_runtime_get_sync() during
> initialization and pm_runtime_put_sync() + pm_runtime_disable() during cleanup.

Note that enable / disable resources will get called by (the default implementations
of) suspend / resume too.

If that is undesirable then I take back what I said before and
ahci_platform_put_resources' prototype should be changed to:

void ahci_platform_put_resources(struct device *dev, struct ahci_host_priv *hpriv);

And we will need to keep it around even after we get devm_of_clk_get.

> If ahci_platform_enable/disable_resources is the right place then we must be
> able to access struct device from there.

Right, and if not we need to access it from ahci_platform_put_resources(),
which is in essence the same problem.

> Is it a good to add 'struct device *dev' into the 'struct ahci_host_priv'?
> Then you can leave this series as is and i'll add a new patch for that.

Normally we get a device * as argument, and get to hpriv like this:

         struct ata_host *host = dev_get_drvdata(dev);
         struct ahci_host_priv *hpriv = host->private_data;

So having a dev * in hpriv is normally not useful.

But the ata_host gets allocated after the first ahci_platform_enable_resources
call, so we cannot use this there. Likewise disable_resources / put_resources
is used in error handling paths in probe where we don't have an ata_host yet,
so my vote goes to adding a "struct device *dev" as first argument, like I
suggested above for ahci_platform_put_resources.

This can be done as an add-on patch (if you do don't forget to also fix
ahci_sunxi.c and ahci_imx.c), or I can respin my series to have this from
day one.

If you want me to do a respin, please let me know which fix you'll need
(the put_resources or the enable/disable one).

Thanks & Regards,

Hans
