From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 15 Feb 2016 13:42:35 +0100
Subject: [linux-sunxi] (Still) breaking DT compatibility
In-Reply-To: <56C1A590.6030500@arm.com>
References: <1455300000-18723-1-git-send-email-andre.przywara@arm.com>
 <56BE29A1.3060107@redhat.com> <56C1A590.6030500@arm.com>
Message-ID: <56C1C7BB.1040602@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15-02-16 11:16, Andre Przywara wrote:
> On 12/02/16 18:51, Hans de Goede wrote:
>> Hi,
>>
>> So far I've stayed out of this discussion, but now I feel I have to
>> weigh in:
>>
>> There is no need for this series, device-tree compatibility for
>> sunxi devices is a non issue. No devices ship with dtb files as
>> part of the bootloader / firmware (the vendor kernels do not
>> use dtb at all).
>
> I think you are barking in the wrong thread here.
> I deliberately sent some code to bring this discussion back to a more
> technical level.
>
> But anyway...
>
>> So we always are using a dtb from the kernel tree, and both Fedora
>> and Debian (AFAIK), the 2 distros which ship with more or less official
>> sunxi support package things
>
> Actually I am trying to help that it doesn't need to stay this way. I
> don't see a real reason why a distribution should support a particular
> platform, they certainly don't for x86, for instance.
> I think a stable DT would help to overcome this limited support that we
> see here and would allow distributions to not need to care about sunxi
> in particular.

Only if board vendors would start to actually ship things that way.

> There should be one good DT for all kernels - it may be updated
> (especially if new features get supported), but should never break.
> Also please note that the DT is not only for Linux, BSDs for instance
> use it too - for instance FreeBSD on ARM64.
>
>> so that each kernel version uses the dtb
>> files compiled from the dts shipped with that exact kernel version,
>> (through the ftddir directive in extlinux.conf, which is per menu
>> entry / kernel version) even if multiple kernel versions are installed.
>
> That there are technical ways to mitigate the problem doesn't count as
> an excuse to break DT.
>
> To make this clear: The original PLL6 clock _binding_ is actually fine:
> it describes the clock as per the manual with two clock outputs.
> It's just the driver that is ignoring the clock-output-names that causes
> the issue.
> So we can happily keep the binding, fix the driver and re-use that very
> binding for PLL8, as well.
> This fix series here was the easiest approach in terms of changed code.
> I can make some patches that implement the proper solution - if you
> promise to not shoot down 0/x again easily.
>
> I see that good DT bindings are not easy to come up with. Yes, we are
> not perfect and especially for sunxi with it's bad original
> documentation we won't create perfect DTs from the beginning.
> But I think we should at least _try_ to make a DT what's is meant:
> describing the hardware, part of the firmware and OS agnostic - which
> implies compatibility.
>
>> So there is no reason, no reason at all to worry too much about dtb
>> compatibility for sunxi devices.
>
> I think this argument has been discussed quite a bit in the
> other thread.
> What I am really worried about is that this now creeps into the arm64 world.
> Yes, I see your point that it was a no-brainer so far, but that doesn't
> mean that it has to stay this way. For the A64 for instance there are
> more devices with eMMC in the pipe (Remix Mini PC and the Olimex board),
> so we can just put our firmware bits and the boot loader on there and
> distributions don't need to ship those.

Note that putting a proper version of uboot / the bootloader on the device
is somewhat orthogonal to the whole DT compatibility discussion, the only
thing the bootloader has to do with the dtb when using extlinux booting
is that it has coded which specific dtb file to load for the board,
currently it loads the actual dtb from ftddir/<name-coded-in-u-boot>.dtb
where ftddir gets set by the extlinux.conf entry. I realize that this
will not work when trying to boot a new board with a kernel which does
not have a dtb for this board, and in this case having some sort of
fallback ftddir with a dtb would be interesting, and yes this would
require stable bindings.

I'm not arguing that stable bindings may not be useful but currently
no-one is doing the above. So currently there is no reason to worry
too much about stability. If someone had shipped such a board I would
certainly be in favor of this series. But currently the stability
problem is a hypothetical problem and I do not think that carrying
extra code to fix a hypothetical problem is a good idea.

>> As for compatibility with u-boot, u-boot ships with its own embedded
>> dtb copy, which is based on dts files from the kernel (the u-boot copies
>> get synced regularly), and even if this dtb were to somehow be replaced
>> by a new "incompatible" dtb from a newer kernel there would still not
>> be a problem as u-boot does not (currently) use the clk definitions
>> from the dtb. Note I'm the u-boot sunxi custodian and I'm fine with
>> the proposed changes.
>>
>> TL;DR: NACK for this series.
>
> Seriously?

Yes seriously, because you're fixing a hypothetical problem. I'm all
for not randomly breaking devicetree compatibility and so far on
sunxi this has only be done 2 or 3 times over the years, but in the
end it is a balancing act between wishing to keep compatibility and
wishing to keep clean code.

As soon as we actually see boards shipping with dtb-s encoded in their
bootloader, then this balancing act stops and dt compatibility will
become a hard requirement, but IMHO for now sometimes it is better to
break compat when this helps to keep things clean.

> I would prefer if you would save your NACKs for patches that break
> something instead.
>
> If you are concerned that this fix is too involved, that's mostly due to
> the reason that I couldn't revert the original patch easily due to
> conflicts in subsequent patches, so I did a bit more for the rollback.
> The actual core fix is pretty easy.
>
> So I hope we can come to a conclusion about this one before I prepare
> the next set of patches.

I think that the conclusion is that most people are ok with the break,
as is, since it is known to not cause any real world problems.

But in the end this is Maxime's call.

Regards,

Hans

p.s.

I love the work you've been doing on the A64, I've not had a chance
to try it out yet though. Have you made any progress with getting
the mmc slot to work ?  If not maybe I can make some time I've
prior experience in bringing up the mmc slot on other Allwinner SoCs
