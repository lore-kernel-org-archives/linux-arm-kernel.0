From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Apr 2018 14:43:42 +0200
Subject: [PATCH] ARM: dts: Restructure Vexpress motherboard includes
In-Reply-To: <86a95dd0-a702-3dce-e69b-20205a519a88@arm.com>
References: <20180417114331.5233-1-linus.walleij@linaro.org>
 <86a95dd0-a702-3dce-e69b-20205a519a88@arm.com>
Message-ID: <CACRpkda0Fq+b4htyx=8Kez7UGj_jQ-MO1orL=QESQ-JaAAjG=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 2:21 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 17/04/18 12:43, Linus Walleij wrote:
>>
>> It is a bit unorthodox to just include a file in the middle
>> of a another DTS file, it breaks the pattern from other device
>> trees and also makes it really hard to reference things
>> across the files with phandles.
>>
>> Restructure the include for the Versatile Express motherboards
>> to happen at the top of the file, reference the target nodes
>> directly, and indent the motherboard .dtsi files to reflect
>> their actual depth in the hiearchy.
>>
>> This is a purely syntactic change that result in the same
>> DTB files from the DTS/DTSI files.
>
>
> FWIW this is kind of the 32-bit equivalent of d29e849cafe6 ("arm64: dts:
> juno: remove dtsi nesting inside tree structure") - I seem to recall that
> whilst the nodes within the DTB remained identical, they did end up in a
> different order, which at the time gave me problems with the SP804 sometimes
> registering as the first clocksource before the arch timer, and boot
> subsequently getting stuck in an infinite loop trying to replace it. That
> doesn't seem to have happened in ages though, so I guess something somewhere
> might have been fixed...

Yeah it works here and on QEMU so I think we're safe.

>> +/ {
>> +       smb at 8000000 {
>
>
> Nit: Surely "&smb {", given that you've already gone to the length of
> labelling it in the includers? (plus that should also avoid the need to
> reindent)

I tried that and it didn't work.

I guess it is because the includes go in the reverse parsing order, this
file is included into the main DTS.

If the &smb was referenced from the DTS to the definition in
the DTSI, it would work fine.

However the reverse, &smb before the node has been defined
(it's in the DTS) doesn't work and seems to reflect to top-to-bottom
parsing scheme.

I didn't drill deeper into it.

Yours,
Linus Walleij
