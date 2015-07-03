From: ahs3@redhat.com (Al Stone)
Date: Fri, 03 Jul 2015 13:32:33 -0600
Subject: [PATCH v3 1/3] ACPI : introduce macros for using the ACPI
 specification version
In-Reply-To: <55961AB3.70801@huawei.com>
References: <1435880916-2153-1-git-send-email-al.stone@linaro.org>
 <1435880916-2153-2-git-send-email-al.stone@linaro.org>
 <55961AB3.70801@huawei.com>
Message-ID: <5596E351.5090100@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2015 11:16 PM, Hanjun Guo wrote:
> Hi Al,
> 
> On 2015/7/3 7:48, Al Stone wrote:
>> Add the __ACPI_FADT_SPEC_VERSION() helper macro to build a proper version
>> number from a major and minor revision number.  Add also macros that use
>> the helper to construct the current version from the values in the FADT
>> (i.e., ACPI_FADT_SPEC_VERSION) and both the 5.1 and 6.0 versions.
>>
>> These macros are added in order to simplify retrieving and comparing ACPI
>> specification version numbers, since this is becoming a more frequent need.
>> In particular, there are some architectures that require at least a certain
>> version of the spec, and there are differences in some structure sizes that
>> have changed with recent versions but can only be tracked by spec version
>> number.
>>
>> Fixes: aeb823bbacc2 (ACPICA: ACPI 6.0: Add changes for FADT table.)
> 
> If I understand correctly, will it be (and for next two patches as well):
> 
> 0cff8dc0099f (ACPICA: ACPI 6.0: Add changes for MADT table.)?
> 
> FADT table update was not introduce any regressions for ARM64
> I think.
> 
> Thanks
> Hanjun
> 

Right.  As I noted in the discussion over v2 of these patches, the FADT
change is correctly implementing a change for ACPI 6.0.  However, it is this
change which adds eight bytes to the GICC subtable so that the struct length
and the length field in the GICC subtable no longer match, which is what
causes BAD_MADT_ENTRY to fail.

So, while this commit is correct, the patches in this set are needed to work
around the ambiguity this causes in the spec and the ACPICA implementation of
it.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
