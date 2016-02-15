From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 15 Feb 2016 16:52:38 +0100
Subject: [linux-sunxi] Allwinner A64 MMC support
In-Reply-To: <56C1D9C0.6020601@arm.com>
References: <1455300000-18723-1-git-send-email-andre.przywara@arm.com>
 <56BE29A1.3060107@redhat.com> <56C1A590.6030500@arm.com>
 <56C1C7BB.1040602@redhat.com> <56C1D9C0.6020601@arm.com>
Message-ID: <56C1F446.9020801@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15-02-16 14:59, Andre Przywara wrote:
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

Just triggering the automatic calibration sounds good, this likely will
result in better values then the magic values we are currently using for
older SoCs.

As for the meaning of those registers, what we've been doing with the phase
registers so far pretty much boils down to look at what Allwinner BSP kernel
sources do, and then do the same in u-boot / the mainline driver since
the mmc controller documentation is very limited.

Do you have a git tree with your wip mmc support somewhere ? Then I or
maybe Chen-Yu can take a look when we've time.

Regards,

Hans
