From: robdclark@gmail.com (Rob Clark)
Date: Wed, 4 Oct 2017 19:49:00 -0400
Subject: [PATCH 2/2] arm64: dts: qcom: Rename SBC to DragonBoard 410c
In-Reply-To: <20171004232125.GC457@codeaurora.org>
References: <20171003091155.7138-1-linus.walleij@linaro.org>
 <20171003091155.7138-2-linus.walleij@linaro.org>
 <b6b065c7-ad6b-d3da-704f-f139f12752d8@linaro.org>
 <CAF6AEGta20EGJOvLcFWVfUa3kpfq+Udyp1QRNzjY8P290A2tVg@mail.gmail.com>
 <CAP71Wjy2gEn=sGz5kN++=TdZ4S1cmE-3fdw-5__tdtR-M9RDGQ@mail.gmail.com>
 <CAF6AEGvRB_SGQ_Xv33FiPZRyp+Wf29aG_Ex6rVk2Czov-Gjj9Q@mail.gmail.com>
 <CAF6AEGvtfAYx5mgg9mMVeXdO5mStD9gJvi5+Pp46jYj-e8WnOQ@mail.gmail.com>
 <20171004220923.GB457@codeaurora.org>
 <CAF6AEGvHfKfuVRVoZvGkKKzLwRLvwJHJqBdbPUtwBY8_rH6V-w@mail.gmail.com>
 <20171004232125.GC457@codeaurora.org>
Message-ID: <CAF6AEGv8B_YhtSY-EFv=MNG82VAyejp2HwXsahdPU7rzE-_+xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 7:21 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 10/04, Rob Clark wrote:
>> On Wed, Oct 4, 2017 at 6:09 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> > On 10/04, Rob Clark wrote:
>> >> If we managed to get this in before the 4.14 LTS I might feel
>> >> differently.  But afterwards, totally not. :-(
>> >>
>> >
>> > How do you install dtbs onto your device? Should be simple enough
>> > to run 'mv' on the new filename to the old one?
>> >
>>
>> it is part of the kernel package
>
> Are you copying the file out of the arch/arm64/boot/dts
> directory? Or you're using dtbs_install rule?

dtbs_install

>> but fixing it in the distro means fixing it in *every* distro..
>
> That assumes every distro has a bootloader that's looking for one
> file name vs. the other. And that the distro hasn't updated the
> bootloader to pick a different name.

well, the distro starts at grub.. u-boot (implementing the uefi
interface, and loading the dtb) is part of the board's "bios".. we
kinda want to avoid having to provide different versions of "bios" for
users to flash depending on kernel version

>>
>> if we are going for a workaround, then it should be the kernel
>> installing a symlink.  Not every distro having to fix things up in the
>> same way for one particular board.
>
> There was a discussion about this years ago when the dtbs_install
> rule was introduced to the kernel makefiles[1]. Maybe the
> sentiment has changed, but it seems that people involved in that
> thread didn't consider the filename an ABI. Also, take a look at
> commit f4d4ffc03efc ("kbuild: dtbs_install: new make target")
> where it says:
>
> "Removed option to call external script. Copying the files should
> be sufficient and a build system can post-process the install
> directory.  Despite the fact an external script is used for
> installing the kernel, I don't think that is a pattern that
> should be encouraged. I would rather see buildroot type tools
> post process the install directory to rename or move dtb files
> after installing to a staging directory."

So there is kernel-install (which regen's initrd and runs
/lib/kernel/install.d/* scripts).. but so far afaik it hasn't had to
do board specific fixups.. and since this is a change there would have
to propagate into every distro, I'd prefer either not needing to do
this in the first place, or doing it in dtbs_install..

Then again, for db410c, since prior to 4.14 we didn't have an iommu
driver (which display and gpu needed to work without hacks, and
therefore less interesting for distro users), if we manage to sneak
this change into 4.14, then I guess we could live with the short term
headache of telling distro users to flash a different "bios" depending
on kernel version.

After that, we *really* don't want the headache of handholding users
thru bios upgrade for 4.14-lts to newer kernel upgrade.

BR,
-R

> which makes it look like the distro installation scripts would
> rename things if desired.
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/210562.html
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
