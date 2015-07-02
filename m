From: ahs3@redhat.com (Al Stone)
Date: Thu, 02 Jul 2015 12:25:21 -0600
Subject: [PATCH v2 0/3] Correct for ACPI 5.1->6.0 spec changes in MADT
 GICC entries
In-Reply-To: <55934B3D.6060106@huawei.com>
References: <1434666968-1543-1-git-send-email-al.stone@linaro.org>	<5592CCE6.6040604@arm.com>	<5592D1FF.7040208@redhat.com>	<CAJZ5v0gF6JZ8uVNMnro0bdD0g+QMoTeEzB99j6RcKUt3LjmiXw@mail.gmail.com>
 <CAJZ5v0hea5xJL3p1L=-Z1azP2wfx8Mu113JC8SgPwP06c58mQg@mail.gmail.com>
 <55934B3D.6060106@huawei.com>
Message-ID: <55958211.5010607@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2015 08:06 PM, Hanjun Guo wrote:
> On 2015/7/1 2:35, Rafael J. Wysocki wrote:
>> On Tue, Jun 30, 2015 at 8:25 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> Hi Al,
>>>
>>> On Tue, Jun 30, 2015 at 7:29 PM, Al Stone <ahs3@redhat.com> wrote:
>>>> On 06/30/2015 11:07 AM, Sudeep Holla wrote:
>>>>> Hi Al,
>>>>>
>>>>> On 18/06/15 23:36, Al Stone wrote:
>>>>>> In the ACPI 5.1 version of the spec, the struct for the GICC subtable
>>>>>> (struct acpi_madt_generic_interrupt) of the MADT is 76 bytes long; in
>>>>>> ACPI 6.0, the struct is 80 bytes long.  But, there is only one definition
>>>>>> in ACPICA for this struct -- and that is the 6.0 version.  Hence, when
>>>>>> BAD_MADT_ENTRY() compares the struct size to the length in the GICC
>>>>>> subtable, it fails if 5.1 structs are in use, and there are systems in
>>>>>> the wild that have them.
>>>>>>
>>>>>> Note that this was found in linux-next and these patches apply against
>>>>>> that tree and the arm64 kernel tree; 4.1-rc8 does not appear to have this
>>>>>> problem since it still has the 5.1 struct definition.
>>>>>>
>>>>>> Even though there is precendent in ia64 code for ignoring the changes in
>>>>>> size, this patch set instead tries to verify correctness.  The first patch
>>>>>> in the set adds macros for easily using the ACPI spec version.  The second
>>>>>> patch adds the BAD_MADT_GICC_ENTRY() macro that uses the version macros to
>>>>>> check the GICC subtable only, accounting for the difference in specification
>>>>>> versions that are possible.  The final patch replaces BAD_MADT_ENTRY usage
>>>>>> with the BAD_MADT_GICC_ENTRY macro in arm64 code, which is currently the
>>>>>> only architecture affected.  The BAD_MADT_ENTRY() will continue to work as
>>>>>> is for all other MADT subtables.
>>>>>>
>>>>> We need to get this series or a patch to remove the check(similar to
>>>>> ia64) based on what Rafael prefers. Without that, platforms using ACPI
>>>>> on ARM64 fails to boot with latest mainline. This blocks any testing on
>>>>> ARM64/ACPI systems.
>>>>>
>>>>> Regards,
>>>>> Sudeep
>>>> I have not received any other feedback than some Reviewed-bys from
>>>> Hanjun and an ACK from Will for the arm64 patch.
>>>>
>>>> And absolutely agreed: this is a blocker for arm64/ACPI, starting with
>>>> the ACPICA 20150515 patches which appear to have gone in with 4.2-rc1.
>>>>
>>>> Rafael?  Ping?
>>> I overlooked the fact that this was needed to fix a recent regression,
>>> sorry about that.
>>>
>>> Actually, if your patch fixes an error introduced by a specific
>>> commit, it is good to use the Fixes: tag to indicate that.  Which I
>>> still would like to do, so which commit is fixed by this?
>>>
>>>> Do we need these to go through your tree or the arm64
>>>> tree?  Without this series (or an ia64-like solution), we have ACPI
>>>> systems in the field that cannot boot.
>>> I'm not quite sure why the definition of BAD_MADT_GICC_ENTRY has to go
>>> into include/linux/acpi.h.  Why is it necessary in there?
>> Like what about defining it in linux/irqchip/arm-gic-acpi.h for example?
>>
> 
> This BAD_MADT_GICC_ENTRY is both used by SMP init and GIC irqchip init for
> ARM64, would it be good to put BAD_MADT_GICC_ENTRY in arch/arm64/include/asm/acpi.h?
> 
> Thanks
> Hanjun

Ah, right.  Good point.  Let me try it in that file, then.  It is -- for the
time being -- arm64 specific.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
