From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 27 Mar 2014 13:26:17 -0400
Subject: [PATCH v2 1/3] PSCI: Use DT Function ID values only for old
 versions of spec
In-Reply-To: <CABGGisybEQC1BPE6efAP+8CW+DFiQAKB-bvJu6psY7C1E8bQtg@mail.gmail.com>
References: <1395934715-31348-1-git-send-email-ashwin.chaugule@linaro.org>
 <CABGGisybEQC1BPE6efAP+8CW+DFiQAKB-bvJu6psY7C1E8bQtg@mail.gmail.com>
Message-ID: <CAJ5Y-eb2RjfVbxmTwWet8kr2Rv+VikuR93qWTp32+Ur+TCM_zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 27 March 2014 12:41, Rob Herring <rob.herring@linaro.org> wrote:
> On Thu, Mar 27, 2014 at 10:38 AM, Ashwin Chaugule
> <ashwin.chaugule@linaro.org> wrote:
>> PSCI v0.2+ spec mandates specific values of Function IDs
>> for ARM32 and ARM64. Use DT bindings of Function IDs only
>> when using older versions. Use standard values otherwise.
>
> The subject line is a bit out of date.

Yea. This patch has now become more of a PSCIv0.2 implementation.

>> +       int err = 0;
>> +       int ver = 0;
>
> Initialization not needed.

Ok.

>>
>> -       np = of_find_matching_node(NULL, psci_of_match);
>> -       if (!np)
>> -               return;
>> +       pr_info("probing for conduit method from DT.\n");
>> +
>> +       if (of_property_read_string(np, "method", &method)) {
>> +               pr_warn("missing \"method\" property\n");
>> +               err = -ENXIO;
>> +               goto out_put_node;
>> +       }
>> +
>> +       if (!strcmp("hvc", method)) {
>> +               invoke_psci_fn = __invoke_psci_fn_hvc;
>> +       } else if (!strcmp("smc", method)) {
>> +               invoke_psci_fn = __invoke_psci_fn_smc;
>> +       } else {
>> +               pr_warn("invalid \"method\" property: %s\n", method);
>> +               err = -EINVAL;
>> +               goto out_put_node;
>> +       }
>
> This should all be common setup.

I'll roll this up into a helper.

>> +
>> +       ver = psci_get_version();
>> +
>> +       pr_info("PSCIv%d.%d detected in firmware.\n",
>> +                       (ver & PSCI_VER_MAJOR_MASK) >> PSCI_VER_MAJOR_SHIFT,
>> +                       (ver & PSCI_VER_MINOR_MASK));
>
> If it doesn't report 0.2, then we should probably bail (possibly
> falling back to 0.1).

Hm. I'd prefer bailing out here. That would hopefully force the user
to check the PSCI implementation.
Theres always the option of trying out "arm, psci" later.


>> +       ver = psci_get_version();
>
> This may not be safe to do on 0.1 as the call didn't exist.

Ok, I will take it out from this function.

>
>> +
>> +       pr_info("PSCIv%d.%d detected in firmware.\n",
>> +                       (ver & PSCI_VER_MAJOR_MASK) >> PSCI_VER_MAJOR_SHIFT,
>> +                       (ver & PSCI_VER_MINOR_MASK));
>> +
>>         if (!of_property_read_u32(np, "cpu_suspend", &id)) {
>>                 psci_function_id[PSCI_FN_CPU_SUSPEND] = id;
>>                 psci_ops.cpu_suspend = psci_cpu_suspend;
>> @@ -204,7 +302,38 @@ void __init psci_init(void)
>>                 psci_ops.migrate = psci_migrate;
>>         }
>>
>> +       if (!of_property_read_u32(np, "affinity_info", &id)) {
>> +               psci_function_id[PSCI_FN_AFFINITY_INFO] = PSCI_ID_AFFINITY_INFO;
>> +               psci_ops.affinity_info = psci_affinity_info;
>> +       }
>> +
>> +       if (!of_property_read_u32(np, "migrate_info_type", &id)) {
>> +               psci_function_id[PSCI_FN_MIGRATE_INFO_TYPE]
>> +                       = PSCI_ID_MIGRATE_INFO_TYPE;
>> +               psci_ops.migrate_info_type = psci_migrate_info_type;
>> +       }
>
> These 2 functions don't exist for 0.1.

Will remove.

>> +static const struct of_device_id psci_of_match[] __initconst = {
>> +       { .compatible = "arm,psci", .data = psci_of_init},
>> +       { .compatible = "arm,psci-0.2", .data = psci_static_init},
>
> "of" and "static" don't really describe the difference here. Use
> something like psci_init_0_1 and psci_init_0_2.

Ok.

> Same comments apply to this file.
>> index 0000000..b271e9a
>> --- /dev/null
>> +++ b/include/uapi/linux/psci.h
>> @@ -0,0 +1,45 @@
>> +/*
>
> Linaro copyright?
>

Will add.

>> +#ifdef CONFIG_ARM64
>
> You don't need ifdefs here. The 32-bit calls are valid on arm64 as
> that is what 32-bit guests will use. Just do something like this:
>
> #define PSCI_ID_VERSION                                0x84000000
> #define PSCI_ID_CPU_SUSPEND_32                    0x84000001
> #define PSCI_ID_CPU_SUSPEND_64                    0xc4000001
>

Ok, thats better.

Cheers,
Ashwin
