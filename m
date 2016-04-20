From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 20 Apr 2016 11:09:34 +0100
Subject: [PATCH v4 1/5] ACPI / processor_idle: introduce
 ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE
In-Reply-To: <CAGm_ybjZ8ePc9KhcaaSX9aDJTE1Svuc-OnpYJpd9TTfi_sm_cQ@mail.gmail.com>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
 <1461069013-13292-2-git-send-email-sudeep.holla@arm.com>
 <CAGm_ybjZ8ePc9KhcaaSX9aDJTE1Svuc-OnpYJpd9TTfi_sm_cQ@mail.gmail.com>
Message-ID: <5717555E.8040401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/04/16 10:56, Vikas Sajjan wrote:
> Hi Sudeep,
>
> On Tue, Apr 19, 2016 at 6:00 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> ACPI 6.0 adds a new method to specify the CPU idle states(C-states)
>> called Low Power Idle(LPI) states. Since new architectures like ARM64
>> use only LPIs, introduce ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE to
>> encapsulate all the code supporting the old style C-states(_CST)
>>
>> This patch will help to extend the processor_idle module to support
>> LPI.
>>

[...]

>> @@ -1018,29 +1062,11 @@ int acpi_processor_power_init(struct acpi_processor *pr)
>>          acpi_status status;
>>          int retval;
>>          struct cpuidle_device *dev;
>> -       static int first_run;
>>
>>          if (disabled_by_idle_boot_param())
>>                  return 0;
>>
>> -       if (!first_run) {
>> -               dmi_check_system(processor_power_dmi_table);
>> -               max_cstate = acpi_processor_cstate_check(max_cstate);
>> -               if (max_cstate < ACPI_C_STATES_MAX)
>> -                       printk(KERN_NOTICE
>> -                              "ACPI: processor limited to max C-state %d\n",
>> -                              max_cstate);
>> -               first_run++;
>> -       }
>> -
>> -       if (acpi_gbl_FADT.cst_control && !nocst) {
>> -               status =
>> -                   acpi_os_write_port(acpi_gbl_FADT.smi_command, acpi_gbl_FADT.cst_control, 8);
>> -               if (ACPI_FAILURE(status)) {
>> -                       ACPI_EXCEPTION((AE_INFO, status,
>> -                                       "Notifying BIOS of _CST ability failed"));
>> -               }
>> -       }
>> +       acpi_processor_cstate_first_run_checks();
>>
>>          acpi_processor_get_power_info(pr);
>>          pr->flags.power_setup_done = 1;
>
> Not related to your change,
> The acpi_processor_get_power_info() function can return failure, so i
> thought it makes sense to check for the return value
> and then set the  flag pr->flags.power_setup_done appropriately.
>

Makes sense, will do that.

-- 
Regards,
Sudeep
