From: achandran@mvista.com (Arun Chandran)
Date: Thu, 26 Jun 2014 15:07:06 +0530
Subject: [PATCH] Arm64: Fix build error while switching from LE to BE
In-Reply-To: <20140626092946.GL15240@leverpostej>
References: <1403765204-17617-1-git-send-email-achandran@mvista.com>
 <20140626092946.GL15240@leverpostej>
Message-ID: <CAFdej00F=NeOHz4OR4-NUnc9GxioUf0+JN2mjp+PDLEGjeM=ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 26, 2014 at 2:59 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Jun 26, 2014 at 07:46:44AM +0100, Arun Chandran wrote:
>> Selecting CPU_BIG_ENDIAN and building the kernel fails just after
>> building it for little endian. According to Documentation/kbuild/makefiles.txt,
>> it is a common mistake to forget 'FORCE' while using 'if_changed'
>
> This is a little confusing, because we jump from the high level problem
> to a very specific problem detail with nothing to link the two.
>
> How about:
>
> Building a kernel with CPU_BIG_ENDIAN fails if there are stale objects
> from a !CPU_BIG_ENDIAN build. Due to a missing FORCE prerequisite on an
> if_changed rule in the VDSO Makefile, we attempt to link a stale LE
> object into the new BE kernel. According to
> Documentation/kbuild/makefiles.txt FORCE is required for if_changed
> rules, and forgetting it is a common mistake.
>

Yes that is a better one. I will make the change.

>> So fix it by 'Forcing' the build of vdso.  Fixes build errors like these:
>>
>> arch/arm64/kernel/vdso/note.o: compiled for a little endian system and target is big endian
>> failed to merge target specific data of file arch/arm64/kernel/vdso/note.o
>>
>> arch/arm64/kernel/vdso/sigreturn.o: compiled for a little endian system and target is big endian
>> failed to merge target specific data of file arch/arm64/kernel/vdso/sigreturn.o
>>
>> Signed-off-by: Arun Chandran <achandran@mvista.com>
>
> Any reason for bot picking up my Tested-by [1]? The patch seems to be
> the same.

Sorry I missed that. Will include in my next patch

--Arun

>
> Mark.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/266571.html
>
>> ---
>>  arch/arm64/kernel/vdso/Makefile |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
>> index 6d20b7d..a268a9a 100644
>> --- a/arch/arm64/kernel/vdso/Makefile
>> +++ b/arch/arm64/kernel/vdso/Makefile
>> @@ -43,7 +43,7 @@ $(obj)/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
>>       $(call if_changed,vdsosym)
>>
>>  # Assembly rules for the .S files
>> -$(obj-vdso): %.o: %.S
>> +$(obj-vdso): %.o: %.S FORCE
>>       $(call if_changed_dep,vdsoas)
>>
>>  # Actual build commands
>> --
>> 1.7.9.5
>>
>>
