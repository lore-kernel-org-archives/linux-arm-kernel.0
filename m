From: rogerq@ti.com (Roger Quadros)
Date: Mon, 27 Jan 2014 13:03:36 +0200
Subject: [PATCH v5 07/14] ahci-platform: "Library-ise" ahci_probe
 functionality
In-Reply-To: <52E63A1F.6080301@redhat.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com>
 <1390417489-5354-8-git-send-email-hdegoede@redhat.com>
 <52E63778.5000509@ti.com> <52E63A1F.6080301@redhat.com>
Message-ID: <52E63D08.6080704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2014 12:51 PM, Hans de Goede wrote:
> Hi,
> 
> On 01/27/2014 11:39 AM, Roger Quadros wrote:
>> Hi,
>>
>> On 01/22/2014 09:04 PM, Hans de Goede wrote:
> 
> <snip>
> 
>>> --- a/include/linux/ahci_platform.h
>>> +++ b/include/linux/ahci_platform.h
>>> @@ -20,7 +20,13 @@
>>>   struct device;
>>>   struct ata_port_info;
>>>   struct ahci_host_priv;
>>> +struct platform_device;
>>>
>>> +/*
>>> + * Note ahci_platform_data is deprecated. New drivers which need to override
>>> + * any of these, should instead declare there own platform_driver struct, and
>>> + * use ahci_platform* functions in their own probe, suspend and resume methods.
>>> + */
>>>   struct ahci_platform_data {
>>>       int (*init)(struct device *dev, struct ahci_host_priv *hpriv);
>>>       void (*exit)(struct device *dev);
>>> @@ -35,5 +41,13 @@ int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
>>>   void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
>>>   int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
>>>   void ahci_platform_disable_resources(struct ahci_host_priv *hpriv);
>>> +struct ahci_host_priv *ahci_platform_get_resources(
>>> +    struct platform_device *pdev);
>>
>> Why not use 'struct device' as the argument?
> 
> Because of calls to platform_get_resource inside the function.
> 
>>> +void ahci_platform_put_resources(struct ahci_host_priv *hpriv);
>>
>> Can we have 'struct device' as the argument? Else it becomes
>> impossible to get 'struct device' from 'hpriv' if we need to call e.g.
>> pm_runtime_*() APIs.
> 
> The plan for is for this function to go away once we have a
> devm version of of_clk_get, so if you need to put pm_runtime_calls
> somewhere, please don't put them here. This sounds like something which
> should go in enable / disable resources instead ?

OK. I need to add pm_runtime_enable() + pm_runtime_get_sync() during
initialization and pm_runtime_put_sync() + pm_runtime_disable() during cleanup.

If ahci_platform_enable/disable_resources is the right place then we must be
able to access struct device from there. 

Is it a good to add 'struct device *dev' into the 'struct ahci_host_priv'?
Then you can leave this series as is and i'll add a new patch for that.

If there is a better way, please let me know.

cheers,
-roger
