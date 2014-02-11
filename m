From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 11 Feb 2014 15:10:24 +0100
Subject: ohci-/ehci-platform: Change compatible string to ?hci-platform
Message-ID: <1392127826-31290-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Can you please add these 2 patches to usb-next, to unbreak usb on various
ARM platforms?

These 2 patches can either be squashed into the first 2 patches of my previous
set or added as is to preserve history, either way is fine with me.

The 2nd patch also fixes one of the Kconfig issues and I've a better plan
for the 2nd Kconfig issue too, so please consider this a self-nack for my
drivers/usb/host/Kconfig patches.

Here is a copy of the echi-platform commit-msg to explain the rationale of
these changes, as well as how the breakage happened in the first place:

The initial versions of the devicetree enablement patches for ehci-platform
used "ehci-platform" as compatible string. However this was disliked by various
reviewers because the platform bus is a Linux invention and devicetree is
supposed to be OS agnostic. After much discussion I gave up, added a:
"depends on !PPC_OF" to Kconfig to avoid a known conflict with PPC-OF platforms
and went with the generic usb-ehci as requested.

In retro-spect I should have stuck to my guns, because the dts files for many
existing boards already claim to be compatible with "usb-ehci", ie they have:

	compatible = "ti,ehci-omap", "usb-ehci";

In theory this should not be a problem since the "ti,ehci-omap" entry takes
presedence, but in practice using a conflicting compatible string is an issue,
because it makes which driver gets used depend on driver registration order.

This patch changes the compatible string claimed by ehci-platform (back) to
"ehci-platform", avoiding the driver registration / module loading ordering
problems, and removes the "depends on !PPC_OF" workaround.

Note that there already is a precedent for using ?hci-platform, in the form
of xhci-platform.c using "xhci-platfrom" as compatible string.

Thanks & Regards,

Hans
