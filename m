From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 3 Feb 2016 15:17:19 +0100
Subject: [PATCH 0/3] kallsyms: remove special handling for CONFIG_ARM
In-Reply-To: <HKXPR06MB056516B5DC41AB61AA39D8B28AD00@HKXPR06MB0565.apcprd06.prod.outlook.com>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
 <HKXPR06MB0565A2CFF95AD7C000F43E6A8ADF0@HKXPR06MB0565.apcprd06.prod.outlook.com>
 <CAKv+Gu9VvskQ34w0niS+6AtF9hNcycfYDt_3Kp4T+WK8Vxf_dA@mail.gmail.com>
 <HKXPR06MB05656F902E0E1FBBDBD713DC8AD00@HKXPR06MB0565.apcprd06.prod.outlook.com>
 <CAKv+Gu8ZTHAqviveLMizRKPfeXwb6kcXi4cVQNYVYuPcVMgMeQ@mail.gmail.com>
 <HKXPR06MB056516B5DC41AB61AA39D8B28AD00@HKXPR06MB0565.apcprd06.prod.outlook.com>
Message-ID: <CAKv+Gu8DUkoFow_ZzQyTBe4_Nmeu7+CDYb=iAs0w3Fp_JMz+aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 February 2016 at 15:15, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On 2 Feb 2016, Chris Brandt wrote
>> > And when a printed out the destination, I get:
>> >
>> >    Stubs at c09ff000 :00000000 BF006F20 EF9F0000 EA000064 etc...
>> >
>> > Notice the first entry is 0....that's not right...and we know it's using that
>> > first __stubs_start symbol.
>> >
>>
>> The first quantity after __stubs_start should be the address of vector_swi. Can
>>  you check if the second value coincides with that?
>
> Yes, it does.
>
> bf006f20 T vector_swi
>
> Which is why it booted once I modified the start address.
>
>
>> This is caused by the fact that __stubs_start is not aligned correctly on XIP.
>>
>> Could you try this, please?
>>
>> diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S index 7160658fd5d4..a5b8e7b80d17 100644
>> --- a/arch/arm/kernel/vmlinux.lds.S
>> +++ b/arch/arm/kernel/vmlinux.lds.S
>> @@ -164,8 +164,8 @@ SECTIONS
>>          * The vectors and stubs are relocatable code, and the
>>          * only thing that matters is their relative offsets
>>          */
>> -       __stubs_start = .;
>>         .stubs : {
>> +               __stubs_start = .;
>>                 *(.stubs)
>>         }
>>         __stubs_end = .;
>
>
> Yup, that fixed it!
>
> bf353edc T _etext
> bf353ee0 t __stubs_start
> bf353ee0 T __stubs_start
> bf353ee4 t vector_rst
> bf353f00 t vector_irq
>
> and my new print out:
>
>      Stubs at c09ff000 :BF006F20 EF9F0000 EA000064 E320F000 etc...
>
>
> Now that it is working on my XIP system, I will say that I'm also happy to see that extra junk in kallsyms.c and link-vmlinux.sh be removed. Those things also caused me some issues when I first started trying to get the XIP_KERNEL stuff back working.
>

Glad to hear that it works now. Thanks a lot for testing.

-- 
Ard.
