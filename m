From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 15 Feb 2016 22:23:48 +0800
Subject: [linux-sunxi] Allwinner A64 MMC support
In-Reply-To: <56C1D9C0.6020601@arm.com>
References: <1455300000-18723-1-git-send-email-andre.przywara@arm.com>
 <56BE29A1.3060107@redhat.com> <56C1A590.6030500@arm.com>
 <56C1C7BB.1040602@redhat.com> <56C1D9C0.6020601@arm.com>
Message-ID: <CAGb2v65E54mnLEcPzLyycEBSHbvn6tp9JpS+S8gdbDg_e7qFyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 9:59 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> Hi Hans,
>
> ....
>
>>
>> p.s.
>>
>> I love the work you've been doing on the A64, I've not had a chance
>> to try it out yet though. Have you made any progress with getting
>> the mmc slot to work ?  If not maybe I can make some time I've
>> prior experience in bringing up the mmc slot on other Allwinner SoCs
>
> Thanks for that!
>
> So we made some progress on the weekend (with the help of #linux-sunxi):
> 1) The regulator node was stupidly put by me into a separate child node
> without putting address and size cells into. So I just moved it into
> /soc directly now and that seems to fixed the missing regulator.
> 2) The reset node is a allwinner,sun6i-a31-ahb1-reset, which does not
> get registered automatically, but by an explicit call from mach-sunxi/.
> I wonder why we do this (yes, I saw that comment, but still...) and if
> it would work with a normal MODULE_DEVICE_TABLE() declaration.
> There is and will be no equivalent to the mach- directory on arm64.

On sun6i, we supported the high resolution timer, which had a reset control.
Timers (or clocksources) are registered before device model kicks in, so the
reset had to be explicitly registered before the timer, or the system would
hang. I think we phased that out though. Maxime should know.

ChenYu

> 3) As Jens pointed out, the MMC IP block isn't really compatible.
> Changing the clocks is easy (done already), but we need to come up with
> code to cover the new phase setting registers in the A64 MMC register block.
>
> Interestingly somehow hacking this (pretending it is compatible) seems
> to work, though I got reports from people about mysterious kernel
> crashes, so I'm inclined to leave MMC out of the first patch series.
>
> So if you could take a look at the new registers (starting at offset
> 0x140) and work out what we actually need to do here, that would be
> great. I have no real clue about what they actually do and how they
> relate to the current output and sample clock phase.
> To me it looks like we might get away with just triggering the automatic
> calibration and the hardware does the rest for us - keep your fingers
> crossed ;-)
>
> Cheers,
> Andre.
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
