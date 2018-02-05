From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 5 Feb 2018 11:13:37 +0000
Subject: [PATCH v1] arm64: setup: Check for overlapping dtb and Image
 load addresses
In-Reply-To: <6fd2b4e9-ff54-61be-4031-facea28ba34e@codeaurora.org>
References: <20180124092345.5072-1-clingutla@codeaurora.org>
 <20180129154812.GA25061@arm.com>
 <6fd2b4e9-ff54-61be-4031-facea28ba34e@codeaurora.org>
Message-ID: <20180205111336.frypjc6ah45jvqci@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 05, 2018 at 01:36:12PM +0530, Chandra Sekhar Lingutla wrote:
> On 1/29/2018 9:18 PM, Will Deacon wrote:
> > On Wed, Jan 24, 2018 at 02:53:45PM +0530, Lingutla Chandrasekhar wrote:
> >> Sometime kernel image and dtb load offsets can overlap due to
> >> dynamically increased Image or dtb size if both load addresses
> >> are near to each other, which leads to bootup failures.
> >>
> >> So validate dtb load address and kernel image, if they overlap
> >> do not proceed to boot.
> >>
> >> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> >> ---
> >>
> >> Changes since v0:
> >> - Print overlap bytes.
> >> - Simplify ovelap checks.
> > This all feels a bit fragile to me, since we're relying on some portion of
> > the Image and .dtb working in order to run this code successfully.  I'd
> > rather not pretend to detect this exact scenario, particularly as I can't
> > see it being useful for anybody other than firmware developers (who are in a
> > better position to check whether or not this is happening).
> 
> Yes, it is useful for boot loaders, adding one more condition to current checks
> for bootloader failures, so that boot loader developers can easily identify the
> real issue(Image size increased dynamically).

It would be better if your bootloader checked the image_size header in
the kernel Image (see Documentation/arm64/booting.txt). Then it can
either bail out, or decide where to place the DTB dynamically.

> > More generally, is there not some .dtb checksum failure that detects
> > corruption there? Perhaps we could do something like that for the Image
> > too?
> 
> In boot loader, first we load Image and then dtb to corresponding DDR offset right,
> so not sure checksum would help here.

If that's the case, it's possible that the DTB gets placed over the code
performing this check in the kernel.

It is not possibleto detect this overlap in the bootloader? Both the
kernel Image and DTB have size fields.

Thanks,
Mark.
