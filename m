From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  4 Jun 2016 20:05:23 +0200
Subject: [PATCH 0/1] ARM: dts: sunxi: Fix simplefb not working in 4.7-rc1
Message-ID: <1465063524-4925-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

While testing 4.7-rc1 / linux-sunxi/sunxi-next on a A10s I noticed that
hdmi out is no longer working (screen goes black when the kernel turns
of unused clocks).

This is caused by the dtsi for sun4i / sun5i / sun7i based boards now
listing pll3, without pll3 being added to the clocks list for the
simplefb nodes.

For sun5i-r8 this does not happen because it lists the de_be and
tcon_ch#_clk in the framebuffer node's clocks which will in turn keep
ppl3 (and pll5) alive.

With this commit:
https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?h=sunxi/for-next&id=eadc0660c2bca3a2a6d2c15fe04bc2aaa2709cef

This is also fixed for A13 based devices, but it still is a problem for
A10s, hence this patch, which sits on top of the commit I just linked too.

Note that we've the same problem in 4.7-rc1 for A10 / A20, this is fixed
by these 2 commits:

https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?id=5a7f2310cc847a73852e70bc720a61ca9bf986a6
https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/commit/?id=c79255ca4d7b67cce4eac4dd532e097ce49f3679

This also means that we must send all 3 linked commits + the patch I'm
sending now to 4.7 as fixes, to avoid regressing in 4.7.

Regards,

Hans
