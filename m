From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Nov 2013 13:15:51 -0700
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
In-Reply-To: <20131112193012.GR10335@titan.lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <52814AFB.3070600@wwwdotorg.org>
 <CAL_Jsq+mAoN2Lbg+uqfLMTZBvgz28E-EioiaU4BUSL_7rS5JjA@mail.gmail.com>
 <528275B7.6050209@wwwdotorg.org>
 <20131112193012.GR10335@titan.lakedaemon.net>
Message-ID: <52828C77.20001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2013 12:30 PM, Jason Cooper wrote:
> Stephen,
> 
> On Tue, Nov 12, 2013 at 11:38:47AM -0700, Stephen Warren wrote:
>> On 11/12/2013 08:29 AM, Rob Herring wrote:
>>> On Mon, Nov 11, 2013 at 3:24 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>> On 11/11/2013 01:29 PM, Jason Cooper wrote:
>>>>> Consumers of the Linux kernel's build products are beginning to hardcode
>>>>> the filenames of the dtbs generated.  Since the dtb filenames are
>>>>> currently the dts filename s/dts/dtb/, this prevents the kernel
>>>>> community from renaming dts files as needed.
>>>>
>>>> My take is that the DTB filenames are part of the ABI, and therefore the
>>>> DTS filenames are also part of the ABI. Why would we want to rename them?
>>>
>>> I agree with the ABI part, but for long term I think compatible
>>> strings are a better choice for the ABI than filenames. A link
>>> provides for a way to transition.
>>
>> But this change isn't making the compatible value be the ABI, it's still
>> keeping the filename as the ABI, but creating a different way of
>> choosing the filename.
> 
> Right, which provides a path towards a slightly more sane ABI.  If we
> choose to implement this, or another variant, we get to shape a
> migration path towards an ABI we designed.  As opposed to locked in to
> one we didn't even see coming.

I don't really agree here; I specifically named all the Tegra DTB/.dts
files in a sane fashion precisely so that U-Boot could easily determine
which one to load. It's hard to see how this wasn't a predictable issue.

...
>> * Perhaps different bootloaders work different ways. For example, I've
>> set up U-Boot on all Tegra devices so that if U-Boot expands the string
>> "${soc}-${board}.dtb" using its environment, it'll generate the correct
>> DTB filename.
> 
> Why does the bootloader have to choose?  Is this a development scenario or
> a deployed scenario?

I would expect it to work in both scenarios.

Assuming the DTB is in a filesystem rather than in a singleton location
in flash, the DTB must have a filename. It'd be far better to store each
board's DTB as a separate filename, rather than have some process copy
"the" DTB to a singleton filename at install time. Doing so allows the
same filesystem to work on multiple boards unmodified.

As an example, I move my SD card between ~10 different Tegra boards
without touching its content, and U-Boot loads the correct DTB based on
the board it's running on. Pengutronix demo'd a single SD card being
moved between a couple of entirely unrelated boards at ELC-E too.

Given that assumption, the bootloader must somehow determine which
filename to load at boot time, rather than some one-time installation
process doing the picking operation.

...
>> * As such, we're really talking about an indexing process when
>> installing/packaging/searching DTBs. Shouldn't this file renaming happen
>> as part of that process, not the build process?
> 
> I agree, but it's not.  Hence the patch.

Well, you could patch either:-)

...
>> So, bootloaders would have to search for $vendor,$soc-$board-$rev.dtb
>> then fall back to $vendor,$soc-$board.dtb (both those values are in the
>> compatible properties in those DTBs).
> 
> I disagree here.  I don't think this decision/discovery process should
> be done by the bootloader.  It should be done by the distribution
> installer/firmware upgrade utility.  The risk of breaking boot is too
> high.

That means distros have to have board identification logic, and
explicitly have code that selects the correct DT. Thus, distros would
have to be explicitly ported to each board (since IDing the board would
need some kind of board specific logic). Isn't the push towards
single-zImage and DT explicitly so that distros require zero
board-specific knowledge?

BTW, since the outcome of this discussion possibly affects distro
installers and kernel packages, perhaps the discussion should take place
on, or be CC'd to, cross-distro at lists.linaro.org?
