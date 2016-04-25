From: Dave.Martin@arm.com (Dave P Martin)
Date: Mon, 25 Apr 2016 11:14:07 +0100
Subject: [PATCH 1/2] ARM: PIE infrastructure
In-Reply-To: <20160422231503.GE17051@piout.net>
References: <1459668234-16033-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1459668234-16033-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20160404100052.GS19428@n2100.arm.linux.org.uk>
 <20160422231503.GE17051@piout.net>
Message-ID: <20160425101406.GR24713@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 23, 2016 at 01:15:03AM +0200, Alexandre Belloni wrote:
> On 04/04/2016 at 11:00:52 +0100, Russell King - ARM Linux wrote :
> > > + /* Copy chunk specific code/data */
> > > + fncpy((char *)chunk->addr, code_start, code_sz);
> >
> > Sorry, NAK.  This abuses fncpy().  There is extensive documentation on
> > the proper use of this in asm/fncpy.h, and anything that does not
> > conform, or which uses memcpy() to copy functions, gets an immediate
> > NAK from me.  fncpy() exists to avoid people doing broken things, and
> > it's written in such a way to help people get it right.
>
> Well, do you want me to iterate and use fncpy on all the functions from
> the generated binary?
>
> I'm not sure this is necessary as the generated binary is self contained
> and doing so will force me to also ensure the offsets are kept the same.
> Doing only one copy is much more convenient. However, I still need to
> ensure the destination address is properly 8-byte aligned and the
> flush_icache_range().
> I understand this is abusing fncpy() but it does want I need (still, I'm
> planning to avoid the BUG() by always passing a properly aligned
> destination address).

fncpy was only intented for a single, self-contained function.  It bakes
in assumptions that are not going to apply to PIEs in general.

The main purpose of this was to avoid (possibly buggy) reinvention of
this bit of code in every driver or board file that needed to copy a
function to SRAM.

The PIE mechanism supersedes this approach, in that it should completely
hide the mechanics of copying to SRAM from the users of PIEs -- so its
worth the PIE infrastructure having it's own code to do this.
Since PIEs will have their own requirements that go beyond what fncpy
does, using fncpy to implement the PIE infrastructure is a misfactorage.

In particular, what is the alignment requirement for a PIE?  It can be
anything that ELF allows, not simply "8".

The "thumb bit" is obviously also meaningless for section base
addresses.

Cheers
---Dave
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
