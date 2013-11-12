From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Tue, 12 Nov 2013 16:27:04 +0900
Subject: [PATCH RFC 2/6] arm64: Kprobes with single stepping
 support
In-Reply-To: <CA+b37P08cLAvBYAXSkozLPzrpuXn=N0SUetwL6N8JL+10AtYjQ@mail.gmail.com>
References: <1382008671-4515-1-git-send-email-sandeepa.prabhu@linaro.org>
 <1382008671-4515-3-git-send-email-sandeepa.prabhu@linaro.org>
 <20131108165639.GD15074@mudshark.cambridge.arm.com>
 <527DFC1C.1020107@hitachi.com>
 <CA+b37P3U=cAbUvs=2B9wA4F7S9o49vh7d-KamjPsHcz-b9ZYLA@mail.gmail.com>
 <52808D53.7080904@hitachi.com> <5280B6C8.7050807@hitachi.com>
 <20131111105812.GC28302@mudshark.cambridge.arm.com>
 <528114C4.5000506@hitachi.com>
 <CA+b37P08cLAvBYAXSkozLPzrpuXn=N0SUetwL6N8JL+10AtYjQ@mail.gmail.com>
Message-ID: <5281D848.7000502@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2013/11/12 15:23), Sandeepa Prabhu wrote:
>>>> OK, I've ensured that the hw_breakpoint (from perf) can work
>>>> with kprobes (from ftrace) at the same address on x86.
>>>> So if arm64 already support hw_breakpoint on perf, kprobes should
>>>> work with it.
>>>
>>> Single-stepping on x86 is different to the step behaviour on arm64 afaik. On
>>> ARM, we have to manually remove the breakpoint, perform a single-step, then
>>> add the breakpoint again. If we re-enable debug exceptions in the kprobe
>>> handler, the step will complete early and we'll never step off the
>>> breakpoint.
>>
>> I'm unsure about arm64's debug feature behavior, what does happen when
>> it performs a single-step on sw-breakpoint?
>>
>>> Sandeepa: I think you need to retry Masami's test on the arm64 model, since
>>> I'm fairly sure it won't work as expected without some additional code.
>>
>> OK, anyway, for testing same one, we need to port ftrace first. So the next

Sorry for confusion, s/next/fallback is what I meant. Making a kprobe module
can be done without ftrace port.

>> plan is to make a kprobe module to put a probe (which just printk something)
>> on a specific function (e.g. vfs_symlink), and run perf record with
>> hw-breakpoint as below
>>
>> $ perf record -e "mem:0xXXXXXX:k" ln -s /dev/null /tmp/foo
>>
>> Note that 0xXXXXXX is the address of vfs_symlink.
>>
>> After that, you can see the message in dmesg and also check the perf result
>> with "sudo perf script --dump" (you can find a PERF_RECORD_SAMPLE entry if
>> it works)
> Thanks for steps, ARM64 ftrace patches are under review on arm mailing
> list, I can contact the (linaro) developer implementing ftrace on
> what's supported and then figure-out a way to test this concurrency of
> kprobes breakpoint and hardware breakpoint.

Would you mean this? :)
http://www.spinics.net/lists/arm-kernel/msg278477.html

Wow, it seems that this also has some works around instruction
manipulation (and confusable filenames...)

Thank you,

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt at hitachi.com
