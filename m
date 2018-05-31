From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 31 May 2018 08:45:38 -0500
Subject: [PATCH 1/4] arm64: capabilities: add nopti command line argument
In-Reply-To: <2b1b39e3-38ab-848a-a1d3-d23db85b0e14@arm.com>
References: <20180524190932.32118-1-mlangsdo@redhat.com>
 <20180524190932.32118-2-mlangsdo@redhat.com>
 <2b1b39e3-38ab-848a-a1d3-d23db85b0e14@arm.com>
Message-ID: <9d83b00a-f23c-e3e7-ab4a-598995d21f0c@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/30/2018 03:59 AM, Suzuki K Poulose wrote:
> 
> 
> Hi Mark,
> 
> On 24/05/18 20:09, Mark Langsdorf wrote:
>> The x86 kernel and the documentation use 'nopti' as the kernel command
>> line argument to disable kernel page table isolation, so add nopti to
>> the arm64 kernel for compatibility.
>>
>> Signed-off-by: Mark Langsdorf <mlangsdo@redhat.com>
>> ---
>> ? Documentation/admin-guide/kernel-parameters.txt |? 6 +++---
>> ? arch/arm64/kernel/cpufeature.c????????????????? | 11 ++++++++++-
>> ? 2 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt 
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index f2040d4..a987725 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3342,8 +3342,8 @@
>> ????? pt.??????? [PARIDE]
>> ????????????? See Documentation/blockdev/paride.txt.
>> -??? pti=??????? [X86_64] Control Page Table Isolation of user and
>> -??????????? kernel address spaces.? Disabling this feature
>> +??? pti=??????? [X86_64, ARM64] Control Page Table Isolation of user
>> +??????????? and kernel address spaces.? Disabling this feature
>> ????????????? removes hardening, but improves performance of
>> ????????????? system calls and interrupts.
> 
> ...
> 
>> @@ -3354,7 +3354,7 @@
>> ????????????? Not specifying this option is equivalent to pti=auto.
>> -??? nopti??????? [X86_64]
>> +??? nopti??????? [X86_64, ARM64]
>> ????????????? Equivalent to pti=off
>> ????? pty.legacy_count=
>> diff --git a/arch/arm64/kernel/cpufeature.c 
>> b/arch/arm64/kernel/cpufeature.c
>> index 9d1b06d..7c5d8712 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -934,10 +934,19 @@ static int __init parse_kpti(char *str)
>> ????? if (ret)
>> ????????? return ret;
>> -??? __kpti_forced = enabled ? 1 : -1;
>> +??? if (!__kpti_forced)
>> +??????? __kpti_forced = enabled ? 1 : -1;
>> ????? return 0;
>> ? }
>> ? __setup("kpti=", parse_kpti);
> 
> The arm64 kernel parameter is named "kpti", while the Documentation 
> update above says "pti". We may want to keep both in sync here.

Good point. I think I will add a new kpti entry for ARM64 in 
kernel-parameters. Then the docs match the code, instead of trying to 
match the code to the docs.

--Mark Langsdorf
