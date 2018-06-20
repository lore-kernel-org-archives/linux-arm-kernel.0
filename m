From: javierm@redhat.com (Javier Martinez Canillas)
Date: Wed, 20 Jun 2018 11:48:03 +0200
Subject: [PATCH] driver core: add a debugfs entry to show deferred devices
In-Reply-To: <ea628ded-3cb3-c426-da6d-bf7cb51f4ca8@redhat.com>
References: <20180619205914.21375-1-javierm@redhat.com>
 <20180619225145.GA23389@kroah.com>
 <ea628ded-3cb3-c426-da6d-bf7cb51f4ca8@redhat.com>
Message-ID: <91484651-b5ab-c971-e66e-92d268fd65c0@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Peter Robinson - Fedora IoT Architect to cc list]

On 06/20/2018 10:46 AM, Javier Martinez Canillas wrote:
> On 06/20/2018 12:51 AM, Greg Kroah-Hartman wrote:
> 
> [snip]
> 
>>> @@ -233,6 +252,9 @@ void device_unblock_probing(void)
>>>   */
>>>  static int deferred_probe_initcall(void)
>>>  {
>>> +	debugfs_create_file("deferred_devices", 0444, NULL, NULL,
>>> +			    &deferred_devs_fops);
>>
>> In the root of debugfs?
>>
> 
> I added in the root for lack of a better place. Any suggestion is welcomed.
>  
>> Anyway, what about "devices_deferred", to help keep things semi-sane if
>> we have other driver core debugfs entries?
>>
> 
> I don't have a strong opinion on the name really, so I'll change it.
>  
>> And you don't remove the file ever?
>>
> 
> Yeah, I saw that it wasn't removed in other places for debugfs entries
> created by the core since unlike drivers they can't be built as a module
> or re-loaded. But you are right, I'll add an __exitcall to remove there.
>  
>> And what is the use of this file?  What can you do with this
>> information?  Who is going to use it?  Don't we have other deferred
> 
> This patch is the result of a discussion with Tomeu and Mark (cc'ed) to
> allow https://kernelci.org to test if there was a regression that makes
> drivers to defer their probe.
> 
> The problem with the probe deferral mechanism is that you don't have a
> way to distinguish between a valid deferral due a dependency not being
> available yet and a bug (i.e: wrong DTB, config symbol not enabled, etc)
> that prevents the device to eventually being probed.
>

This is not only useful for catching regressions though, Peter also told me
that having this information would save him a lot of time when doing hardware
bringup for ARM devices / IoT platforms.

As mentioned, debugging probe deferral issues caused by drivers not available
or wrong Device Trees is really a PITA. Not all architectures have the luxury
of ACPI / PnP / auto enumerable buses / etc, that hide all this complexity.

So the most information to troubleshoot we have, the better in my opinion.

>> probe debugging somewhere else?
>>
> 
> There is some debug yes, but it isn't suitable for the use case I explained.
> 
> For start, it only tells you if a given driver for a device was deferred or
> probed correctly while this patch attempts to tell what was left (if any)
> in the queue after the last driver was registered.
> 
> Second, is only enabled until late_initcall so it will only print the probe
> deferral for built-in drivers and not for modules. This patch registers the
> debugfs entry after the probe debugging has been disabled.
> 
>> thanks,
>>
>> greg k-h
>>

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
