From: joelf@ti.com (Joel Fernandes)
Date: Tue, 25 Mar 2014 08:46:40 -0500
Subject: [PATCH] QEMU: ARM: boot: Load kernel at an Image friendly address
In-Reply-To: <CAFEAcA8dSvW8rBvxgquj6fnd7YsNKFUc5+SWrGt1PVEQP0S9ag@mail.gmail.com>
References: <1395718484-20424-1-git-send-email-joelf@ti.com>
 <CAFEAcA8dSvW8rBvxgquj6fnd7YsNKFUc5+SWrGt1PVEQP0S9ag@mail.gmail.com>
Message-ID: <533188C0.9090902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2014 08:13 AM, Peter Maydell wrote:
> On 25 March 2014 03:34, Joel Fernandes <joelf@ti.com> wrote:
>> Loading kernel at offset 0x10000 works only for zImage, but not for Image,
>> because the kernel expect the start of decompressed kernel (.head.text) to be
>> at an address that's a distance that's 16MB aligned from  PAGE_OFFSET +
>> TEXT_OFFSET (see vmlinux.lds.S). This check is enfornced in __fixup_pv_table in
>> arch/arm/kernel/head.S TEXT_OFFSET is 0x00008000, so a 16MB alignment needs to
>> have a "0x8000" in the lower 16 bits so that they cancel out. Currently the
>> offset Qemu loads it at is 0x10000.
>>
>> With zImage, this need is met because zImage loads the uncompressed Image
>> correctly, however when loading an Image and executing directly Qemu is
>> required it to load it at the correct location. Doing so, doesn't break Qemu's
>> zImage loading. With this patch, both zImage and Image work correctly.
>>
>> Signed-off-by: Joel Fernandes <joelf@ti.com>
>> ---
>>  hw/arm/boot.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index dc62918..566b5c2 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -23,7 +23,7 @@
>>   * They have different preferred image load offsets from system RAM base.
>>   */
>>  #define KERNEL_ARGS_ADDR 0x100
>> -#define KERNEL_LOAD_ADDR 0x00010000
>> +#define KERNEL_LOAD_ADDR 0x00008000
>>  #define KERNEL64_LOAD_ADDR 0x00080000
> 
> The patch and rationale seem plausible, but I'm a bit
> reluctant to apply this this close to 2.0 release, because
> QEMU has loaded images at this address for 8 years without
> anybody complaining, and I worry that we might accidentally
> break some other use case somehow.

I understand.
FWIW, I also tested with a15-vexpress and zImage.

thanks,

-Joel
