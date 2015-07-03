From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 3 Jul 2015 13:23:06 +0800
Subject: [PATCH v3 1/3] ACPI : introduce macros for using the ACPI
 specification version
In-Reply-To: <2553932.NLQ9D78ybW@vostro.rjw.lan>
References: <1435880916-2153-1-git-send-email-al.stone@linaro.org>
 <1435880916-2153-2-git-send-email-al.stone@linaro.org>
 <2553932.NLQ9D78ybW@vostro.rjw.lan>
Message-ID: <55961C3A.8080907@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On 2015/7/3 8:21, Rafael J. Wysocki wrote:
> On Thursday, July 02, 2015 05:48:34 PM Al Stone wrote:
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
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>  include/linux/acpi.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index c471dfc..0e525e8 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -48,6 +48,16 @@
>>  #include <acpi/acpi_io.h>
>>  #include <asm/acpi.h>
>>  
>> +#define __ACPI_FADT_SPEC_VERSION(major, minor) \
>> +	((unsigned int)major << 8 | (unsigned int)minor)
>> +
>> +#define ACPI_FADT_SPEC_VERSION	\
>> +	__ACPI_FADT_SPEC_VERSION(acpi_gbl_FADT.header.revision, \
>> +				 acpi_gbl_FADT.minor_revision)
>> +
>> +#define ACPI_FADT_SPEC_VERSION_51 __ACPI_FADT_SPEC_VERSION(5, 1)
>> +#define ACPI_FADT_SPEC_VERSION_60 __ACPI_FADT_SPEC_VERSION(6, 0)
> I'd add underscores here, eg. ACPI_FADT_SPEC_VERSION_6_0

Agreed.

>
> And what if there is 5.2 or even 5.3?

Hmm, do you mean in the future or just now? for both two cases,
only 5.1 and 5.1 errata (still has the same ACPI version with 5.1)
will be available, then jump to 6.0 and going forward if new versions
in the future.

I'm not sure if I understand your question correctly, if
not, please correct me :)

Thanks
Hanjun
