From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 15 Jan 2018 15:08:59 +0000
Subject: stable-rc build: 2 warnings 0 failures
 (stable-rc/v4.14.13-119-gb32d455)
In-Reply-To: <CAK8P3a2vXJT1g6wa4cbcDJ48sfOKfemazV0e1crJ5v=6DOZ5fg@mail.gmail.com>
References: <5a5c9ee8.cf53650a.dae00.f369@mx.google.com>
 <CAK8P3a2vXJT1g6wa4cbcDJ48sfOKfemazV0e1crJ5v=6DOZ5fg@mail.gmail.com>
Message-ID: <CAKv+Gu9ZyXjiKfD6cqEpexdVA_CnYr1kByZJQcKBuK7ig=7MmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 January 2018 at 13:38, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jan 15, 2018 at 1:30 PM, Olof's autobuilder <build@lixom.net> wrote:
>
>> Warnings:
>>
>>         arm.allmodconfig:
>> /tmp/cccX4oa4.s:18153: Warning: using r15 results in unpredictable behaviour
>> /tmp/cccX4oa4.s:18225: Warning: using r15 results in unpredictable behaviour
>
> This appears to be an old issue that only now started to get reported
> here. From what I can
> tell, new versions of binutils warn about two isntructions in the kprobes test:
>
> Maybe we can work around it using a patch like below?
>
>         Arnd
>

Can't we just add -Wa,--no-warn for this file?


> diff --git a/arch/arm/probes/kprobes/test-arm.c
> b/arch/arm/probes/kprobes/test-arm.c
> index 8866aedfdea2..8b7df0ce04d2 100644
> --- a/arch/arm/probes/kprobes/test-arm.c
> +++ b/arch/arm/probes/kprobes/test-arm.c
> @@ -169,10 +169,10 @@ void kprobe_arm_test_cases(void)
>
>         /* Data-processing with PC as a target and status registers updated */
>         TEST_UNSUPPORTED("movs  pc, r1")
> -       TEST_UNSUPPORTED("movs  pc, r1, lsl r2")
> +       TEST_UNSUPPORTED(__inst_arm(0xe1b0f211) "       @ movs  pc, r1, lsl r2")
>         TEST_UNSUPPORTED("movs  pc, #0x10000")
>         TEST_UNSUPPORTED("adds  pc, lr, r1")
> -       TEST_UNSUPPORTED("adds  pc, lr, r1, lsl r2")
> +       TEST_UNSUPPORTED(__inst_arm(0xe09ef211) "       @ adds  pc,
> lr, r1, lsl r2")
>         TEST_UNSUPPORTED("adds  pc, lr, #4")
>
>         /* Data-processing with SP as target */
