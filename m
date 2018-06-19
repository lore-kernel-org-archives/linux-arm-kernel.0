From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 20 Jun 2018 00:23:56 +0200
Subject: [PATCH 0/2] Make badr macro compatible with newer GAS versions
In-Reply-To: <20180619204531.GB28370@roeck-us.net>
References: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
 <20180619203223.GA28370@roeck-us.net>
 <CAKv+Gu-RHM7HAmzWw9Ge+w21kWxKxLbJT7DD5huv-7WWOPUVWA@mail.gmail.com>
 <20180619204531.GB28370@roeck-us.net>
Message-ID: <CAKv+Gu_zsSxb_8Ej-6QwZOW2X5VfgW0gnjpnHpi62L6nPALoHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 June 2018 at 22:45, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Jun 19, 2018 at 10:34:38PM +0200, Ard Biesheuvel wrote:
>> On 19 June 2018 at 22:32, Guenter Roeck <linux@roeck-us.net> wrote:
>> > On Tue, Jun 19, 2018 at 09:26:31PM +0200, Ard Biesheuvel wrote:
>> >> Work around the mindless and backward incompatible change in GAS that
>> >> prevents us from using a simple addition to set the Thumb bit in local
>> >> symbol references taken using 'adr' instructions (#2)
>> >>
>> >> As a preparatory step, remove badr occurrences in ARM code sequences
>> >> contained in Thumb2 kernels.
>> >>
>> >> Ard Biesheuvel (2):
>> >>   ARM: avoid badr macro for switching to Thumb-2 mode
>> >>   ARM: assembler: prevent ADR from setting the Thumb bit twice
>> >>
>> >
>> > This doesn't work for images built with a toolchain based on gcc 7.3.0
>> > and binutils 2.28.1. It _does_ work for images built with gcc 7.3.0/
>> > binutils 2.30.
>> >
>>
>> Sigh.
>>
>> So does it fail? Or is the resulting binary broken?
>
> Hard to say. It crashes early in boot, even before earlycon can say
> anything.
>

OK, so even the linker handling is inconsistent.

Working (binutils 2.30)

c0301164 <local_restart>:
c0301164:       f8d9 a000       ldr.w   sl, [r9]
c0301168:       e92d 0030       stmdb   sp!, {r4, r5}
c030116c:       f01a 0ff0       tst.w   sl, #240        ; 0xf0
c0301170:       d117            bne.n   c03011a2 <__sys_trace>
c0301172:       46ba            mov     sl, r7
c0301174:       f5ba 7fc8       cmp.w   sl, #400        ; 0x190
c0301178:       bf28            it      cs
c030117a:       f04f 0a00       movcs.w sl, #0
c030117e:       f3af 8014       csdb
c0301182:       f2af 1e83       subw    lr, pc, #387    ; 0x183
                        c0301182: R_ARM_THM_ALU_PREL_11_0       .Lsym28


Broken (binutils 2.26)

c0301184 <local_restart>:
c0301184:       f8d9 a000       ldr.w   sl, [r9]
c0301188:       e92d 0030       stmdb   sp!, {r4, r5}
c030118c:       f01a 0ff0       tst.w   sl, #240        ; 0xf0
c0301190:       d117            bne.n   c03011c2 <__sys_trace>
c0301192:       46ba            mov     sl, r7
c0301194:       f5ba 7fc8       cmp.w   sl, #400        ; 0x190
c0301198:       bf28            it      cs
c030119a:       f04f 0a00       movcs.w sl, #0
c030119e:       f3af 8014       csdb
c03011a2:       f2af 1ea2       subw    lr, pc, #418    ; 0x1a2
                        c03011a2: R_ARM_THM_ALU_PREL_11_0       .Lsym30


Note the even immediate in the subw instruction. So this is another
dead end, unfortunately.

Thanks for testing.
