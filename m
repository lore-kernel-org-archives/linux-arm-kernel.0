From: keescook@chromium.org (Kees Cook)
Date: Tue, 1 Apr 2014 15:59:57 -0700
Subject: [PATCH 2/2] ARM: mm: keep rodata non-executable
In-Reply-To: <533B43B2.1020805@codeaurora.org>
References: <1392339850-18686-1-git-send-email-keescook@chromium.org>
 <1392339850-18686-3-git-send-email-keescook@chromium.org>
 <20140214162257.GB2331@e103592.cambridge.arm.com>
 <CAGXu5jLmYLQpu9CDhoL-2OTdwxqrfVCFbojmpjpcpLqmA=wWYA@mail.gmail.com>
 <20140217123415.GA2182@e103592.cambridge.arm.com>
 <532F2C48.6050509@codeaurora.org>
 <CAGXu5jK_8adL=6DoF9gFBMWxKcxKUHw7238ighE2agFU7cqhWg@mail.gmail.com>
 <1395658064.3465.7.camel@linaro1.home>
 <CAGXu5jLEA5u58yNe0k4BobWphAhEiREJ1ped30LVgDRPzOGy7A@mail.gmail.com>
 <533B43B2.1020805@codeaurora.org>
Message-ID: <CAGXu5jLhbUsfnuEULdcyMm_BxrggeMTH5-b6Bdv4eWkGvneWjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 1, 2014 at 3:54 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> On 4/1/2014 3:34 PM, Kees Cook wrote:
>> On Mon, Mar 24, 2014 at 3:47 AM, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
>>> On Sun, 2014-03-23 at 16:21 -0600, Kees Cook wrote:
>>>> For this stage, how about I make this "depends on KEXEC=n &&
>>>> KPROBES=n"?
>>>
>>> There's also ftrace (CONFIG_DYNAMIC_FTRACE I believe) which modifies
>>> kernel code with a call to probe_kernel_write(), which GDB uses as well.
>>>
>>> And grepping for the patch_text() function also shows
>>> __arch_jump_label_transform() modifies kernel code. Not sure how and
>>> when that gets used.
>>
>> Right, so, I'm trying to fix ftrace now, and I've hit a wall. It is as
>> if changes to the kernel text PMD aren't being noticed after the
>> kernel is running. Does anyone know why this might be happening?
>>
>> Code and details here:
>> https://lkml.org/lkml/2014/4/1/674
>>
>> -Kees
>>
>
> We had a flush_tlb_kernel_page after the pmd_flush in our out of tree code
> which makes the text writeable in __patch_text.

I tried flush_tlb_kernel_range(), which I'd expect to do the same
thing. I can try with _page() too.

-Kees

-- 
Kees Cook
Chrome OS Security
