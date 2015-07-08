From: asamson@codeaurora.org (Azriel Samson)
Date: Wed, 8 Jul 2015 23:03:54 -0000
Subject: ARM64 kexec/kdump timeline
In-Reply-To: <CAOZdJXXtMn2==b6y8Lf7Kvc4fWS6Zn_ZxwkO_1OhBPhL2PtfMg@mail.gmail.com>
References: <555E37FC.9020800@codeaurora.org>
 <1432239334.1922.7.camel@infradead.org>
 <55653538.8020206@codeaurora.org> <2420285.dn5MbvMKXS@wuerfel>
 <55664FD9.1090808@codeaurora.org> <556BFAD1.7010907@redhat.com>
 <CAOZdJXXtMn2==b6y8Lf7Kvc4fWS6Zn_ZxwkO_1OhBPhL2PtfMg@mail.gmail.com>
Message-ID: <fcf2a95bf9a7a9fce6ee864a747cea9a.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

When booting the crash kernel with ACPI, how do you ensure that the ACPI
tables fall within the kernel's memmap region?
I was able to boot with ACPI when the crash kernel's memory overlapped
with the ACPI tables(based on the "crashkernel" and "mem" boot arguments).

Is there a better way to make the ACPI tables available to the crash kernel?

> On Mon, Jun 1, 2015 at 1:25 AM, Pratyush Anand <panand@redhat.com> wrote:
>
>> We had seen a failure with check_cpu_nodes(), when booting with ACPI
>> without
>> any DTB.
>>
>> If you see the similar failure, then can you pl try following:
>>
>> diff --git a/kexec/arch/arm64/kexec-arm64.c
>> b/kexec/arch/arm64/kexec-arm64.c
>> index 7b219097dfff..8e085212d8a5 100644
>> --- a/kexec/arch/arm64/kexec-arm64.c
>> +++ b/kexec/arch/arm64/kexec-arm64.c
>> @@ -640,7 +640,7 @@ int arm64_load_other_segments(struct kexec_info
>> *info,
>>         result =  check_cpu_nodes(&dtb_1, &dtb_2);
>>
>>         if (result)
>> -               return result;
>> +               fprintf(stderr, "kexec: Warning: No device tree
>> available.\n");
>>
>>         /*
>>          * Put the DTB after the kernel with an alignment of 128 KiB,
>> giving
>
> I finally got around to testing this.  With this change, the tool just
> displays the error message and continues working.  So +1 for this
> patch.
>
> It would be better, of course, if the tool could parse the ACPI tables
> and generate a compatible device tree with CPU nodes.  Do you have any
> plans to support ACPI with this tool?  We're working on that
> internally, but it's mostly hacks and work-arounds for now.
>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
>


-- 
Thanks,
Azriel Samson
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,?
a Linux Foundation Collaborative Project
