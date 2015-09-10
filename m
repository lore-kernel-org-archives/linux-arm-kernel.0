From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 10 Sep 2015 14:29:38 -0700
Subject: [GIT PULL 9/9] ARM: tegra: Default configuration updates for
 v4.3-rc1
In-Reply-To: <CANMBJr6DSXW-h8P8__LKBu-Xv77T35JwxHWvarvqy1keVrtVQQ@mail.gmail.com>
References: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
 <1439563720-13189-10-git-send-email-thierry.reding@gmail.com>
 <CANMBJr7PKy-eCcB3HiBajpApHS_BYPa7xfKjTqV4o8Z1hwY99A@mail.gmail.com>
 <20150819091358.GA26627@ulmo>
 <1439977724.4135.90.camel@collabora.co.uk>
 <20150819103305.GF26627@ulmo>
 <CANMBJr6DSXW-h8P8__LKBu-Xv77T35JwxHWvarvqy1keVrtVQQ@mail.gmail.com>
Message-ID: <CAMAWPa_rus4z+Sg3Uff7ndqrpB8dF1c1rQBVQ9r7vXh6PFcVkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 3, 2015 at 4:08 PM, Tyler Baker <tyler.baker@linaro.org> wrote:
> Hi Thierry,
>
> On 19 August 2015 at 03:33, Thierry Reding <thierry.reding@gmail.com> wrote:
>> On Wed, Aug 19, 2015 at 11:48:44AM +0200, Sjoerd Simons wrote:
>>> On Wed, 2015-08-19 at 11:14 +0200, Thierry Reding wrote:
>>> > On Tue, Aug 18, 2015 at 03:30:41PM -0700, Tyler Baker wrote:
>>> > > Hi Theirry,
>>> > >
>>> > >
>>> > > This isn't where the story ends unfortunately. The collabora lab
>>> > > also
>>> > > has a jetson-tk1, booted in the same manner, which boots next
>>> > > -20150818
>>> > > fine[4]. The only differences I can spot in the two boot logs is
>>> > > that
>>> > > the collabora board is using an older version of u-boot, where as
>>> > > my
>>> > > board is using a newer version. U-Boot 2015.01-00231-gab77f24-dirty
>>> > > (Good) vs U-Boot 2015.07-00130-gb217c89 (Bad).
>>>
>>> Our 2015.01-00231-gab77f24-dirty is 2015.01-00231-gab77f24 + changes
>>> which got merged as 053b86e6d8e50359412e626c33bae3f7bafd74dd in
>>> upstream u-boot.
>>>
>>> Fwiw:
>>> $ git show 2015.01-00231-gab77f24
>>> commit ab77f24119e80257de4ab017b877f92f96980562
>>> Merge: d928664 fa58b10
>>> Author: Tom Rini <trini@ti.com>
>>> Date:   Thu Jan 15 14:05:31 2015 -0500
>>>
>>>     Merge branch 'master' of git://git.denx.de/u-boot-ti
>>>
>>> Which is definately a commit you should hae in your upstream u-boot
>>> tree.
>>
>> Yeah, I suck. I was running:
>>
>>         $ git show gab77f24
>>
>> I didn't know git could parse the full output from git describe.
>>
>>> > I don't have either of those commits in any of the U-Boot trees I
>>> > have.
>>> > Perhaps whatever tree this comes from has local patches that cause
>>> > the
>>> > breakage? The version that I use a recent upstream U-Boot with some
>>> > local patches, none of which should impact Jetson TK1 in any way.
>>> > Just
>>> > to make sure I tried running latest origin/master, which identifies
>>> > thusly:
>>> >
>>> >     U-Boot 2015.10-rc2-00040-g0f9258228e2b
>>> >
>>> > And that boots next-20150818 fine.
>>>
>>> Probably worth for tyler to test that u-boot commit on his jetson to
>>> see if that solves the issue he's having...
>>
>> I've tried reconstructing the version that Tyler is running by checking
>> out 2015.01-00231-gab77f24 and applying 053b86e6d8e5 ("pci: tegra: Fix
>> port information parsing") on top, but that also leaves me with a
>> bootable system, so no way of reproducing. I agree that upgrading to a
>> more recent U-Boot version sounds like the best way forward because it
>> has already proven to work on at least two setups.
>
> Sorry for the delay. I've upgraded u-boot to U-Boot
> 2015.10-rc2-00439-g03d8714 using the tegra u-boot flashing scripts.
> FWIW, I did have to revert 620776d734e4 ("tftp: adjust settings to be
> suitable for 100Mbit ethernet") to get TFTP working again.
>
> Anyways, it hangs at the exact same spot[1] with the newer version of
> u-boot. If remove the modules from the initrd or just disable
> CONFIG_SND_HDA_TEGRA it boots fine. This weekend I'll try to debug
> this module manually and see if I draw any conclusions.

Since there is no movement on this, and jetson hasn't been boot for
multi_v7_defconfig for a while[1], I think it's time to undo the
option causing this problem[2] so that v4.3 will actually boot on the
jetson.

Unless I hear a good reason otherwise, I'll be posting a patch to
disable the HDA related options in multi_v7_defconfig.

Kevin

[1] http://kernelci.org/boot/tegra124-jetson-tk1/?multi_v7_defconfig
[2]
diff --git a/arch/arm/configs/multi_v7_defconfig
b/arch/arm/configs/multi_v7_defconfig
index b2facab..a285afe 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -468,7 +468,6 @@ CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 CONFIG_SOUND=m
 CONFIG_SND=m
 CONFIG_SND_DYNAMIC_MINORS=y
-CONFIG_SND_HDA_TEGRA=m
 CONFIG_SND_HDA_INPUT_BEEP=y
 CONFIG_SND_HDA_PATCH_LOADER=y
 CONFIG_SND_HDA_CODEC_REALTEK=m
