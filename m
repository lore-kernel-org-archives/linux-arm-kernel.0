From: minggr@gmail.com (Lin Ming)
Date: Tue, 9 Jul 2013 09:09:13 +0800
Subject: kernel decompressor problem for ARMv7
In-Reply-To: <1373250435.824.6.camel@minggr>
References: <CAF1ivSakn8-HiAf+4_cLRWUUTDP9QBKpAt+hVQoMyAmKZ2-dJA@mail.gmail.com>
 <20130705095757.GA13063@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1307051225240.18597@syhkavp.arg>
 <CAF1ivSbOXknHyDMH3RdmSGK2n5o2wVeR5oohCQnZ2gJrgvo=Hw@mail.gmail.com>
 <1373250435.824.6.camel@minggr>
Message-ID: <CAF1ivSbk70UnNc-09C2w-CdgaFBXe_k6K6n8Qr3L-jCLiTGqow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 8, 2013 at 10:27 AM, Lin Ming <minggr@gmail.com> wrote:
> On Sat, 2013-07-06 at 00:58 +0800, Lin Ming wrote:
>> On Sat, Jul 6, 2013 at 12:30 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> > On Fri, 5 Jul 2013, Will Deacon wrote:
>> >
>> >> On Fri, Jul 05, 2013 at 09:44:12AM +0100, Lin Ming wrote:
>> >> > Hi all,
>> >>
>> >> Hello,
>> >>
>> >> > I'm porting BSP code from v2.6.36 to v3.10 kernel. It's ARMv7 processor.
>> >>
>> >> Which specific processor/SoC?
>> >>
>> >> > But decompressor doesn't work. With a lot of debug, I finally find
>> >> > below 2 commits related.
>> >> > Kernel uncompress OK with these commits reverted.
>> >> >
>> >> > dbece45: ARM: 7501/1: decompressor: reset ttbcr for VMSA ARMv7 cores
>> >> > (Introduced in v3.6-rc6)
>> >> >
>> >> > 5010192: ARM: 7583/1: decompressor: Enable unaligned memory access for
>> >> > v6 and above
>> >> > (Introduced in v3.7-rc8)
>> >> >
>> >> > Any hint to fix it?
>> >>
>> >> There's not really enough information to go on here. What specifically
>> >> fails? Also, do you have to revert *both* of the above changes to get things
>> >> working again?
>> >
>> > Also, what is the bootloader used here?
>>
>> uboot.
>>
>> >
>> > Does the bootloader call the kernel with the MMU off as documented in
>> > Documentation/arm/Booting?
>>
>> How to check this?
>>
>> I'll check uboot code or add debug code in boot/compressed/head.S to
>> check it next Monday.
>
> I added below debug code to print the control reg from lowest 4bits to
> highest 4bits.
>
> It prints "B7805C". So the control reg is 0x00c5087b.
> Seems bootloader calls the kernel with MMU enabled and Alignment fault
> checking enabled.

Hi Nicolas,

Is this information useful?
Or any other information needed for further debug?

Thanks,
Lin Ming

>
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 32337ff..9434720 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -125,6 +125,23 @@
>                 .rept   7
>                 mov     r0, r0
>                 .endr
> +
> +               /* Dirty debug code to print control reg from lowest 4bits to highest 4bits */
> +               ldr     r2, =0xf0070120         @ UART
> +               mrc     p15, 0, r0, c1, c0, 0   @ read control reg
> +       1:
> +               cmp     r0, #0
> +               beq     2f
> +               and     r1, r0, #15
> +               cmp     r1, #9
> +               addgt   r1, r1, #7
> +               add     r1, r1, #48
> +               str     r1, [r2]
> +               asr     r0, r0, #4
> +               b       1b
> +       2:
> +
> +
>     ARM(                mov     r0, r0          )
>     ARM(                b       1f              )
>   THUMB(                adr     r12, BSYM(1f)   )
>
>
>>
>> >
>> > Nicolas
>
>
