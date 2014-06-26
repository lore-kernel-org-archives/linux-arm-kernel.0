From: jkridner@gmail.com (Jason Kridner)
Date: Thu, 26 Jun 2014 11:27:08 -0400
Subject: Unifying cape overlays into boot .dtb for BeagleBoard.org boards
In-Reply-To: <53AC1AC5.5000103@ti.com>
References: <CA+T6QP==raXdWz9mezK3JxSvZjWhUZZ7aKv4CpCr0SbdaCMgDQ@mail.gmail.com>
 <CA+T6QP=jqdKij3bg3qZKT8GAKTKP94XtDWR+rcJWnDME5ZNmUg@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EAF59A7@DBDE04.ent.ti.com>
 <CA+T6QP=Q0db33NU1g=9QrOUqQhLfKg=UiHVSn=Loog_JFxtP1w@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EAF5DD0@DBDE04.ent.ti.com>
 <20140626075039.GG28884@atomide.com> <53AC1AC5.5000103@ti.com>
Message-ID: <CA+T6QP=-mUz_uGg6eZEdP-1y9hyYJfDbx+363THSJarF=dTcog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 9:06 AM, Tom Rini <trini@ti.com> wrote:
> On 06/26/2014 03:50 AM, Tony Lindgren wrote:
>> * Gupta, Pekon <pekon@ti.com> [140618 01:52]:
>>> Hi,
>>>
>>>> From: Jason Kridner [mailto:jkridner at gmail.com]
>>>>> On Tue, Jun 17, 2014 at 3:11 AM, Gupta, Pekon <pekon@ti.com> wrote:
>>>>>> From: Jason Kridner
>>> [...]
>>>>>>> * The devicetree sources, including the primary boot .dts files, will
>>>>>>> eventually be removed from the kernel source tree. I'm not too sure if
>>>>>>> and when it'll really happen, but starting up a project to maintain
>>>>>>> the definitive beagleboard.org board devicetree files outside the
>>>>>>> kernel seems to make sense. Given the interdependency of the boot .dtb
>>>>>>> and the overlay .dtbo files, combining them into a single repository
>>>>>>> where every distribution can pick them up seems like a natural and
>>>>>>> obvious choice. There are of course some dependencies on kernel
>>>>>>> versions, but I believe most of those have settled out by now and we
>>>>>>> should be OK moving forward.
>>>>>
>>>>> +1
>>>>> Yes, moving cape DTS out of kernel tree should help developers.
>>>>> There are quite a few cape patches floating in mail-lists, but as cape
>>>>> DTS is still not accepted in mainline so they get lost and forgotten.
>>>>> So one place for collecting all this is a good idea.
>>>>>
>>>>>
>>>>> However, somehow the universal I/O DTS looked seemed complicated:
>>>>> (1)
>>>>> All capes work standalone, but due to share pin-mux some cape
>>>>> combinations cannot be used simultaneously. But most users of
>>>>> BeagleBone are already well-versed with DT and kernel infrastructure,
>>>>> so they need not be spoon fed to get a out-of-box working solution
>>>>> for each combination. If there is proper documentation is available
>>>>> about compatibility of capes with each other, then users will figure
>>>>> out themselves.
>>>>
>>>> I think you have too much confidence in users. If this doesn't hurt
>>>> power users, then why is it bad have an option to spoon feed? This
>>>> doesn't prevent anyone with knowledge of DT from doing their own
>>>> thing.
>>>>
>>> Fair enough.
>>> But plz give a try to u-boot alternative below. It works at my end.
>>>
>>>>>
>>>>> (2)
>>>>> Also, there was a talk of enabling and disabling DT fragments via u-boot.
>>>>> That should also be explored instead of complicating cape DTS.
>>>>
>>>> Link? Relevance?
>>>>
>>> we can modify DT from u-boot itself [1].
>>> Example:  "MMC2" pin-mux conflicts with "NAND" and "NOR" capes.
>>> But using following sequence of commands, you can modify DTB via
>>> u-boot and make NAND cape work _without_any_hack_ in patch [2].
>>>
>>> /* load DTB */
>>> u-boot> tftp 0x81000000 am335x-boneblack.dtb
>>> u-boot> fdt addr 0x81000000
>>> /* disable MMC2 node */
>>> u-boot> fdt list /ocp/mmc at 481d8000
>>> u-boot> fdt set  /ocp/mmc at 481d8000 status \d\i\s\a\b\l\e\d
>>> u-boot> fdt list /ocp/mmc at 481d8000 status
>>> /* enable GPMC node */
>>> u-boot> fdt list /ocp/gpmc
>>> u-boot> fdt set  /ocp/gpmc status \o\k\a\y
>>> u-boot> fdt list /ocp/gpmc status
>>> /* enable ELM node */
>>> u-boot> fdt list /ocp/elm
>>> u-boot> fdt set  /ocp/elm status \o\k\a\y
>>> u-boot> fdt list /ocp/elm status
>>> /* boot uImage */
>>> tftp 0x82000000 uImage
>>> bootm 0x82000000 - 0x81000000
>>>
>>> Note: "fdt set" command does not accept string literals
>>> as binding values, it internally converts them to string, so
>>> escape sequenced characters were used here..
>>> "okay" == \o\k\a\y
>>> "disabled" == \d\i\s\a\b\l\e\d"
>>>
>>>
>>> Hope above solves the pre-requisite because of which 'Tony Lindgren <tony@atomide.com>'
>>> was unable to accept cape related DTS into his tree [3]
>>
>> Yes. If the capes are disabled by default we can have at
>> least some of them included in the mainline kernel and
>> enabled by the bootloader as needed. I'd like to hear back
>> from the u-boot people too on this approach naturally.

Great.

>>
>> And some things we still cannot merge if they overlap for
>> GPMC bindings for example. So we have to carefully check
>> the generated .dtb file with dtc -I dtb -O dts.
>
> This sounds really problematic to me from an end-user horror point of
> view.  And fortunately 3.17 is going to have some level of overlay
> support so we can set this problem aside (and even treat the am335x gp
> evm "profileN" trees as overlays too).

Thank you Tom for chiming in. I think the end user experience is
horrific. Pekon should at least provide patches to u-boot that would
provide a mechanism to enable/disable a cape with a single operation,
rather than the individual devicetree nodes. This seems to really
break any ability to keep information about a cape consolidated or
usable by mere mortals.

I don't know that pushing it all into the kernel with overlays,
however, is the right answer. We've seen challenges with some
userspaces not exposing /lib/firmware in time and needing to compile
overlays into the kernel to make them work. More troublesome are the
types of errors end-users get when there are syntax errors, conflicts
or other failures, most notably because testing of loading all of the
various overlays in conflict with each other is adhoc at best. We've
gotten a lot of good feedback on using the pinmux-helper and
config-pin utility from end users who are still struggling to learn
how to do devicetree overlays properly. It seems to me that kernel
run-time overlays should be used for development and dynamic hardware
rather than boot-time configuration, despite the convenience they add
to most of us who understand the basics of how to use them.
