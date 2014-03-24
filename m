From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 24 Mar 2014 12:30:08 +0000
Subject: [PATCH 2/2] ARM: mm: keep rodata non-executable
In-Reply-To: <532F2C48.6050509@codeaurora.org>
References: <1392339850-18686-1-git-send-email-keescook@chromium.org>
 <1392339850-18686-3-git-send-email-keescook@chromium.org>
 <20140214162257.GB2331@e103592.cambridge.arm.com>
 <CAGXu5jLmYLQpu9CDhoL-2OTdwxqrfVCFbojmpjpcpLqmA=wWYA@mail.gmail.com>
 <20140217123415.GA2182@e103592.cambridge.arm.com>
 <532F2C48.6050509@codeaurora.org>
Message-ID: <20140324123008.GB3669@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 23, 2014 at 06:47:36PM +0000, Laura Abbott wrote:
> On 2/17/2014 4:34 AM, Dave Martin wrote:
> > On Fri, Feb 14, 2014 at 11:11:07AM -0800, Kees Cook wrote:
> >> On Fri, Feb 14, 2014 at 8:22 AM, Dave Martin <Dave.Martin@arm.com> wrote:
> >>> On Thu, Feb 13, 2014 at 05:04:10PM -0800, Kees Cook wrote:
> >>>> Introduce "CONFIG_DEBUG_RODATA" to mostly match the x86 config, though
> >>>> the behavior is different: it depends on STRICT_KERNMEM_PERMS, which
> >>>> sets rodata read-only (but executable), where as this option additionally
> >>>> splits rodata from the kernel text (resulting in potentially more memory
> >>>> lost to padding) and sets it non-executable as well. The end result is
> >>>> that on builds with CONFIG_DEBUG_RODATA=y (like x86) the rodata with be
> >>>> marked purely read-only.
> >>>
> >>> This triggers an Oops in kexec, because we have a block of code in .text
> >>> which is a template for generating baremetal code to relocate the new
> >>> kernel, and some literal words are written into it before copying.
> >>
> >> You're writing into the text area? I would imagine that
> >> CONFIG_ARM_KERNMEM_PERMS would break that. However, that's not the
> >> right place to be building code -- shouldn't the module area be used
> >> for that?
> >>

[...]
	
> FWIW, we've hit issues not just with kexec but kprobes as well. The same
> problems exist with this series:

[...]

> We had some functions that allowed the text to be temporarily made writable but something
> uniform for kexec would be useful as well (our kexec solution has been 'turn it off')

kexec doesn't rely on poking the kernel text: the fact that it does this
is just a side-effect of the way it is currently implemented.

I would like to fix it -- it's currently on my todo list, but I
consider it non-urgent.  depending on !KEXEC seems reasonable for
now.

People building a hardened system may choose do disable kexec for other
reasons, but that's a separate issue entirely.


kprobes is a different matter: getting it to work with strict permissions
is likely to be complex and costly.  kprobes is already unavoidably
complex and costly, so that is probably better viewed as a kprobes
problem to be solved later, rather than a strict permissions problem.


Cheers
---Dave
