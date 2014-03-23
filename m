From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 23 Mar 2014 18:37:44 -0400 (EDT)
Subject: [PATCH 2/2] ARM: mm: keep rodata non-executable
In-Reply-To: <CAGXu5jK_8adL=6DoF9gFBMWxKcxKUHw7238ighE2agFU7cqhWg@mail.gmail.com>
References: <1392339850-18686-1-git-send-email-keescook@chromium.org>
 <1392339850-18686-3-git-send-email-keescook@chromium.org>
 <20140214162257.GB2331@e103592.cambridge.arm.com>
 <CAGXu5jLmYLQpu9CDhoL-2OTdwxqrfVCFbojmpjpcpLqmA=wWYA@mail.gmail.com>
 <20140217123415.GA2182@e103592.cambridge.arm.com>
 <532F2C48.6050509@codeaurora.org>
 <CAGXu5jK_8adL=6DoF9gFBMWxKcxKUHw7238ighE2agFU7cqhWg@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1403231831130.1291@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 23 Mar 2014, Kees Cook wrote:

> On Sun, Mar 23, 2014 at 12:47 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> > On 2/17/2014 4:34 AM, Dave Martin wrote:
> >> On Fri, Feb 14, 2014 at 11:11:07AM -0800, Kees Cook wrote:
> >>> On Fri, Feb 14, 2014 at 8:22 AM, Dave Martin <Dave.Martin@arm.com> wrote:
> >>>> On Thu, Feb 13, 2014 at 05:04:10PM -0800, Kees Cook wrote:
> >>>>> Introduce "CONFIG_DEBUG_RODATA" to mostly match the x86 config, though
> >>>>> the behavior is different: it depends on STRICT_KERNMEM_PERMS, which
> >>>>> sets rodata read-only (but executable), where as this option additionally
> >>>>> splits rodata from the kernel text (resulting in potentially more memory
> >>>>> lost to padding) and sets it non-executable as well. The end result is
> >>>>> that on builds with CONFIG_DEBUG_RODATA=y (like x86) the rodata with be
> >>>>> marked purely read-only.
> >>>>
> >>>> This triggers an Oops in kexec, because we have a block of code in .text
> >>>> which is a template for generating baremetal code to relocate the new
> >>>> kernel, and some literal words are written into it before copying.
> >>>
> >>> You're writing into the text area? I would imagine that
> >>> CONFIG_ARM_KERNMEM_PERMS would break that. However, that's not the
> >>> right place to be building code -- shouldn't the module area be used
> >>> for that?
> >>>
> >>>> Possibly this should be in .rodata, not .text.
> >>>
> >>> Well, rodata should be neither writable nor executable.
> >>
> >> We're not writing into code exactly.
> >>
> >> This code is never executed in-place in vmlinux.  It gets copied, and
> >> only copies are ever executed.
> >>
> >> Some pointers and offsets get poked into the code to configure it.
> >>
> >> I think it would be better simply to put the code in .rodata, and
> >> poke paramaters into the copy, not the original -- but that's a bit
> >> more awkward to code up, since the values can't be poked simply by
> >> writing global variables.
> >>
> >>>
> >>>> There may be a few other instances of this kind of thing.
> >>>
> >>> This config will certainly find them! :) But, that's why it's behind a config.
> >>
> >> I haven't tested exhaustively, but it think this is sufficient for a
> >> Tested-by.  The patch does seem to be doing what it is intended to
> >> do, and doesn't seem to be triggering false positives all over the
> >> place.
> >>
> >>>
> >>>> Are you aware of similar situations on other arches?
> >>>
> >>> I think there were some problems a long time ago on x86 for rodata too.
> >>
> >> It would be good to get this kexec case fixed -- I'll try to hack up
> >> a separate patch.
> >>
> >
> > FWIW, we've hit issues not just with kexec but kprobes as well. The same
> > problems exist with this series:
> 
> For this stage, how about I make this "depends on KEXEC=n &&
> KPROBES=n"? Then as these areas get fixed, we can drop those
> requirements.

Do they really need "fixing"?

The goal here is to increase security by preventing kernel code to be 
modified.  And now it would require hole punching in order to support 
kprobes.

If security is important enough for this option to be attractive to you, 
then wouldn't you want to keep kprobes firmly turned off as well?


Nicolas
