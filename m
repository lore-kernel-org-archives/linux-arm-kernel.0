From: saberlily.xia@hisilicon.com (Xiaqing (A))
Date: Thu, 19 May 2016 19:42:03 +0800
Subject: [PATCH] arm64: cpuinfo: add AArch64 & elf platform for app
 compatibility
In-Reply-To: <573D9DCD.8020308@arm.com>
References: <1463625873-60016-1-git-send-email-saberlily.xia@hisilicon.com>
 <573D9DCD.8020308@arm.com>
Message-ID: <573DA68B.6030006@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016/5/19 19:04, Robin Murphy ??:
> On 19/05/16 03:44, x00195127 wrote:
>> we find that some apps will read cpuinfo when start up,
>> they need the string  as follows:
>> "Processor       : AArch64 Processor rev 0 (aarch64)"
>>
>> Then thay could load the corresponding libs. But now
>> arm64 platform's cpuinfo don't has this now, so
>> we need add this.
>>
>> Signed-off-by: Qing Xia <saberlily.xia@hisilicon.com>
>> ---
>>   arch/arm64/kernel/cpuinfo.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
>> index 3808470..c3527ad 100644
>> --- a/arch/arm64/kernel/cpuinfo.c
>> +++ b/arch/arm64/kernel/cpuinfo.c
>> @@ -114,6 +114,9 @@ static int c_show(struct seq_file *m, void *v)
>>            * online processors, looking for lines beginning with
>>            * "processor".  Give glibc what it expects.
>>            */
>> +        seq_printf(m, "Processor\t: AArch64 Processor rev %d (%s)\n",
>> +                read_cpuid_id() & 15, ELF_PLATFORM);
>
> The pre-3.19 behaviour printed this once - now you're printing it for
> every CPU in the system, but all with the same revision of whichever
> core this happens to be running on, which is unjustifiably incorrect.
>
> Furthermore, this string provides virtually no useful information anyway
> - the majority of code running on AArch64 already knows that by virtue
> of the fact that *it's running at all*, and for scripts/interpreted
> code/etc. there are already appropriate mechanisms for discovering the
> platform (e.g. uname).
>
> Robin.
>

Those are 32-bit andriod apps, and according to my tests they really 
need this information, although this information is already useless in 
my opinion. A lot of android apps update very slowly.

>> +
>>           seq_printf(m, "processor\t: %d\n", i);
>>
>>           seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
>>
>
>
> .
>
