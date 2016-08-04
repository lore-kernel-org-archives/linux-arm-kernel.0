From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 4 Aug 2016 16:11:21 +0200
Subject: [PATCH 0/8] ARM: clean up PC-relative arithmetic
In-Reply-To: <alpine.LFD.2.20.1608031336020.17623@knanqh.ubzr>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.LFD.2.20.1608031336020.17623@knanqh.ubzr>
Message-ID: <CAKv+Gu_=Drf=0UwRBw8J8kup0FZ8HwUM7Fqg6GyLBCmFKHk1UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 August 2016 at 20:27, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Wed, 3 Aug 2016, Ard Biesheuvel wrote:
>
>> There are various places in the ARM kernel where the following pattern
>> is used to create a PC-relative reference that is valid even before the
>> MMU is on:
>>
>>      adr    rX, 1f
>>      ldr    rY, [rX]
>>      add    rX, rX, rY
>>      ...
>>   1: .long  <symbol> - .
>>
>> or
>>      adr    rX, 1f
>>      ldmia  rX, {rY .. rY+n}
>>      sub    rX, rX, rY
>>      add    rY+1, rY+1, rX
>>      add    rY+2, rY+2, rX
>>      ...
>>   1: .long  .
>>      .long  <symbolY>
>>      .long  <symbolY+1>
>>      ...
>>
>> Both cases can be greatly simplified by letting the linker do the
>> calculations for us. This series implements adr_l, ldr_l and str_l
>> macros, and uses them to simplify a couple of instances of the above
>> patterns.
>
> I echo Dave's concern about the availability of the :pc_g*_nc: relocs.
>
> Could this be used to solve the XIP translation problem in some
> universal way? Right now only a few cases are covered. For reference, see:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/386273.html
>
> commit d7811455 ("ARM: 8512/1: proc-v7.S: Adjust stack address when XIP_KERNEL")
>
> commit 8ff97fa3 ("ARM: make the physical-relative calculation more obvious")
>

I don't see how we could use this to improve that, tbh.
