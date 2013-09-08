From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 8 Sep 2013 09:40:22 +0200
Subject: [PATCH] ARM: fix modular build of xor_blocks() with NEON enabled
In-Reply-To: <CA+5PVA5pZL60aybXd=2bsJmq8-57o07PryYtw6ik05aF4jEuDg@mail.gmail.com>
References: <1378563673-10637-1-git-send-email-ard.biesheuvel@linaro.org>
 <CA+5PVA5pZL60aybXd=2bsJmq8-57o07PryYtw6ik05aF4jEuDg@mail.gmail.com>
Message-ID: <CAKv+Gu8Jrb0X5E5x62dkdXpiJKOjYhj+JFeH7DwBcrM925BLcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 September 2013 17:02, Josh Boyer <jwboyer@fedoraproject.org> wrote:
> On Sat, Sep 7, 2013 at 10:21 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> Commit 0195659 introduced a NEON accelerated version of the xor_blocks()
>> function, but it needs the changes in this patch to allow it to be built
>> as a module rather than statically into the kernel.
>>
>> This patch creates a separate module xor-neon.ko which exports the NEON
>> inner xor_blocks() functions depended upon by the regular xor.ko if it
>> is built with CONFIG_KERNEL_MODE_NEON=y
>>
>> Reported-by: Josh Boyer <jwboyer@fedoraproject.org>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> Tested-by: Josh Boyer <jwboyer@fedoraproject.org>
>
> This let the config we have build successfully.  Thanks for the quick
> turn around!
>

No problem

>> ---
>>  arch/arm/lib/Makefile   | 4 +++-
>>  arch/arm/lib/xor-neon.c | 4 ++++
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
>> index aaf3a87..6bc2bd3 100644
>> --- a/arch/arm/lib/Makefile
>> +++ b/arch/arm/lib/Makefile
>> @@ -49,5 +49,7 @@ $(obj)/csumpartialcopyuser.o: $(obj)/csumpartialcopygeneric.S
>>  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
>>    NEON_FLAGS                   := -mfloat-abi=softfp -mfpu=neon
>>    CFLAGS_xor-neon.o            += $(NEON_FLAGS)
>> -  lib-$(CONFIG_XOR_BLOCKS)     += xor-neon.o
>> +  xor-neon-$(CONFIG_XOR_BLOCKS)        := xor-neon.o
>> +  lib-y                                += $(xor-neon-y)
>> +  obj-m                                += $(xor-neon-m)

Just doing

obj-$(CONFIG_XOR_BLOCKS)        += xor-neon.o

is probably better, so if nobody objects, I will update the patch
accordingly and put it in the patch tracker.

Regards,
Ard.




>>  endif
>> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
>> index f485e5a..2c40aea 100644
>> --- a/arch/arm/lib/xor-neon.c
>> +++ b/arch/arm/lib/xor-neon.c
>> @@ -9,6 +9,9 @@
>>   */
>>
>>  #include <linux/raid/xor.h>
>> +#include <linux/module.h>
>> +
>> +MODULE_LICENSE("GPL");
>>
>>  #ifndef __ARM_NEON__
>>  #error You should compile this file with '-mfloat-abi=softfp -mfpu=neon'
>> @@ -40,3 +43,4 @@ struct xor_block_template const xor_block_neon_inner = {
>>         .do_4   = xor_8regs_4,
>>         .do_5   = xor_8regs_5,
>>  };
>> +EXPORT_SYMBOL(xor_block_neon_inner);
>> --
>> 1.8.1.2
>>
