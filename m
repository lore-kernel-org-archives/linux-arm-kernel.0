From: rabin@rab.in (Rabin Vincent)
Date: Tue, 25 Mar 2014 23:11:19 +0100
Subject: [PATCH 2/2] ARM: mm: keep rodata non-executable
In-Reply-To: <1395658064.3465.7.camel@linaro1.home>
References: <1392339850-18686-1-git-send-email-keescook@chromium.org>
 <1392339850-18686-3-git-send-email-keescook@chromium.org>
 <20140214162257.GB2331@e103592.cambridge.arm.com>
 <CAGXu5jLmYLQpu9CDhoL-2OTdwxqrfVCFbojmpjpcpLqmA=wWYA@mail.gmail.com>
 <20140217123415.GA2182@e103592.cambridge.arm.com>
 <532F2C48.6050509@codeaurora.org>
 <CAGXu5jK_8adL=6DoF9gFBMWxKcxKUHw7238ighE2agFU7cqhWg@mail.gmail.com>
 <1395658064.3465.7.camel@linaro1.home>
Message-ID: <CAH+eYFBB2vRnpnDXna0ZAoxVF8ViQauEUT90rWwirWHNW0W63Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-03-24 11:47 GMT+01:00 Jon Medhurst (Tixy) <tixy@linaro.org>:
> On Sun, 2014-03-23 at 16:21 -0600, Kees Cook wrote:
>> For this stage, how about I make this "depends on KEXEC=n &&
>> KPROBES=n"?
>
> There's also ftrace (CONFIG_DYNAMIC_FTRACE I believe) which modifies
> kernel code with a call to probe_kernel_write(), which GDB uses as well.

x86 handles this by making all kernel text R/W around the place where
ftrace does the modifications.  This is called under stop_machine().
See 16239630974516a887 ("ftrace, x86: make kernel text writable only
for conversions").

> And grepping for the patch_text() function also shows
> __arch_jump_label_transform() modifies kernel code. Not sure how and
> when that gets used.

It gets used when "Optimize very unlikely/likely branches"
(CONFIG_JUMP_LABEL) is enabled.  These "very unlikely/likely branches"
are used, among other things, for controlling tracepoints and some
scheduler/networking features.

x86 handles jump labels (and kprobes) by mapping the page being
modified read-write around the modification.  See text_poke().

See also this ARM patch from Kyle Martin which I don't think has been merged:
http://marc.info/?l=linux-arm-kernel&m=139291862727863&w=2
