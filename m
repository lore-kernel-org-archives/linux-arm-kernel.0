From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Nov 2013 11:38:47 -0700
Subject: [RFC DTC PATCH] dtc: add symlink (-L) output to dtbs
In-Reply-To: <CAL_Jsq+mAoN2Lbg+uqfLMTZBvgz28E-EioiaU4BUSL_7rS5JjA@mail.gmail.com>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>	<52814AFB.3070600@wwwdotorg.org>
 <CAL_Jsq+mAoN2Lbg+uqfLMTZBvgz28E-EioiaU4BUSL_7rS5JjA@mail.gmail.com>
Message-ID: <528275B7.6050209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2013 08:29 AM, Rob Herring wrote:
> On Mon, Nov 11, 2013 at 3:24 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 11/11/2013 01:29 PM, Jason Cooper wrote:
>>> Consumers of the Linux kernel's build products are beginning to hardcode
>>> the filenames of the dtbs generated.  Since the dtb filenames are
>>> currently the dts filename s/dts/dtb/, this prevents the kernel
>>> community from renaming dts files as needed.
>>
>> My take is that the DTB filenames are part of the ABI, and therefore the
>> DTS filenames are also part of the ABI. Why would we want to rename them?
> 
> I agree with the ABI part, but for long term I think compatible
> strings are a better choice for the ABI than filenames. A link
> provides for a way to transition.

But this change isn't making the compatible value be the ABI, it's still
keeping the filename as the ABI, but creating a different way of
choosing the filename.

In other words, if the compatible value is the ABI, then the algorithm is:

* Search for all available DTBs
* Parse each DTB to find one with a matching compatible value

Whereas if the filename is the ABI, the algorithm is:

* Calculate the filename
* Load that one specific file, without looking at its content

Some additional thoughts:

* The filename is only relevant to the bootloader (or whatever
locates/selects a DTB). The kernel/OS just gets a single DTB passed to
it and uses it, without any naming metadata[1].

* Perhaps different bootloaders work different ways. For example, I've
set up U-Boot on all Tegra devices so that if U-Boot expands the string
"${soc}-${board}.dtb" using its environment, it'll generate the correct
DTB filename.

* Other boot-loaders might like "${compatible_parsed_from_the_dtb}" to
be the filename; that's Jason's proposal.

* Other SW (which I mention in [1]) might want to locate DTBs based on
ARM machine ID rather than compatible value.

* As such, we're really talking about an indexing process when
installing/packaging/searching DTBs. Shouldn't this file renaming happen
as part of that process, not the build process?

* When we create symlinks or any kind of index, I think we want to
create links for all entries in the compatible property (or other index
source). Consider if we have two boards:

Cardhu revision A02
Cardhu revision A04

Initially we think they're the same because we didn't read the
schematics well enough, but then later we split them. That means we'll
start out with one file:

nvidia,tegra30-cardhu.dtb

then later have instead:

nvidia,tegra30-cardhu-a02.dtb
nvidia,tegra30-cardhu-a04.dtb

Similarly, perhaps one DTB is (initially thought to be?) suitable for
multiple ARM machine IDs, etc.

So, bootloaders would have to search for $vendor,$soc-$board-$rev.dtb
then fall back to $vendor,$soc-$board.dtb (both those values are in the
compatible properties in those DTBs).

But then "nvidia,tegra30" is in the compatible property for many boards.
I wonder how we resolve that?

[1] I'm ignoring the idea that was proposed of passing n DTBs to the
kernel and having it select one based on machine ID. So by "the kernel"
I mean the code that runs after the DTB is selected.
