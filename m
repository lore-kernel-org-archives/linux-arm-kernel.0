From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 06 Feb 2015 15:56:07 +0800
Subject: [Linaro-acpi] [PATCH v8 11/21] ARM64 / ACPI: Get PSCI flags in
 FADT for PSCI init
In-Reply-To: <54D3BE8D.7010401@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-12-git-send-email-hanjun.guo@linaro.org>
 <20150204164328.GF22035@red-moon> <54D3A443.7050303@linaro.org>
 <20150205174904.GA24468@red-moon> <54D3BE8D.7010401@linaro.org>
Message-ID: <54D47397.8020904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo, Al,

On 2015?02?06? 03:03, Al Stone wrote:
> On 02/05/2015 10:49 AM, Lorenzo Pieralisi wrote:
>> Hi Al,
>
> Howdy, Lorenzo.
>
>> On Thu, Feb 05, 2015 at 05:11:31PM +0000, Al Stone wrote:
>>> On 02/04/2015 09:43 AM, Lorenzo Pieralisi wrote:
>>>> On Mon, Feb 02, 2015 at 12:45:39PM +0000, Hanjun Guo wrote:
>>>>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>>>>
>>>>> There are two flags: PSCI_COMPLIANT and PSCI_USE_HVC. When set,
>>>>> the former signals to the OS that the firmware is PSCI compliant.
>>>>> The latter selects the appropriate conduit for PSCI calls by
>>>>> toggling between Hypervisor Calls (HVC) and Secure Monitor Calls
>>>>> (SMC).
>>>>>
>>>>> FADT table contains such information in ACPI 5.1, FADT table was
>>>>> parsed in ACPI table init and copy to struct acpi_gbl_FADT, so
>>>>> use the flags in struct acpi_gbl_FADT for PSCI init.
>>>>
>>>> So you do rely on a global FADT being available, if you use it for PSCI
>>>> detection you can use it for ACPI revision detection too, right ?
>>>>
>>>> Point is, either we should not use the global FADT table, or we use
>>>> it consistently, or there is something I am unaware of that prevents
>>>> you from using in some code paths and I would like to understand
>>>> why.
>>>
>>> The FADT is a required table for arm64, as noted in the documentation
>>> and the SBBR.  While unfortunately the spec does not say it is mandatory,
>>> even x86 systems are pretty useless without it.  So yes, we rely on it
>>> being available, not only for the PSCI info, but other flags such as
>>> HW_REDUCED_ACPI.
>>>
>>> I suppose it does not have to be globally scoped.  However, the FADT is
>>> frequently used, especially on x86, so it makes sense to me from an
>>> efficiency standpoint to have a global reference to it.
>>>
>>> I'm not sure I understand what is meant by using FADT for ACPI revision
>>> detection; there are fields in the FADT that provide a major and minor
>>> number for the FADT itself, but I don't believe there's any guarantee
>>> those will be the same as the level of the specification that is being
>>> supported by the kernel (chances are they will, but it's not mandatory).
>>>
>>> I've probably just missed a part of a thread somewhere; could you point
>>> me to where the inconsistency lies?  I'm just not understanding right this
>>> second....
>>
>> Yes, it is my fault, I was referring to another thread/patch (9), where you
>> need to check the FADT revision to "validate it" (ie >= 5.1) for the arm64
>> kernel. What I am saying is: if the global FADT is there to parse PSCI
>> info, it is there to check the FADT revision too, I do not necessarily
>> see the need for calling acpi_table_parse() again to do it, the FADT
>> revision checking can be carried out as for PSCI, that's all I wanted
>> to say.
>
> Aha.  I understand now.  Another colleague was also trying to explain this
> to me and I think I just hadn't had enough coffee yet.  The underlying ACPI
> code maps tables into the kernel in two phases; it may be that when the code
> in patch 9 is run, the global table is not yet available, while here it is;
> I don't recall off-hand.
>
> I'll take a look at this and talk it over with Hanjun.  If the global table
> is available, it would indeed make sense to be consistent.

I had dig into the code and found out that struct acpi_gbl_FADT will be
available with correct value only if FADT is presented by firmware.

acpi_table_init() will be called before parsing FADT for PSCI flag in
this patch set.

In acpi_table_init()
    acpi_initialize_tables()
       acpi_tb_parse_root_table()

In acpi_tb_parse_root_table()

if (ACPI_SUCCESS(status) &&
    ACPI_COMPARE_NAME(&acpi_gbl_root_table_list.
      tables[table_index].signature,
      ACPI_SIG_FADT)) {
	acpi_tb_parse_fadt(table_index);
}

And acpi_tb_parse_fadt(table_index) will copy the
fadt table to global struct acpi_gbl_FADT.

so it seems that we can use global struct acpi_gbl_FADT directly to
check the FADT revision, but it is only available with firmware
presented the FADT table, so check for the FADT table is still needed
for some bad firmware without FADT.

Why PSCI flag can be used without any check for the availability
of FADT? because we already disable ACPI if 
(acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt))
failed (no FADT tabled found), and PSCI flag will not be used
later.

So I think we can keep the code as it is for now, and I think
it is the safest way to do it, does it make sense?

Thanks
Hanjun
