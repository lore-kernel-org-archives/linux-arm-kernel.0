From: hs@denx.de (Heiko Schocher)
Date: Tue, 24 Jan 2012 08:23:46 +0100
Subject: [RFC PATCH 6/7] ARM: mtd: nand: davinci: add OF support for
 davinci nand controller
In-Reply-To: <4F1DF465.60206@freescale.com>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-7-git-send-email-hs@denx.de> <4F1DF465.60206@freescale.com>
Message-ID: <4F1E5C82.60108@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Scott,

Scott Wood wrote:
> On 01/23/2012 02:56 AM, Heiko Schocher wrote:
>> diff --git a/Documentation/devicetree/bindings/arm/davinci/nand.txt b/Documentation/devicetree/bindings/arm/davinci/nand.txt
>> new file mode 100644
>> index 0000000..7e8d6db
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/davinci/nand.txt
>> @@ -0,0 +1,72 @@
>> +* Texas Instruments Davinci NAND
>> +
>> +This file provides information, what the device node for the
>> +davinci nand interface contain.
>> +
>> +Required properties:
>> +- compatible: "ti,davinci-nand";
>> +- reg : contain 2 offset/length values:
>> +        - offset and length for the access window
>> +        - offset and length for accessing the aemif control registers
>> +- id: id of the controller
> 
> What does "id of the controller" mean, specfically?  From this I can't
> even tell if it's a number or a string, much less how to use it
> semantically.  If it's just a "match what's in the manual" thing,
> perhaps an alias would be better here.  Or, if it's a value with a
> specific meaning (e.g. that you need to program into a register) use a
> more specific name.

Ok, fix this. Id means here, which chipselect the controller uses.
Maybe it is better to rename it to "chipselect" ?

>> +Recommended properties :
>> +- mask_ale: mask for ale
>> +- mask_cle: mask for cle
>> +- mask_chipsel: mask for chipselect
>> +- ecc_mode: ECC mode, see NAND_ECC_* defines
>> +- ecc_bits: used ECC bits
>> +- options: nand options, defined in
>> +           include/linux/mtd/nand.h, grep for NAND_NO_AUTOINCR
>> +- bbt_options: NAND_BBT_* defines
> 
> Binding-specific properties should have a vendor prefix.  Dashes are
> preferred to underscores.

You think something like that:

davinci-mask-ale
davinci-mask-cle
...

?

> Don't specify Linux internals by reference -- they could change and
> invalidate existing device trees and non-Linux code that accepts them
> (e.g. U-Boot).  If you want them to line up, copy the definition here,
> and if Linux changes, write glue code to convert.  It would probably be
> better to define specific properties for anything that must be specified
> here (neither deteted dynamically nor defined by compatible =
> "ti,davinci-nand").

Ok, I add the defines here, and add also a comment in the dts.

> Do all of these properties really belong here?  I can see providing some

I think so, because this values come from existing platform code
(grep for struct davinci_nand_pdata)

> information about ECC or BBT mode, if there are multiple conventions
> already in use (or that are reasonably justifiable for different
> situations), as that must agree with how the flash has already been
> programmed.  How much of the rest can vary from one "ti,davinci-nand" to
> another?  Maybe it's obvious to someone more familiar with davinci, but
> what does "mask for ale/cle/chipselect" mean?

I mapped here just the existing platform code (=struct davinci_nand_pdata)
to OF, so existing boards can easy switch to OF.

Comment in arch/arm/mach-davinci/include/mach/nand.h says for
mask_ale and mask_cle:

/* NOTE:  boards don't need to use these address bits
 * for ALE/CLE unless they support booting from NAND.
 * They're used unless platform data overrides them.
 */

It is used for addressing the ALE/CLE Signals through the address,
used on the arch/arm/mach-davinci/board-dm646x-evm.c and
arch/arm/mach-davinci/board-tnetv107x-evm.c board ... so I think,
this should be also be setupable through OF ...

>> +	nandflash at 3,0 {
> 
> PowerPC's ePAPR document -- not directly relevant to ARM, but contains a
> more recently updated list of generic names than the IEEE1275
> recommended pratice -- specifies "flash@".  If you don't want to do
> that, "nand@" is used in many existing trees.  Why introduce a new name?

There is no reason for that, change this to "nand@".

Thanks for the review.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
