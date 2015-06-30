From: ahs3@redhat.com (Al Stone)
Date: Tue, 30 Jun 2015 13:45:16 -0600
Subject: [PATCH v2 0/3] Correct for ACPI 5.1->6.0 spec changes in MADT
 GICC entries
In-Reply-To: <CAJZ5v0gF6JZ8uVNMnro0bdD0g+QMoTeEzB99j6RcKUt3LjmiXw@mail.gmail.com>
References: <1434666968-1543-1-git-send-email-al.stone@linaro.org>	<5592CCE6.6040604@arm.com>	<5592D1FF.7040208@redhat.com>
 <CAJZ5v0gF6JZ8uVNMnro0bdD0g+QMoTeEzB99j6RcKUt3LjmiXw@mail.gmail.com>
Message-ID: <5592F1CC.5030102@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2015 12:25 PM, Rafael J. Wysocki wrote:
> Hi Al,
> 
> On Tue, Jun 30, 2015 at 7:29 PM, Al Stone <ahs3@redhat.com> wrote:
>> On 06/30/2015 11:07 AM, Sudeep Holla wrote:
>>> Hi Al,
>>>
>>> On 18/06/15 23:36, Al Stone wrote:
>>>> In the ACPI 5.1 version of the spec, the struct for the GICC subtable
>>>> (struct acpi_madt_generic_interrupt) of the MADT is 76 bytes long; in
>>>> ACPI 6.0, the struct is 80 bytes long.  But, there is only one definition
>>>> in ACPICA for this struct -- and that is the 6.0 version.  Hence, when
>>>> BAD_MADT_ENTRY() compares the struct size to the length in the GICC
>>>> subtable, it fails if 5.1 structs are in use, and there are systems in
>>>> the wild that have them.
>>>>
>>>> Note that this was found in linux-next and these patches apply against
>>>> that tree and the arm64 kernel tree; 4.1-rc8 does not appear to have this
>>>> problem since it still has the 5.1 struct definition.
>>>>
>>>> Even though there is precendent in ia64 code for ignoring the changes in
>>>> size, this patch set instead tries to verify correctness.  The first patch
>>>> in the set adds macros for easily using the ACPI spec version.  The second
>>>> patch adds the BAD_MADT_GICC_ENTRY() macro that uses the version macros to
>>>> check the GICC subtable only, accounting for the difference in specification
>>>> versions that are possible.  The final patch replaces BAD_MADT_ENTRY usage
>>>> with the BAD_MADT_GICC_ENTRY macro in arm64 code, which is currently the
>>>> only architecture affected.  The BAD_MADT_ENTRY() will continue to work as
>>>> is for all other MADT subtables.
>>>>
>>>
>>> We need to get this series or a patch to remove the check(similar to
>>> ia64) based on what Rafael prefers. Without that, platforms using ACPI
>>> on ARM64 fails to boot with latest mainline. This blocks any testing on
>>> ARM64/ACPI systems.
>>>
>>> Regards,
>>> Sudeep
>>
>> I have not received any other feedback than some Reviewed-bys from
>> Hanjun and an ACK from Will for the arm64 patch.
>>
>> And absolutely agreed: this is a blocker for arm64/ACPI, starting with
>> the ACPICA 20150515 patches which appear to have gone in with 4.2-rc1.
>>
>> Rafael?  Ping?
> 
> I overlooked the fact that this was needed to fix a recent regression,
> sorry about that.
> 
> Actually, if your patch fixes an error introduced by a specific
> commit, it is good to use the Fixes: tag to indicate that.  Which I
> still would like to do, so which commit is fixed by this?

Ah, right.  Sorry about missing the tag.  On the other hand, we're not
really fixing anything so much as working around a problem in the ACPI
specification.  IA64 has seen the same problem, but the choice there
was to just remove the use of BAD_MADT_ENTRY(); my preference was to keep
the safety check the macro represents, but do it properly for the MADT
subtable involved.

So, the commit that I see as the trigger is actually correct:

   commit aeb823bbacc2 ("ACPICA: ACPI 6.0: Add changes for FADT table.")

That commit implements a change to the GICC subtable that is new for
ACPI 6.0, and this is the correct change.  However, this commit changes
the length of the struct for the subtable.  The problem is that both the
old ACPI 5.1 length field value *and* the new ACPI 6.0 length field are
now valid, but ACPICA 20150515 only has the ACPI 6.0 definition.

The right long term change is for the spec to disambiguate the different
definitions of the GICC subtable so that ACPICA knows what to implement --
and that spec change is in progress and should be noted in the next errata.
ACPICA will then pick up the errata change, I presume.

In the meantime, however, BAD_MADT_ENTRY() compares the length field of the
GICC subtable, which is now allowed to have multiple different values, with
the length of the struct holding that data, which is only the proper length
for ACPI 6.0.  The macro makes no distinction between spec versions or even
MADT versions, and hence fails when it compares an ACPI 5.1 length field with
an ACPI 6.0 sized struct.

So I guess that's why the Fixes: tag did not immediately pop to mind.  ACPICA
is not really broken, and the commit that triggers the problem is actually
correct.  But, because of the BAD_MADT_ENTRY() macro, Linux assumes that all
MADT subtables with a length field will have that length value be the same as
the current ACPICA data structure size, which is no longer true for the GICC
subtable.

Is there a Deal-with-Spec-Weirdness tag I can use??

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
