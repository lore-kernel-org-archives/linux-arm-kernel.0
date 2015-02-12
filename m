From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Thu, 12 Feb 2015 03:58:08 +0100
Subject: [PATCH RFC 0/5] ARM: dts: zynq: pinctrl, LED, USB for Parallella
In-Reply-To: <6aaaf1a93107489da80368cf01e3bcff@BN1BFFO11FD006.protection.gbl>
References: <1423702513-4032-1-git-send-email-afaerber@suse.de>
 <6aaaf1a93107489da80368cf01e3bcff@BN1BFFO11FD006.protection.gbl>
Message-ID: <54DC16C0.3060303@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi S?ren,

Am 12.02.2015 um 02:19 schrieb S?ren Brinkmann:
> I'm just thinking out loud here. I think it's reasonable to have a dts
> for each platform/board. On dtsi files the opinions seem to diverge,
> but as long as it isn't a completely confusing include scheme,
> I'm always for minimizing duplication.
> But what I'm not convinced of is, additional dts files for different
> bitstreams. The amount of variation you can achieve by programming
> different bitstreams is virtually unlimited. Having a dts file for all
> of that upstream doesn't seem that reasonable to me.

Hm, for your Xilinx boards or for the Zed board I would agree. However,
Adapteva specifically offers two alternative bitstreams per board:
https://github.com/parallella/parallella-hw/tree/master/fpga/bitstreams
ftp://ftp.parallella.org/boot/linux/

Don't you think it's reasonable to support those official two, while
letting people who tinker with bitstreams themselves worry about their
own device trees?

Personally I use the HDMI bitstream (despite the ADI AXI HDMI driver
still missing, i.e. headless), so I don't insist on having headless DTs.

>From a distro perspective we'd put just one bitstream (HDMI probably) in
a JeOS image and would set it up to use the matching device tree. On the
other hand, if we were providing both bitstreams and had both dtbs
packaged, then switching would be two file copies or a boot.scr update.
So far the FAT boot partition has kept me from preparing such an image,
don't know how far other distros are here.

I'll leave it to Ola and Andreas O. to comment on how widely the
headless bitstream is used. But as a reminder, it was you S?ren who
discouraged me from adding VDMA etc. to the device tree in case the
bitstream doesn't provide it:
https://patchwork.kernel.org/patch/4620231/
Therefore I've prepared said headless vs. HDMI DT split. ;)

> So, I'd say it needs parallella-{userver, e16, e64} (conceptually, the
> names I don't care). I think it should be possible for all of those to
> inherit from zynq-7000.dtsi or is there a reason to have a parallella
> dtsi?

It would be possible, but it would result in duplication. For the Exynos
Chromebooks we decided that there were not enough common bits, so we
inlined an existing .dtsi and I've been using manual diff -u for
checking which bits people forgot to sync (and I do have a local patch
fixing some things that went out of sync that I need to submit...).

In this case it seems the "same" board with some components left out. We
could duplicate the PHYs for instance (which are physically absent for
the Microserver IIUC), but I'd rather not duplicate all those gory
pinctrl settings.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu,
Graham Norton; HRB 21284 (AG N?rnberg)
