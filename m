From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Fri, 24 Oct 2014 09:52:11 +0900
Subject: [PATCH v6 0/7] ARM: kprobes: enable OPTPROBES for ARM 32.
In-Reply-To: <1413977525-51480-1-git-send-email-wangnan0@huawei.com>
References: <1413977525-51480-1-git-send-email-wangnan0@huawei.com>
Message-ID: <5449A2BB.1020207@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2014/10/22 20:31), Wang Nan wrote:
> Previous 5 version of ARM OPTPROBES patches are unable to deal with
> stack storing instructions correctly. V5 patches disallow optimizing
> every protential stack store instructions based on pessimistic
> assumption. Which, as Tixy comments, 'excludes the main use of
> kprobes'. (https://lkml.org/lkml/2014/8/29/117 )
> 
> The main obstacle which prevents us from computing stack requirement is
> the missing of per-instruction decoder in probes_decode_insn() and its
> friends. Only part of instructions have their decoders (and not in
> each case).
> 
> In this patch series, I propose 'checker', which allows us define
> functions for each type of instruction, extract more information.  Stack
> consumption computing is an example. Checker can be further employed to
> determine whether one instruction is possible to execute directy in
> optimized kprobe. I'd like to expand current checker framework by
> chaining checkers together. After that, I believe most of ARM
> instructions can be executed directly like x86, kprobe performace can be
> improved.
> 
> The first 3 patches introduces checker. After that, patch 4/7 checks
> stack requirement for probed instructions. Patches 5/7 - 7/7 are similar
> to patch v5, except:
> 
>  1. As Tixy proposed, unoptimized probes are also suffer from stack
>     problem (https://lkml.org/lkml/2014/9/1/548 ). Commit d30a0c8b saves
>     64 bytes for them, but for instruction use register addressing (like
>     'str r0, [sp, r1]'), 64 bytes are unsafe. Patch 5/7 prohibit such
>     probing according to stack information collected by checker.

By the way, this sounds like a bugfix rather than an improvement.
Is it possible to separate 1/7-5/7 as a bugfix series? I think those
should go to 3.18.

Thank you,

-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
