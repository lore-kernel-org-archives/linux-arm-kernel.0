From: jcm@redhat.com (Jon Masters)
Date: Thu, 15 Jan 2015 10:51:58 -0500
Subject: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <CACxGe6tjiE6u8i-1PHYzX2cOhxJkYN3cV9mqhCHRSMRdOQRfzg@mail.gmail.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1797489.PjmKzBFdQA@wuerfel>
 <20150106112000.GA8829@e104818-lin.cambridge.arm.com>
 <3538097.dWBy3R9lty@wuerfel>
 <CACxGe6tjiE6u8i-1PHYzX2cOhxJkYN3cV9mqhCHRSMRdOQRfzg@mail.gmail.com>
Message-ID: <54B7E21E.2000901@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2015 09:10 AM, Grant Likely wrote:
> On Tue, Jan 6, 2015 at 1:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tuesday 06 January 2015 11:20:01 Catalin Marinas wrote:
>>> On Mon, Jan 05, 2015 at 08:16:30PM +0000, Arnd Bergmann wrote:
>>>> On Monday 05 January 2015 13:13:02 Catalin Marinas wrote:
>>>>>> since passing no DT tables to OS but
>>>>>> acpi=force is missing is a corner case, we can do a follow up patch to
>>>>>> fix that, does it make sense?
>>>>>
>>>>> Not entirely. Why would no dtb and no acpi=force be a corner case? I
>>>>> thought this should be the default when only ACPI tables are passed, no
>>>>> need for an additional acpi=force argument.
>>>>
>>>> We don't really support the case of only ACPI tables for now. The expectation
>>>> is that you always have working DT support, at least for the next few years
>>>> as ACPI features are ramping up, and without acpi=force it should not try
>>>> to use ACPI at all.
>>>
>>> So if both DT and ACPI are present, just use DT unless acpi=force is
>>> passed. So far I think we agree but what I want to avoid is always
>>> mandating acpi=force even when the DT tables are missing (in the long
>>> run).
>>>
>>> Now, what's preventing a vendor firmware from providing only ACPI
>>> tables? Do we enforce it in some way (arm-acpi.txt, kernel warning etc.)
>>> that both DT and ACPI are supported, or at least that dts files are
>>> merged in the kernel first?
>>
>> We have no way of enforcing what a board vendor ships, so if they want
>> to have ACPI-only machines for MS Windows, they just won't work by
>> default on Linux. Once ACPI support is mature enough, we can also
>> have a whitelist or a different default for using it automatically
>> when no DT is present.
>>
>> For drivers merged upstream, I would insist that every driver merged
>> for an ARM64 platform has a documented DT binding that is used in the
>> driver.
> 
> That's a dumb rule. It will result in untested DT code paths being
> thrown into drivers just too meet the rules rather than on whether or
> not they will actually be used. It's fine to allow driver authors to
> only implement the ACPI code path if that is what they are working
> with. We can *always* add a DT path to the driver when it is needed.

It gets worse. There *will* be large numbers of ACPI only ARM servers
landing over the coming year. Not only would DT code be untested, but
insisting on keeping e.g. a DSDT and DT in sync is never going to work
anyway. Already we have early stage servers that contain a DT used for
bringup that is subsequently not being updated as often as the ACPI
tables (those systems are now booting exclusively in labs with ACPI).
Eventually, I am going to push for the DT data to be removed from these
systems rather than have out of date unmaintained DT data in firmware.

Jon.
