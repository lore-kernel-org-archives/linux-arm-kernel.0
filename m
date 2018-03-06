From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 6 Mar 2018 11:58:33 +0000
Subject: [PATCH] arm64: dts: rockchip: Fix rk3399-gru-* s2r (pinctrl hogs,
 wifi reset)
In-Reply-To: <3831527.HjPPvuL6zK@diego>
References: <20180227204711.29357-1-dianders@chromium.org>
 <3831527.HjPPvuL6zK@diego>
Message-ID: <d0aac677-ed2e-c059-0cba-79f88de194b4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On 01/03/18 08:43, Heiko St?bner wrote:
> Am Dienstag, 27. Februar 2018, 21:47:11 CET schrieb Douglas Anderson:
>> Back in the early days when gru devices were still under development
>> we found an issue where the WiFi reset line needed to be configured as
>> early as possible during the boot process to avoid the WiFi module
>> being in a bad state.
>>
>> We found that the way to get the kernel to do this in the earliest
>> possible place was to configure this line in the pinctrl hogs, so
>> that's what we did.  For some history here you can see
>> <http://crosreview.com/368770>.  After the time that change landed in
>> the kernel, we landed a firmware change to configure this line even
>> earlier.  See <http://crosreview.com/399919>.  However, even after the
>> firmware change landed we kept the kernel change to deal with the fact
>> that some people working on devices might take a little while to
>> update their firmware.
>>
>> At this there are definitely zero devices out in the wild that have
>> firmware without the fix in it.  Specifically looking in the firmware
>> branch several critically important fixes for memory stability landed
>> after the patch in coreboot and I know we didn't ship without those.
>> Thus, by now, everyone should have the new firmware and it's safe to
>> not have the kernel set this up in a pinctrl hog.
>>
>> Historically, even though it wasn't needed to have this in a pinctrl
>> hog, we still kept it since it didn't hurt.  Pinctrl would apply the
>> default hog at bootup and then would never touch things again.  That
>> all changed with commit 981ed1bfbc6c ("pinctrl: Really force states
>> during suspend/resume").  After that commit then we'll re-apply the
>> default hog at resume time and that can screw up the reset state of
>> WiFi.  ...and on rk3399 if you touch a device on PCIe in the wrong way
>> then the whole system can go haywire.  That's what was happening.
>> Specifically you'd resume a rk3399-gru-* device and it would mostly
>> resume, then would crash with some crazy weird crash.
>>
>> One could say, perhaps, that the recent pinctrl change was at fault
>> (and should be fixed) since it changed behavior.  ...but that's not
>> really true.  The device tree for rk3399-gru is really to blame.
>> Specifically since the pinctrl is defined in the hog and not in the
>> "wlan-pd-n" node then the actual user of this pin doesn't have a
>> pinctrl entry for it.  That's bad.
>>
>> Let's fix our problems by just moving the control of
>> "wlan_module_reset_l pinctrl" out of the hog and put them in the
>> proper place.
>>
>> NOTE: in theory, I think it should actually be possible to have a pin
>> controlled _both_ by the hog and by an actual device.  Once the device
>> claims the pin I think the hog is supposed to let go.  I'm not 100%
>> sure that this works and in any case this solution would be more
>> complex than is necessary.
>>
>> Reported-by: Marc Zyngier <marc.zyngier@arm.com>
>> Fixes: 48f4d9796d99 ("arm64: dts: rockchip: add Gru/Kevin DTS")
>> Fixes: 981ed1bfbc6c ("pinctrl: Really force states during suspend/resume")
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> 
> applied as fix for 4.16 with the 2 Tested-tags
Sorry to rain on everyone's parade, but further testing shows that this
patch may not be enough to restore a reliable s2r. My initial testing
did show that we were resuming without the VOP errors, but there seem to
be further issues (I'm loosing the keyboard and the trackpad after
resume on Kevin).

Applying my initial hack makes it work again. I suspect that there are
more hog pins that need tweaking, but I'm a bit out of my depth here.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
