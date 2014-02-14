From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 14 Feb 2014 16:22:57 +0000
Subject: [PATCH 2/2] ARM: mm: keep rodata non-executable
In-Reply-To: <1392339850-18686-3-git-send-email-keescook@chromium.org>
References: <1392339850-18686-1-git-send-email-keescook@chromium.org>
 <1392339850-18686-3-git-send-email-keescook@chromium.org>
Message-ID: <20140214162257.GB2331@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 05:04:10PM -0800, Kees Cook wrote:
> Introduce "CONFIG_DEBUG_RODATA" to mostly match the x86 config, though
> the behavior is different: it depends on STRICT_KERNMEM_PERMS, which
> sets rodata read-only (but executable), where as this option additionally
> splits rodata from the kernel text (resulting in potentially more memory
> lost to padding) and sets it non-executable as well. The end result is
> that on builds with CONFIG_DEBUG_RODATA=y (like x86) the rodata with be
> marked purely read-only.

This triggers an Oops in kexec, because we have a block of code in .text
which is a template for generating baremetal code to relocate the new
kernel, and some literal words are written into it before copying.

Possibly this should be in .rodata, not .text.

There may be a few other instances of this kind of thing.

Are you aware of similar situations on other arches?

Cheers
---Dave
