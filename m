From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 8 Jun 2018 10:47:18 +0200
Subject: [PATCH v4 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
In-Reply-To: <OSBPR01MB2054A701CF65784FAB947692D27B0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1528198148-23308-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528198148-23308-3-git-send-email-michel.pollet@bp.renesas.com>
 <0481173f-6384-98d6-707c-89dc5ef103f0@gmail.com>
 <OSBPR01MB2054E3A1E383495F3534B551D2650@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <9cef7124-3020-5741-f3a2-6925a6c8f0f3@gmail.com>
 <79c0899e-7df1-1fe7-9681-ad3bd51feda7@gmail.com>
 <OSBPR01MB205442B483C792125E6A6AF7D2640@OSBPR01MB2054.jpnprd01.prod.outlook.com>
 <CAL_JsqLn+x0JCkjwABU7XkPsgvyVdiCRq=gZTfUBbbR4-c+1bQ@mail.gmail.com>
 <OSBPR01MB2054A701CF65784FAB947692D27B0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
Message-ID: <CAMuHMdUOqLhmb8kXOxriQ5mt_4rDQJbUqGsQiJBSkq5J5FWG7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 8, 2018 at 8:50 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> On 07 June 2018 16:55, Rob wrote:
>> On Thu, Jun 7, 2018 at 1:59 AM, Michel Pollet
>> <michel.pollet@bp.renesas.com> wrote:
>> > On 06 June 2018 22:53, Frank wrote:
>> >> On 06/06/18 14:48, Frank Rowand wrote:
>> >> > On 06/05/18 23:36, Michel Pollet wrote:
>> >> >> On 05 June 2018 18:34, Frank wrote:
>> >> >>> On 06/05/18 04:28, Michel Pollet wrote:
>> >> >>>> The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot
>> >> >>>> time, it requires a special enable method to get it started.
>>
>> [...]
>>
>> >> >>>> + * The second CPU is parked in ROM at boot time. It requires
>> >> >>>> +waking it after
>> >> >>>> + * writing an address into the BOOTADDR register of sysctrl.
>> >> >>>> + *
>> >> >>>> + * So the default value of the "cpu-release-addr" corresponds
>> >> >>>> +to
>> >> >>> BOOTADDR...
>> >> >>>> + *
>> >> >>>> + * *However* the BOOTADDR register is not available when the
>> >> >>>> +kernel
>> >> >>>> + * starts in NONSEC mode.
>> >> >>>> + *
>> >> >>>> + * So for NONSEC mode, the bootloader re-parks the second CPU
>> >> >>>> +into a pen
>> >> >>>> + * in SRAM, and changes the "cpu-release-addr" of linux's DT to
>> >> >>>> +a SRAM address,
>> >> >>>> + * which is not restricted.
>> >> >>>
>> >> >>> The binding document for cpu-release-addr does not have a
>> >> >>> definition for 32 bit arm.  The existing definition is only 64
>> >> >>> bit arm.  Please add the definition for 32 bit arm to patch 1.
>> >> >>
>> >> >> Hmmm I do find a definition in
>> >> >> Documentation/devicetree/bindings/arm/cpus.txt -- just under where
>> >> >> I added my 'enable-method' -- And it is already used as 32 bits in
>> >> >> at least arch/arm/boot/dts/stih407-family.dtsi.
>> >> >
>> >> > If the correct answer is for cpu-release-addr to be 64 bits in
>> >> > certain cases (that discussion is ongoing further downthread) then
>> >> > one approach to maintain compatibility _and_ to fix the devicetree
>> >> > source files is to change the source code that currently gets
>> >> > cpu-release-addr as a
>> >> > 32 bit object to check the size of the property and get it as
>> >> > either a
>> >> > 32 bit or 64 bit object, based on the actual size of the property
>> >> > in the device tree and then change the value in the devicetree
>> >> > source files to be two cells.  BUT this does not consider the
>> >> > bootloader complication.  arch/arm/boot/dts/axm5516-cpus.dtsi has a
>> >> > note "// Fixed by the boot loader", so the boot loader also has to
>> >> > be modified to be able to handle the possibility that the property
>> >> > could be either
>> >> > 32 bits or 64 bits.  I don't know how to maintain compatibility
>> >> > with the boot loader since we can't force it to change
>> >> > synchronously with changes in the kernel.
>> >> >
>> >> > You can consider this comment to be a drive-by observation.  I
>> >> > think Rob and Geert and people like that are likely to be more
>> >> > helpful with what to actually do, and you can treat my comment more
>> >> > as pointing out the issue than as providing the perfect solution.
>> >>
>> >> Darn it, hit <send> too quickly.
>> >>
>> >> I meant to mention that there are several devicetree source files
>> >> that have a single cell value for cpu-release-addr, and thus
>> >> potentially face the same situation, depending on what the final
>> >> decision is on the proper size for cpu- release-addr. As of v4.17, a git grep
>> shows one cell values in:
>> >>
>> >>   arch/arm/boot/dts/axm5516-cpus.dtsi
>> >>   arch/arm/boot/dts/stih407-family.dtsi
>> >>   arch/arm/boot/dts/stih418.dtsi
>> >
>> > Yes, I had grepped before I used 32 bits on mine...
>> >
>> > Now, what is the decision here? Our bootloader is already modified to
>> > set it to 32 bits, so I propose that
>>
>> And too late to fix the bootloader?
>
>
> Well not too late, but read further on...
>
>>
>> >
>> > + I change the driver to handle 32 and 64 bits properties
>>
>> That's fine if you can't fix the bootloader.
>>
>> > + I add this to the cpu.txt, as a separate patch:
>> > # On other systems, the property can be either
>> >   32 bits or 64 bits, it is the driver's responsibility
>> >   to deal with either sizes.
>>
>> That is definitely not what we want to say. Use of 32-bit should be
>> considered out of spec. Yes, we have a few platforms in that category, but
>> they already handle that themselves. Would be nice to fix them, but at least
>> the STi platforms don't seem too active.
>>
>> IMO, we should delete whatever text we can here and at most just refer to
>> the spec.
>
> So actually I didn't use 32 bits by plain chance, I read the cpu.txt file which says
> that 64 bits systems use 64 bits property, concluded that in my case I ought to
> use 32 bits, then grepped around and found other systems using 32 bits, therefore
> I went forward and used it..
>
> Nothing said here that it should be 64 bits everywhere -- So the documentation
> needs fixing somehow. Right now it certainly led me wrong.

Perhaps we should add to Documentation/devicetree/bindings/ the standard
bindings from ePAPR and successors, too?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
