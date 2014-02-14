From: keescook@chromium.org (Kees Cook)
Date: Fri, 14 Feb 2014 11:11:07 -0800
Subject: [PATCH 2/2] ARM: mm: keep rodata non-executable
In-Reply-To: <20140214162257.GB2331@e103592.cambridge.arm.com>
References: <1392339850-18686-1-git-send-email-keescook@chromium.org>
 <1392339850-18686-3-git-send-email-keescook@chromium.org>
 <20140214162257.GB2331@e103592.cambridge.arm.com>
Message-ID: <CAGXu5jLmYLQpu9CDhoL-2OTdwxqrfVCFbojmpjpcpLqmA=wWYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 8:22 AM, Dave Martin <Dave.Martin@arm.com> wrote:
> On Thu, Feb 13, 2014 at 05:04:10PM -0800, Kees Cook wrote:
>> Introduce "CONFIG_DEBUG_RODATA" to mostly match the x86 config, though
>> the behavior is different: it depends on STRICT_KERNMEM_PERMS, which
>> sets rodata read-only (but executable), where as this option additionally
>> splits rodata from the kernel text (resulting in potentially more memory
>> lost to padding) and sets it non-executable as well. The end result is
>> that on builds with CONFIG_DEBUG_RODATA=y (like x86) the rodata with be
>> marked purely read-only.
>
> This triggers an Oops in kexec, because we have a block of code in .text
> which is a template for generating baremetal code to relocate the new
> kernel, and some literal words are written into it before copying.

You're writing into the text area? I would imagine that
CONFIG_ARM_KERNMEM_PERMS would break that. However, that's not the
right place to be building code -- shouldn't the module area be used
for that?

> Possibly this should be in .rodata, not .text.

Well, rodata should be neither writable nor executable.

> There may be a few other instances of this kind of thing.

This config will certainly find them! :) But, that's why it's behind a config.

> Are you aware of similar situations on other arches?

I think there were some problems a long time ago on x86 for rodata too.

-Kees

-- 
Kees Cook
Chrome OS Security
