From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 15 Oct 2015 09:22:10 -0700
Subject: [PATCH] mtd: document linux-specific partition parser DT binding
In-Reply-To: <1444915191-28350-1-git-send-email-linus.walleij@linaro.org>
References: <1444915191-28350-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151015162210.GA4545@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ others

Hi Linus,

On Thu, Oct 15, 2015 at 03:19:51PM +0200, Linus Walleij wrote:
> The Linux code in drivers/mtd/maps/physmap_of.c will optionally
> look for this binding for hints on a partition type to look for
> in the MTD. It was added in commit 9d5da3a9b849
> "mtd: extend physmap_of to let the device tree specify the parition probe"
> but no corresponding device tree binding was added. Fix this.
> 
> Cc: devicetree at vger.kernel.org
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Reported-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Are you trying to use this binding, or is this just purely a mechanical
documentation issue? I ask, because it seems that binding never really
got reviewed at all, and others have recently tried to extend support
for it generically [1], but a few objections came up [2][3].

Unfortunately I/we dropped the ball a bit on that thread, but we'd
ideally like to address those concerns in a new binding that is
supported for all MTDs, and deprecate the old one. The new one would
probably not directly use the parser name as used by Linux, but define
some list of compatible strings that fit DT conventions better. Also, I
don't want people including things like "cmdlinepart" in DT, but it
should be available as an override if necessary. IOW, DT shouldn't
supersede the kernel command line.

That's not to say we can't document the old one, but I'm curious if
there are real users. I'd also like to encourage new users to avoid the
old one if we can make that feasible.

> ---
>  Documentation/devicetree/bindings/mtd/mtd-physmap.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> index 4a0a48bf4ecb..0dee084651da 100644
> --- a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> +++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> @@ -26,6 +26,9 @@ file systems on embedded devices.
>   - linux,mtd-name: allow to specify the mtd name for retro capability with
>     physmap-flash drivers as boot loader pass the mtd partition via the old
>     device name physmap-flash.
> + - linux,part-probe: a flash partition type to look for, using the
> +   Linux-internal partition naming scheme, e.g. "afs" for the ARM
> +   Flash footers.

IIUC, this property actually supports a list of parsers, not just a
single partition type.

Also, if we're really going to support this, we should list exactly what
strings we support. And that's one of the problems with the existing
binding; it supports any old string Linux supports, which doesn't match
how we typically want to add bindings (i.e., via proposal + review).

>   - use-advanced-sector-protection: boolean to enable support for the
>     advanced sector protection (Spansion: PPB - Persistent Protection
>     Bits) locking.

Brian

[1] http://lists.infradead.org/pipermail/linux-mtd/2015-May/059226.html
[2] http://lists.infradead.org/pipermail/linux-mtd/2015-May/059276.html
[3] Tail end of Arnd's comments here:
    http://thread.gmane.org/gmane.linux.drivers.devicetree/122479/focus=122788
