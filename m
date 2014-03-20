From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 20 Mar 2014 11:39:30 -0400
Subject: [PATCH v1 1/2] PSCI: Use DT Function ID values only for old
 versions of spec
In-Reply-To: <20140320145742.GF23372@e106331-lin.cambridge.arm.com>
References: <1395276865-6868-1-git-send-email-ashwin.chaugule@linaro.org>
 <20140320145742.GF23372@e106331-lin.cambridge.arm.com>
Message-ID: <CAJ5Y-eYwMKXWiuAx_Kbv8XJ2Ym_jbStuNaNjtWe1RP8Xz+j-Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 20 March 2014 10:57, Mark Rutland <mark.rutland@arm.com> wrote:

>>
>> +/* PSCI Function ID's for ARM32 as per PSCI spec v0.2 */
>
> Please drop the superfluous apostrophes, we aren't greengrocers [1].
>
> %s/ID's/IDs/

Ok. Will fix all the uncouth bacilli. ;)

>> +     fn = PSCI_ID_VERSION;
>> +     err = invoke_psci_fn(fn, 0, 0, 0);
>
> Do we need fn here? Can't we pass PSCI_ID_VERSION directly?
>

yep.


>> -void __init psci_init(void)
>> +     pr_info("Using static PSCIv0.2+ function IDs\n");
>
> How about "Using standard PSCI 0.2 function IDs"?
>
> We're not using anything beyond PSCI 0.2 (yet), and "static" implies
> that there are dynamic IDs also.

Ok.

>
>> +     psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_ID_CPU_SUSPEND;
>> +     psci_ops.cpu_suspend = psci_cpu_suspend;
>> +
>> +     psci_function_id[PSCI_FN_CPU_OFF] = PSCI_ID_CPU_OFF;
>> +     psci_ops.cpu_off = psci_cpu_off;
>> +
>> +     psci_function_id[PSCI_FN_CPU_ON] = PSCI_ID_CPU_ON;
>> +     psci_ops.cpu_on = psci_cpu_on;
>> +
>> +     psci_function_id[PSCI_FN_MIGRATE] = PSCI_ID_CPU_MIGRATE;
>> +     psci_ops.migrate = psci_migrate;
>> +
>> +out_put_node:
>> +     of_node_put(np);
>> +     return err;
>> +}
>
> I'd very much like to see us use AFFINITY_INFO from the start, or we've
> got a racy down path (as we have for all PSCI implementations prior to
> 0.2), and implementors are likely to skip implementing it if Linux seems
> to work, so we'll never be able to rely on it.
>
> Additionally it'd be nice to check what MIGRATE_INFO_TYPE returns. If it
> returns a value other than 2 (MP or not present), then there's some
> additional work that we need to perform around a down path or we might
> not be able to shut down some CPUs.

The main intention of this patch is to separate function ID detection
depending on PSCI versions.
So, I think the additional functionality of AFFINITY_INFO and
MIGRATE_INFO_TYPE should go in as separate patches. Do you agree?

>
>> +
>> +/*
>> + * PSCI < v0.2 can override PSCI function ID's via DT.
>> + */
>> +static int psci_of_init(struct device_node *np)
>>  {
>> -     struct device_node *np;
>>       const char *method;
>>       u32 id;
>> -
>> -     np = of_find_matching_node(NULL, psci_of_match);
>> -     if (!np)
>> -             return;
>> +     int err = 0;
>>
>>       pr_info("probing function IDs from device-tree\n");
>>
>>       if (of_property_read_string(np, "method", &method)) {
>> -             pr_warning("missing \"method\" property\n");
>> +             pr_warn("missing \"method\" property\n");
>> +             err = -EINVAL;
>>               goto out_put_node;
>>       }
>>
>> @@ -180,7 +235,8 @@ void __init psci_init(void)
>>       } else if (!strcmp("smc", method)) {
>>               invoke_psci_fn = __invoke_psci_fn_smc;
>>       } else {
>> -             pr_warning("invalid \"method\" property: %s\n", method);
>> +             pr_warn("invalid \"method\" property: %s\n", method);
>> +             err = -ENXIO;
>>               goto out_put_node;
>>       }
>
> We should definitely factor this into a helper rather than duplicating
> it.
>

Ok I'll look into this.

Cheers,
Ashwin
