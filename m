From: geoff@infradead.org (Geoff Levand)
Date: Tue, 08 Jul 2014 16:33:04 -0700
Subject: [RFC PATCH 2/3] arm64: add C struct definition for Image header
In-Reply-To: <CAKv+Gu8Qa86N7OSWXTp7XjJvPVa6_rKE_mnMBLJKWjoaabeH+A@mail.gmail.com>
References: <1404823803-7317-1-git-send-email-ard.biesheuvel@linaro.org>
 <1404823803-7317-2-git-send-email-ard.biesheuvel@linaro.org>
 <1404848794.26155.31.camel@smoke>
 <CAKv+Gu8Qa86N7OSWXTp7XjJvPVa6_rKE_mnMBLJKWjoaabeH+A@mail.gmail.com>
Message-ID: <1404862384.26155.49.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 2014-07-08 at 22:59 +0200, Ard Biesheuvel wrote:
> On 8 July 2014 21:46, Geoff Levand <geoff@infradead.org> wrote:
> > On Tue, 2014-07-08 at 14:50 +0200, Ard Biesheuvel wrote:
> >
> > I think the duplication of the structure definition in booting.txt
> > and in image_hdr.h will not be maintained, so I recommend we remove
> > the definition in booting.txt and replace it with something like:
> >
> > -The decompressed kernel image contains a 64-byte header as follows:
> > ...
> > +The decompressed kernel image contains a 64-byte header as described in
> > +arch/arm64/include/asm/image_hdr.h.
> >
> >
> 
> I see what you mean, but I will let the maintainers decide on that one.

Why don't you make a separate patch that does it, then their
decision on that won't effect this patch. 

> >> + *
> >> + * Copyright (C) 2014 Linaro Ltd  <ard.biesheuvel@linaro.org>
> >
> > Are you really a copyright holder of this code?
> >
> 
> I am the author of this file. Will is the author of booting.txt. I am
> not a lawyer so whether that makes Linaro a copyright holder, I am not
> sure ...
> But as I understand it, someone needs to claim copyright in order for
> others to be bound to the license.

Well, authorship and ownership (copyright holder) are different
things.  My guess is that your employment agreement makes everything
you create the property of Linaro, so they are the copyright holder.
You are just an author, so you shouldn't put yourself in the copyright
notice.  Probably just add another line like:

+ Author: <ard.biesheuvel@linaro.org>

> >> +#define IMAGE_HDR_SIZE               64
> >
> > I can't see any use for this IMAGE_HDR_SIZE.  We have the
> > structure def, so use sizeof.
> >
> 
> I am using it in the BUILD_BUG_ON() below. Do you think that is overkill?

Yes.  Even if someone changed something to make the size incorrect,
what really matters is the offset of things.

> > Please add a comment here to document this structure and the
> > members, not in the structure itself.  Something like:
> >
> > +/**
> > + * struct arm64_image_header - arm64 kernel image header.
> > + *
> > + * @code0: ...
> >
> 
> Is this coding style documented somewhere? Documentation/CodingStyle
> does not seem to cover it ...

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/kernel-doc-nano-HOWTO.txt


> >> +     return hdr->magic == cpu_to_le32(0x644d5241);
> >> +}
> 
> Perhaps I should use a define here ...

Or a constant, which would have a type.  Something like this?

+static const uint32_t magic_le = 0x644d5241U;

-Geoff
