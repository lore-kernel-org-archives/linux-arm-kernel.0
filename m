From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 12 Nov 2013 11:59:35 -0500
Subject: [PATCH RFC 2/6] arm64: Kprobes with single stepping support
In-Reply-To: <CA+b37P1xLYWA-a0PwgxT7S7dNr5TdGFscLYFeQhAQUyO_E=Mzw@mail.gmail.com>
References: <1382008671-4515-1-git-send-email-sandeepa.prabhu@linaro.org>
 <1382008671-4515-3-git-send-email-sandeepa.prabhu@linaro.org>
 <20131108165639.GD15074@mudshark.cambridge.arm.com>
 <527DFC1C.1020107@hitachi.com>
 <CA+b37P3U=cAbUvs=2B9wA4F7S9o49vh7d-KamjPsHcz-b9ZYLA@mail.gmail.com>
 <52808D53.7080904@hitachi.com> <5280B6C8.7050807@hitachi.com>
 <20131111105812.GC28302@mudshark.cambridge.arm.com>
 <528114C4.5000506@hitachi.com>
 <CA+b37P08cLAvBYAXSkozLPzrpuXn=N0SUetwL6N8JL+10AtYjQ@mail.gmail.com>
 <5281D848.7000502@hitachi.com>
 <CA+b37P2EgB0toYwhLny8k-cbrziBVXURST5kHNXcY7AF-CNVLg@mail.gmail.com>
 <52820043.6090107@hitachi.com>
 <CA+b37P1xLYWA-a0PwgxT7S7dNr5TdGFscLYFeQhAQUyO_E=Mzw@mail.gmail.com>
Message-ID: <20131112115935.23d05236@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Nov 2013 16:25:26 +0530
Sandeepa Prabhu <sandeepa.prabhu@linaro.org> wrote:


> >
> > BTW, I'm currently trying a general housecleaning of __kprobes
> > annotations. It may also have impact on your patch.
> > https://lkml.org/lkml/2013/11/8/187
> Hmm, we can help testing your patchset on arm64 platforms. Also have
> many doubts on the changes you are working [blacklisting probes etc]
> 
> Basically I had tried placing kprobe on memcpy() and the model hung
> (insmod never returned back!). Fast-model I have does not have option
> of any debug so no clue what happened!.
> memcpy() is low-level call being used internally within kprobes, so
> probably we cannot handle probe on that routine, but then how to make
> sure all such API are rejected by kprobe sub-system ?

Working on ports of ftrace, I found that many of the functions in lib/
are used by several locations that just can't be traced, due to how
low level they are. I just simply blacklisted the entire lib/
directory (See the top of lib/Makefile)

I wonder if there's an easy way to blacklist entire directories from
being used by kprobes too. Or at least do it by a file per file basis.

-- Steve
