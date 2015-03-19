From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 19 Mar 2015 09:16:15 +0800
Subject: [PATCH v10 18/21] ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY
 if ACPI is enabled on ARM64
In-Reply-To: <18318670.U16Joq6nSS@vostro.rjw.lan>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <5506BF89.9040703@linaro.org> <20150318091820.GB2846@red-moon>
 <18318670.U16Joq6nSS@vostro.rjw.lan>
Message-ID: <550A235F.8060808@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/18 23:06, Rafael J. Wysocki wrote:
> On Wednesday, March 18, 2015 09:18:20 AM Lorenzo Pieralisi wrote:
>> On Mon, Mar 16, 2015 at 11:33:29AM +0000, Hanjun Guo wrote:
>>> On 2015?03?13? 19:04, Lorenzo Pieralisi wrote:
>>>> On Fri, Mar 13, 2015 at 03:28:45AM +0000, Hanjun Guo wrote:
>>>>
>>>> [...]
>>>>
>>>>>>   /*
>>>>>>    * acpi_boot_table_init() called from setup_arch(), always.
>>>>>>    *	1. find RSDP and get its address, and then find XSDT
>>>>>>    *	2. extract all tables and checksums them all
>>>>>>    *	3. check ACPI FADT revision
>>>>>> + *	4. check ACPI FADT HW reduced flag
>>>>>>    *
>>>>>>    * We can parse ACPI boot-time tables such as MADT after
>>>>>>    * this function is called.
>>>>>>    */
>>>>>>   void __init acpi_boot_table_init(void)
>>>>>>   {
>>>>>> +	struct acpi_table_header *table;
>>>>>> +	struct acpi_table_fadt *fadt;
>>>>>> +	acpi_status status;
>>>>>> +	acpi_size tbl_size;
>>>>>> +
>>>>>>   	/*
>>>>>>   	 * Enable ACPI instead of device tree unless
>>>>>>   	 * - ACPI has been disabled explicitly (acpi=off), or
>>>>>> @@ -351,19 +318,52 @@ void __init acpi_boot_table_init(void)
>>>>>>   	    (!param_acpi_force && of_scan_flat_dt(dt_scan_depth1_nodes, NULL)))
>>>>>>   		return;
>>>>>>
>>>>>> -	enable_acpi();
>>>>>> -
>>>>>>   	/* Initialize the ACPI boot-time table parser. */
>>>>>>   	if (acpi_table_init()) {
>>>>> Since we disable ACPI in default, it is a bit strange for me to init all
>>>>> the ACPI tables and parse FADT when ACPI is disabled, could you
>>>>> put some comments here to clarify the purpose? other than that, it is looks
>>>>> good to me.
>>>> Ok, the purpose was to make things simpler, but I think that given
>>>> current code it is not 100% safe to init ACPI tables with
>>>> acpi_disabled == 1.
>>>>
>>>> To me having to enable ACPI to parse the tables and check *if* ACPI tables
>>>> are there is a bit crazy, but I agree with you that given current code
>>>> it is safer.
>>>>
>>>> Patch rewritten, here below, please have a look, test it and rework
>>>> bits as needed, I added comments where I thought they were needed but
>>>> please add to that if you feel it is worth it.
>>>>
>>>> It should be easy to split, let me know if you want an incremental
>>>> version.
>>> This one is much better, pretty fine to me, thanks!
>>>
>>> I assume that this patch is cleanup patch on top of ARM64 ACPI
>>> core patches, right?
>> For the records, I created a branch with my patch split over some
>> of your patches, even though I think to make things simpler it is best
>> to apply it as a single patch on top of your series,
> I agree.  In particular, the patches that have already been reviewed and
> ACKed won't need to be reviewed again this way which seems to be crucially
> important to me.
>
>> I will prepare the commit log for the single patch version too.
> Thanks!
>
> Hanjun, please add this one to the series when ready.

Sure, I will.

Thanks
Hanjun
