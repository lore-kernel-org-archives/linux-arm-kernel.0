From: frowand.list@gmail.com (Frank Rowand)
Date: Wed, 16 Aug 2017 23:15:53 -0700
Subject: [PATCH] ARM: dts: TI: Enable __symbols__ in dtb files for some
 platforms
In-Reply-To: <20170817003355.GR20467@bill-the-cat>
References: <1502920751-11121-1-git-send-email-trini@konsulko.com>
 <5994C81C.609@gmail.com> <5994CDD1.9050708@gmail.com>
 <20170817003355.GR20467@bill-the-cat>
Message-ID: <59953499.60000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/17 17:33, Tom Rini wrote:
> On Wed, Aug 16, 2017 at 03:57:21PM -0700, Frank Rowand wrote:
>> On 08/16/17 15:33, Frank Rowand wrote:
>>> On 08/16/17 14:59, Tom Rini wrote:
>>>> Build the dtb file for these platfroms with __symbol__ information
>>>> included.  This will reduce the size of the dtb (and resident memory
>>>
>>> typo: reduce the size should be increase the size
>>>
>>>
>>>> usage) in exchange for allowing more types of overlays to be applied to
>>>> the dtb file prior to passing it to Linux and additional functionality
>>>> within the kernel when OF_OVERLAY is enabled.
>>>>
>>>> Cc: Jason Kridner <jkridner@beagleboard.org>
>>>> Cc: Drew Fustini <drew@beagleboard.org>
>>>> Cc: Robert Nelson <robertcnelson@gmail.com>
>>>> Cc: Lokesh Vutla <lokeshvutla@ti.com>
>>>> Cc: Frank Rowand <frowand.list@gmail.com>
>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>> Cc: devicetree at vger.kernel.org
>>>> Cc: linux-arm-kernel at lists.infradead.org
>>>> Cc: linux-kernel at vger.kernel.org
>>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>>> ---
>>>> This patch takes the path that Rob encouraged in my previous patch of
>>>> enabling __symbols__ in some platforms now (that can use it) and see if
>>>> a critical mass evolves that pushes towards -@ being default for all
>>>> dtbs.  I would suggest that the dra76 series be respun to include a hunk
>>>> like this at least as well, and if there's another Beagle X15 patch,
>>>> that too.  Russell, per some of our conversations, something like would
>>>> also be needed as part of using overlays to solve some of the problems
>>>> with Hummingboard, etc.
>>>> ---
>>>>  arch/arm/boot/dts/Makefile | 14 ++++++++++++++
>>>>  1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>>> index 4b17f35dc9a7..6f98422ca00e 100644
>>>> --- a/arch/arm/boot/dts/Makefile
>>>> +++ b/arch/arm/boot/dts/Makefile
>>>> @@ -1063,3 +1063,17 @@ dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dts
>>>>  
>>>>  always		:= $(dtb-y)
>>>>  clean-files	:= *.dtb
>>>> +
>>>> +# enable creation of __symbols__ node
>>>> +DTC_FLAGS_am335x-bone += -@
>>>> +DTC_FLAGS_am335x-boneblack += -@
>>>> +DTC_FLAGS_am335x-boneblack-wireless += -@
>>>> +DTC_FLAGS_am335x-boneblue += -@
>>>> +DTC_FLAGS_am335x-bonegreen += -@
>>>> +DTC_FLAGS_am335x-bonegreen-wireless += -@
>>>> +DTC_FLAGS_am57xx-beagle-x15 += -@
>>>> +DTC_FLAGS_am57xx-beagle-x15-revb1 += -@
>>>> +DTC_FLAGS_dra7-evm += -@
>>>> +DTC_FLAGS_dra72-evm += -@
>>>> +DTC_FLAGS_dra72-evm-revc += -@
>>>> +DTC_FLAGS_dra71-evm += -@
>>>>
>>>
>>> I would prefer that instead of "-@", a configurable value be used.
>>
>> I stated that poorly.  It was intended conceptually, not literally.
>>
>> One possible concrete implementation would be to use something other
>> than DTC_FLAGS, for example DTC_FLAGS_EXTRA, then have the build
>> system choose whether to fold DTC_FLAGS_EXTRA into DTC_FLAGS, based
>> on some sort of configurable value.
> 
> So you would have to pass in a flag, and then set a CONFIG option for
> "please use this flag I just explicitly set" ?

I'm aware there is some ugliness there, and still open to someone having
a better idea that we have not yet considered.

But yes, the desired functionality over rides the ugliness.  Forcing the
overhead for all users of the board, even those who will never use an
overlay is not a good choice.  The ability to opt out is important.
