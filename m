From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 30 Jan 2015 07:03:03 -0500
Subject: [PATCH v10 2/2] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <20150130101838.GC16744@ulmo>
References: <sc9836-serial-v10>
 <1422443324-25082-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1422443324-25082-3-git-send-email-chunyan.zhang@spreadtrum.com>
 <54CA5128.8050500@gmail.com> <54CA568E.6080306@hurleysoftware.com>
 <20150129160553.GC26493@n2100.arm.linux.org.uk> <20150130101838.GC16744@ulmo>
Message-ID: <54CB72F7.8060706@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2015 05:18 AM, Thierry Reding wrote:
> On Thu, Jan 29, 2015 at 04:05:53PM +0000, Russell King - ARM Linux wrote:
>> On Thu, Jan 29, 2015 at 10:49:34AM -0500, Peter Hurley wrote:
>>> Hi Varka,
>>>
>>> On 01/29/2015 10:26 AM, Varka Bhadram wrote:
>>>> This check is not required. It will be done by devm_ioremap_resource()
>>>
>>> I disagree. devm_ioremap_resource() interprets the NULL resource as
>>> a bad parameter and returns -EINVAL which is then forwarded as the
>>> return value from the probe.
>>>
>>> -ENODEV is the correct return value from the probe if the expected
>>> resource is not available (either because it doesn't exist or was already
>>> claimed by another driver).
>>
>> (Adding Thierry as the author of this function.)
>>
>> I believe devm_ioremap_resource() was explicitly designed to remove such
>> error handling from drivers, and to give drivers a unified error response
>> to such things as missing resources.
>>
>> See the comments for this function in lib/devres.c.
> 
> Right. Before the introduction of this function drivers would copy the
> same boilerplate but would use completely inconsistent return codes.
> Well, to be correct devm_request_and_ioremap() was introduced first to
> reduce the boilerplate, but one of the problems was that it returned a
> NULL pointer on failure, so it was impossible to distinguish between
> specific error conditions. It also had the negative side-effect of not
> giving drivers any directions on what to do with the NULL return value
> other than the example in the kerneldoc. But most people just didn't
> seem to look at that, so instead of using -EADDRNOTAVAIL they'd again
> go and do completely inconsistent things everywhere.
> 
> When we introduced devm_ioremap_resource(), the idea was to remove any
> of these inconsistencies once and for all. You call the function and if
> it fails you simply propagate the error code, so you get consistent
> behaviour everywhere.
> 
> If I remember correctly the error codes for the various conditions were
> discussed quite extensively, and what we currently have is what we got
> by concensus.
> 
> -ENODEV is certainly not the correct return value if a resource is not
> available. It translates to "no such device", but the device must
> clearly be there, otherwise the ->probe() shouldn't have been called.

-ENODEV is the appropriate return from the probe(); there is no device.
That returning that value doesn't make sense from devm_ioremap_resource
is simply a reflection of the awkward construct.

> Or if it really isn't there, then you'd at least need a memory region
> to probe, otherwise you can't determine whether it's there or not. So
> from the perspective of a device driver I think a missing, or NULL,
> resource, is indeed an "invalid argument".

Trying to argue that a missing host bus window is an "invalid argument"
to probe() is just trying to make the shoe fit.

> I understand that people might see some ambiguity there, and -EINVAL is
> certainly not a very accurate description, but such is the nature of
> error codes. You pick what fits best. -ENXIO and -EADDRNOTAVAIL had been
> under discussion as well if I remember correctly, but they both equally
> ambiguous. -ENODATA might have been a better fit, but that too has a
> different meaning in other contexts.
> 
> Besides, there's an error message that goes along with the error code
> return, that should remove any ambiguity for people looking at dmesg.
> 
> All of that said, the original assertion that the check is not required
> is still valid. We can argue at length about the specific error code but
> if we decide that it needs to change, then we should modify
> devm_ioremap_resource() rather than requiring all callers to perform the
> extra check again.

None of the devm_ioremap_resource() changes have been submitted for
serial drivers. I see no problem with accepting the Spreadtrum driver
as is, and if someone wants to do a massive changeset to rework the
platform_get_resource()/devm_ioremap_resource() idiom for serial drivers
for 3.21, then the Spreadtrum driver would be included then.

That said, I'd prefer to see that idiom wrapped in a single function
rather than what's being suggested.

Regards,
Peter Hurley
