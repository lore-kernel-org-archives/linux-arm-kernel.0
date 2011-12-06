From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 06 Dec 2011 16:23:27 +0000
Subject: [RFC PATCH] ARM: Add generic instruction opcode manipulation
 helpers
In-Reply-To: <20111206150855.GA5385@mudshark.cambridge.arm.com>
References: <1322220493-3251-1-git-send-email-dave.martin@linaro.org>
 <20111206150855.GA5385@mudshark.cambridge.arm.com>
Message-ID: <1323188607.3427.60.camel@linaro1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've cut down the cc list...

On Tue, 2011-12-06 at 15:08 +0000, Will Deacon wrote:
[...]
> Tixy - how much work do you reckon it would be to rework your kprobes
> decoding code into a generic `here are my callbacks, please decode this
> instruction stream for me' type thing?
>
> All I want for hw_breakpoint is to know whether an instruction is a load or
> a store, but even for that it looks like I'll need to duplicate a lot of
> stuff.

The kprobes instruction decoding is pretty specialised if you look at
it. Most of the complexity is in the data tables, (grep for "const union
decode_item") which are processed by kprobe_decode_insn(). For
documentation look for comments before "enum decode_type" and
kprobe_decode_insn(). I suspect that to try and create something generic
out of these would be major work.

An alternative would be to bend the data tables to your purpose by
squeezing in and 'instruction type' parameter into the table (ldr, str,
other) and then parsing the tables with a different function to get the
instruction type. You may find though that there are some classes of
instruction that the existing tables don't decode fully, because kprobes
isn't interested in distinguishing between them.

-- 
Tixy
