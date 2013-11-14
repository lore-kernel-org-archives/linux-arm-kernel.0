From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 14 Nov 2013 12:00:24 -0700
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
In-Reply-To: <20131114162859.GX10335@titan.lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <52814AFB.3070600@wwwdotorg.org>
 <CAL_Jsq+mAoN2Lbg+uqfLMTZBvgz28E-EioiaU4BUSL_7rS5JjA@mail.gmail.com>
 <528275B7.6050209@wwwdotorg.org>
 <20131112193012.GR10335@titan.lakedaemon.net> <52828C77.20001@wwwdotorg.org>
 <20131114162859.GX10335@titan.lakedaemon.net>
Message-ID: <52851DC8.203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2013 09:28 AM, Jason Cooper wrote:
> On Tue, Nov 12, 2013 at 01:15:51PM -0700, Stephen Warren wrote:
>> On 11/12/2013 12:30 PM, Jason Cooper wrote:
>>> On Tue, Nov 12, 2013 at 11:38:47AM -0700, Stephen Warren wrote:
>>>> On 11/12/2013 08:29 AM, Rob Herring wrote:
>>>>> On Mon, Nov 11, 2013 at 3:24 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>>>> On 11/11/2013 01:29 PM, Jason Cooper wrote:
>>>>>>> Consumers of the Linux kernel's build products are beginning to hardcode
>>>>>>> the filenames of the dtbs generated.  Since the dtb filenames are
>>>>>>> currently the dts filename s/dts/dtb/, this prevents the kernel
>>>>>>> community from renaming dts files as needed.
>>>>>>
>>>>>> My take is that the DTB filenames are part of the ABI, and therefore the
>>>>>> DTS filenames are also part of the ABI. Why would we want to rename them?
>>>>>
>>>>> I agree with the ABI part, but for long term I think compatible
>>>>> strings are a better choice for the ABI than filenames. A link
>>>>> provides for a way to transition.
>>>>
>>>> But this change isn't making the compatible value be the ABI, it's still
>>>> keeping the filename as the ABI, but creating a different way of
>>>> choosing the filename.
>>>
>>> Right, which provides a path towards a slightly more sane ABI.  If we
>>> choose to implement this, or another variant, we get to shape a
>>> migration path towards an ABI we designed.  As opposed to locked in to
>>> one we didn't even see coming.
>>
>> I don't really agree here; I specifically named all the Tegra DTB/.dts
>> files in a sane fashion precisely so that U-Boot could easily determine
>> which one to load. It's hard to see how this wasn't a predictable issue.
> 
> This is the difference between a commercial effort and a hobbyist
> effort.  I think I have a plan for how we can both get what we want.  I
> could change the argument to 'dtc ... -L arch/arm/boot ...'.  Thus:
> 
> $ cd arch/arm/boot
> $ ls -l *.dtb        # minus a few columns
> ...
> globalscale,mirabox.dtb -> dts/armada-370-mirabox.dtb
> ...

I don't think the symlinks should be in arch/arm/boot, since that's not
where the source files are. They should either exist in
arch/arm/boot/dts (since that's the source file location, and that
generally determines the object/binary/output file location in the
kernel build system), or in some user-specified directory, created as a
side-effect of e.g. "make dtbs_install". There have been some small
discussions of a dtb install target before, but I don't remember the
details.

> This way, aftermarket users (debian installers, etc) could go to the
> same place they go for zImages, and find a standard named dtb.  They
> wouldn't need to parse the dtbs, just look at the current compatible
> string for the board they are installing on and find the matching file.
> For commercial efforts, nothing changes, the well-thought out *.dtb
> filenames are still in the same place they always were.  A self-imposed
> vendor ABI, if you will.
> 
> Then, in situations where dts filenames need to change, that can happen
> (typically per vendor) because the ABI, from the kernel maintainers pov,
> is the symlinks in arch/arm/boot/.
> 
> As for the migration, there wouldn't need to be one beyond this first
> step of providing symlinks.  That way, vendor-preferred filenames stay
> as they are.
> 
> Would that work better for you?

I don't think a distro should need to know the DTB filename at all.
Rather, the/a bootloader should know which platform it's running on, and
provide a variable/... to the boot script/... that defines the DTB
filename. That would completely remove all the knowledge of DTB
filenames from distros.

I don't think there's anything stopping you from renaming
dts/armada-370-mirabox.dts to globalscale,mirabox.dts, as a one-time
ABI-breaking event, if you want the compatible value to be the filename
for those DTs. Is there a reason you'd want the .dts and .dtb filenames
to differ? You'd mentioned flexibility in renaming the .dts files, but
why would you need that flexibility?

Perhaps if we had to, we could just rename all .dts to conform to the
new naming rule and then I can deal with the bootloader fallout for Tegra:-(
