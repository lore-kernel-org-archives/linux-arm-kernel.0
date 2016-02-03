From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 3 Feb 2016 14:41:29 +0100
Subject: [PATCH 0/3] kallsyms: remove special handling for CONFIG_ARM
In-Reply-To: <HKXPR06MB05656F902E0E1FBBDBD713DC8AD00@HKXPR06MB0565.apcprd06.prod.outlook.com>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
 <HKXPR06MB0565A2CFF95AD7C000F43E6A8ADF0@HKXPR06MB0565.apcprd06.prod.outlook.com>
 <CAKv+Gu9VvskQ34w0niS+6AtF9hNcycfYDt_3Kp4T+WK8Vxf_dA@mail.gmail.com>
 <HKXPR06MB05656F902E0E1FBBDBD713DC8AD00@HKXPR06MB0565.apcprd06.prod.outlook.com>
Message-ID: <CAKv+Gu8ZTHAqviveLMizRKPfeXwb6kcXi4cVQNYVYuPcVMgMeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 February 2016 at 14:33, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On 2 Feb 2016, Chris Brandt wrote:
>> I then applied the 3 patches and tried again and this time it booted
>> up....almost.
>> It looks like it makes it all the way up to when it is going to mount
>> my rootfs, but then dies.
>
>
> I did some debugging, and here's why I'm crashing.
>
>
> If you look at my System.map file, you'll see that I've got 2 "__stubs_start" symbols.
>
> One at 0x bf353edc, the other at 0x bf353ee0.
>
> bf353edc T __stubs_start

This is a global symbol

> bf353edc T _etext
> bf353ee0 t __stubs_start

This is a local symbol

> bf353ee4 t vector_rst
> bf353f00 t vector_irq
> bf353f80 t vector_dabt
> bf354000 t vector_pabt
> bf354080 t vector_und
> bf354100 t vector_addrexcptn
> bf354120 T vector_fiq
> bf3541a0 T __stubs_end
> bf3541a0 T __vectors_start
> bf3541c0 t __mmap_switched
> bf3541c0 T __vectors_end
>
>
> So, when you get to early_trap_init(), it grabs the first __stubs_start for the memcpy:
>
>         memcpy((void *)vectors + 0x1000, __stubs_start, __stubs_end - __stubs_start);
>

Indeed. It grabs the first one, which is the one defined by the linker script.

>
> And when a printed out the destination, I get:
>
>    Stubs at c09ff000 :00000000 BF006F20 EF9F0000 EA000064 etc...
>
> Notice the first entry is 0....that's not right...and we know it's using that first __stubs_start symbol.
>

The first quantity after __stubs_start should be the address of
vector_swi. Can you check if the second value coincides with that?

>
> So, I hacked the code and put an offset of 4 like this:
>
>         memcpy((void *)vectors + 0x1000, __stubs_start+4, __stubs_end - (__stubs_start+4));
>
>
> And sure enough it booted fine.
>
>
> So, why are there 2 __stubs_start symbols???
> I haven't figured that one out yet.
>

One defined by entry-armv.S and one defined by the linker script

> And, I'm assuming you guys don't have 2 __stubs_start symbols either, correct?
>

Yes, we do.

This is caused by the fact that __stubs_start is not aligned correctly on XIP.

Could you try this, please?

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 7160658fd5d4..a5b8e7b80d17 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -164,8 +164,8 @@ SECTIONS
         * The vectors and stubs are relocatable code, and the
         * only thing that matters is their relative offsets
         */
-       __stubs_start = .;
        .stubs : {
+               __stubs_start = .;
                *(.stubs)
        }
        __stubs_end = .;
