From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 04 Aug 2015 18:56:23 +0200
Subject: [PATCH v2 0/4] mtd: pxa3xx_nand: rework the timing setup
In-Reply-To: <CAAEAJfBMpQ8nf5aLTUqrCsJkMQbnkQTB1yA5MBiJ6R4h6RgupQ@mail.gmail.com>
 (Ezequiel Garcia's message of "Mon, 3 Aug 2015 10:48:55 -0300")
References: <1436281707-20106-1-git-send-email-antoine.tenart@free-electrons.com>
 <20150717134159.GC10608@kwain> <55A912F0.7080605@vanguardiasur.com.ar>
 <87h9p2is8e.fsf@belgarion.home>
 <CAAEAJfCcdioVQKZs9U3DP6H94BiuQ2qU21DsMKevS5+j+-XEKA@mail.gmail.com>
 <87wpxufw2v.fsf@belgarion.home>
 <CAAEAJfB3caa+DmJN=Pa8brx0uGC11QA29KJb3NQdJjXTgw-yuA@mail.gmail.com>
 <87si81m15m.fsf@belgarion.home>
 <CAAEAJfBMpQ8nf5aLTUqrCsJkMQbnkQTB1yA5MBiJ6R4h6RgupQ@mail.gmail.com>
Message-ID: <87d1z3m1qg.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> writes:

>>
>> The issue I see is that :
>>  - there is a bug in the clk driver for pxa3xx I introduced (CKEN_AB)

>>  - and shutting down the GCU clock prevents the NAND from working (I can't
>>  explain that one yet)

Ah actually it's even trickier, but it has nothing to do with the GCU clock,
that was a wrong interpretation of the test sequence.

What actually happens is that on the platform I have, the NAND is sharing the
DFI bus with the Static Memory Controller. Now let's see what happens on
boot-up, knowing that my pxa3xx-nand is a module, not builtin :
 - the kernel boots
 - the core clock initializes
 - the ethernet card initializes (it is on the static memory controller)
 - the kernel finishes the boot sequence
   => the NAND clock is unused
   => as such, the core clock framework disables it

And here is the catch : on the next ethernet access, the system bus will be
stalled forever. The reason behind is that because the bootloader left the
"NDCR_ND_ARB_EN" bit enabled, the DFI bus sees the ethernet register access, and
asks for arbitration; as the NAND clock is down, the arbitration never happens,
and the pxa3xx is stalled forever.

The very same thing happens when you load and unload pxa3xx-nand with a platform
where it was loaded with "enable-arbiter" platform-data, and if that platform
has any driver mapped in the SMC address space (0x0 .. 0x14000000).

If you have an opportunity to load/unload a pxa3xx-nand, I'd be glad to have
someone verify this theory.

The first fix comming to my mind would be to :
 - disable the NDCR_ND_ARB_EN in the pxa3xx core bring up
 - keep enablement in pxa3xx-nand
 - ensure it is disabled on the probe error path or remove of pxa3xx-nand

Cheers.

--
Robert

PS: That also means that the fix I posted for CKENA/CKENB inversion should fix
the issues you see.
