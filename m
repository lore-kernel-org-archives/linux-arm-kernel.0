From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Jun 2011 09:15:41 +0100
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20110612081541.GA10283@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2011 at 02:06:37AM -0400, Nicolas Pitre wrote:
> This is a resend of those patches with fixups after the latest changes
> in mainline.
> 
> [PATCH 1/3] ARM: zImage: ensure it is always a multiple of 64 bits in size
> This one is new and trivial.
> 
> [PATCH 2/3] ARM: zImage: Allow the appending of a device tree binary
> Mostly John Bonesio's version with some adjustments and cleanups.
> 
> [PATCH 3/3] ARM: zImage: make sure appended DTB doesn't get overwritten by kernel .bss
> New, simpler alternative to Tony Lindgren's version.

One thing which has been bugging me for some time is that the DT stuff
completely overrides the ATAGs.  This is wrong with solutions like this.

We have a set of perfectly good boot loaders which provide correct
information to the kernel via ATAGs.  If we start moving everything
over to DT, then we run into a problem because the ATAGs are ignored -
stuff such as the RAM size and command line passed from the boot loader
will be entirely ignored, instead these having to be encoded into the
kernel at build time.

This is clearly not the right thing to be doing, and this will _prevent_
certain platforms being converted over (I'm going to refuse to convert
the ones which I have an interest in with this restriction in place.)

This restriction needs to be fixed without forcing people to rewrite
their boot loaders.
