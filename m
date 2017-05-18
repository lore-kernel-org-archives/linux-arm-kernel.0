From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 18 May 2017 12:16:40 +0100
Subject: [PATCH 1/1] ARM: compressed/head.S: fix __nop macro rept number
 for ARMv7M
In-Reply-To: <ee014785-f025-8b16-14a7-7f1d86403421@st.com>
References: <1493110893-21857-1-git-send-email-patrice.chotard@st.com>
 <ee014785-f025-8b16-14a7-7f1d86403421@st.com>
Message-ID: <CAKv+Gu-_q-SQn3WKDObOW3_OMd2B_UbcdD+PHkzk7Q6nZbZTfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2017 at 08:22, Patrice CHOTARD <patrice.chotard@st.com> wrote:
> Hi all
>
> It's a gentle reminder to not forgot this patch.
>
> Thanks
>
> Patrice
>
> On 04/25/2017 11:01 AM, patrice.chotard at st.com wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> In zImage, _magic_sig is located at offset 0x24.
>> But for ARMv7M architecture which enable CPU_THUMBONLY
>> and !EFI_STUB kernel flag, _magic_sig is located at offset 0x14
>>
>> 00000000  00 46 00 46 00 46 00 46  00 46 00 46 00 46 0f f2  |.F.F.F.F.F.F.F.?|
>> 00000010  15 0c 60 47 18 28 6f 01  00 00 00 00 28 5c 0e 00  |..`G.(o.....(\..|
>> 00000020  01 02 03 04 0f 46 90 46  00 00 00 00 00 00 00 00  |.....F.F........|
>>
>> Reproduced with stm32_defconfig with XIP_KERNEL flag disabled.
>>
>> To restore correct _magic_sig offset at 0x24, we add 8 additional
>> "mov r0, r0" instruction.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> ---
>>  arch/arm/boot/compressed/head.S | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
>> index 9150f97..5d9cda3 100644
>> --- a/arch/arm/boot/compressed/head.S
>> +++ b/arch/arm/boot/compressed/head.S
>> @@ -127,7 +127,8 @@
>>   AR_CLASS(   .arm    )
>>  start:
>>               .type   start,#function
>> -             .rept   7
>> +   ARM(              .rept   7)
>> + THUMB(              .rept   15)
>>

Could you try using W(mov) instead of mov in the definition of __nop ?
