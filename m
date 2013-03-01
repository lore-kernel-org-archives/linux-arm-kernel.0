From: nm@ti.com (Nishanth Menon)
Date: Fri, 1 Mar 2013 08:38:34 -0600
Subject: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
In-Reply-To: <517283541.62064.1362124023621.JavaMail.apache@mail81.abv.bg>
References: <517283541.62064.1362124023621.JavaMail.apache@mail81.abv.bg>
Message-ID: <CAGo_u6omQdSzpfthHNAU1UvgSvkgq3ZC6g1Ha9oi0nc9QJ71nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 1, 2013 at 1:47 AM, ?????? ???????? <freemangordon@abv.bg> wrote:
>
> They look similar, but they are not equivalent :). The first major difference is here (code taken from omap-smc.S)
>
>> ENTRY(omap_smc2)
>>          stmfd   sp!, {r4-r12, lr}
>>          mov     r3, r2
>>          mov     r2, r1
>>          mov     r1, #0x0        @ Process ID
>>          mov     r6, #0xff
>>          mov     r12, #0x00      @ Secure Service ID
>
> Always zero, while RX51 PPA expects a real value. I wonder if it is a bug, but anyway I don't see the id parameter (R0) used.
>
>>          mov     r7, #0
>>          mcr     p15, 0, r7, c7, c5, 6
>
> According to ARM TRM, this is "Invalidate entire branch predictor array"(IIUC). NFC why it is needed here, but this will not work on RX-51 until IBE bit in ACR is set.
>
>>          dsb
>>          dmb
>>          smc     #0
>
> RX-51 needs smc #1 ;)
>
>>          ldmfd   sp!, {r4-r12, pc}
>
>
> The next major difference is that RX-51 expects parameter count passed in R3[0] to be the count of the remaining parameters +1, but omap_secure_dispatcher (in omap-secure.c) is passing the exact count of the remaining parameters.
>
> I guess all of the above problems can be fixed/workarounded, but I wonder does it worth. Not to say that I don't have BB around to test if the code still works if I make changes to omap2-secure.c/omap-smc.S :)
>
>

Yep, that was my point - instead of introducing new functions,
extending the existing functions to handle new requirements is better
solution, IMHO.

Regards,
Nishanth Menon
