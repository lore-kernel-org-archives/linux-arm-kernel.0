From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 11 Feb 2014 10:27:12 -0500 (EST)
Subject: ohci-/ehci-platform: Change compatible string to ?hci-platform
In-Reply-To: <1392127826-31290-1-git-send-email-hdegoede@redhat.com>
Message-ID: <Pine.LNX.4.44L0.1402111023240.1209-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Feb 2014, Hans de Goede wrote:

> Hi Greg,
> 
> Can you please add these 2 patches to usb-next, to unbreak usb on various
> ARM platforms?
> 
> These 2 patches can either be squashed into the first 2 patches of my previous
> set or added as is to preserve history, either way is fine with me.
> 
> The 2nd patch also fixes one of the Kconfig issues and I've a better plan
> for the 2nd Kconfig issue too, so please consider this a self-nack for my
> drivers/usb/host/Kconfig patches.
> 
> Here is a copy of the echi-platform commit-msg to explain the rationale of
> these changes, as well as how the breakage happened in the first place:
> 
> The initial versions of the devicetree enablement patches for ehci-platform
> used "ehci-platform" as compatible string. However this was disliked by various
> reviewers because the platform bus is a Linux invention and devicetree is
> supposed to be OS agnostic. After much discussion I gave up, added a:
> "depends on !PPC_OF" to Kconfig to avoid a known conflict with PPC-OF platforms
> and went with the generic usb-ehci as requested.
> 
> In retro-spect I should have stuck to my guns, because the dts files for many
> existing boards already claim to be compatible with "usb-ehci", ie they have:
> 
> 	compatible = "ti,ehci-omap", "usb-ehci";
> 
> In theory this should not be a problem since the "ti,ehci-omap" entry takes
> presedence, but in practice using a conflicting compatible string is an issue,
> because it makes which driver gets used depend on driver registration order.
> 
> This patch changes the compatible string claimed by ehci-platform (back) to
> "ehci-platform", avoiding the driver registration / module loading ordering
> problems, and removes the "depends on !PPC_OF" workaround.
> 
> Note that there already is a precedent for using ?hci-platform, in the form
> of xhci-platform.c using "xhci-platfrom" as compatible string.

I still think that "ehci-generic" would be better than "ehci-platform"  
(and the same for ohci).  The reason is that "-platform" is essentially
meaningless, whereas "-generic" strongly suggests that the hardware
matches the specification with no special features or requirements.  
Since the compatibility string -- like everything else in DT -- is
supposed to be a description of the hardware, this seems only logical.

It might even be a good idea to change the "xhci-platform" string to 
match, it that doesn't cause too much trouble.

Alan Stern
