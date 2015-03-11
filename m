From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Mar 2015 09:50:55 +0000
Subject: [PATCH 2/5] arm64: use fixmap region for permanent FDT mapping
In-Reply-To: <CAKv+Gu8xrb0QqeFCfbqOb2sxFPyT8cVaq_RkhiD5jrr8L0zYzA@mail.gmail.com>
References: <1425380630-3684-1-git-send-email-ard.biesheuvel@linaro.org>
 <1425380630-3684-3-git-send-email-ard.biesheuvel@linaro.org>
 <CAL_JsqLdFS_nGuLTxrEZPCQv8MtW0s5jQ9Od1qj41yoqX40ONQ@mail.gmail.com>
 <CAKv+Gu8xrb0QqeFCfbqOb2sxFPyT8cVaq_RkhiD5jrr8L0zYzA@mail.gmail.com>
Message-ID: <20150311095055.GB21430@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +       /*
> >> +        * Reserve 2 MB of virtual space for the FDT at the top of the fixmap
> >> +        * region. Keep this at the top so it remains 2 MB aligned.
> >> +        */
> >
> > We should not fix a location restriction by creating a size
> > restriction. You could embed firmware images within a DTB (which I
> > think PPC does).
> >
> 
> The size restriction existed on arm64 before this patch, so I didn't
> think twice about it.
> So what would be a reasonable upper bound? We could go up to ~256 MB
> without much trouble, but I guess that's a bit excessive, no?

Given the existing code had the same 2MB restriction (documented in
booting.txt), I think retaining that limitation for now is fine unless
we have some reasonable example of a DTB approaching or exceeding 2MB.

As far as I am aware, on arm64 we're not currently embeddeding FW images
in the DTB passed to the kernel, and I'm not sure why we would.
Anything that's critical to the system and requires FW should be
initialised prior to the kernel, and if we need FW to drive a particular
device I'd expect we'd store that in the filesystem (or perhaps
initrd/initramfs).

Mark.
