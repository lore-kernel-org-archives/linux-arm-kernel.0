From: sandeepa.prabhu@linaro.org (Sandeepa Prabhu)
Date: Wed, 13 Nov 2013 21:25:42 +0530
Subject: [PATCH RFC 2/6] arm64: Kprobes with single stepping
 support
In-Reply-To: <20131113143110.GF28881@mudshark.cambridge.arm.com>
References: <20131108165639.GD15074@mudshark.cambridge.arm.com>
 <527DFC1C.1020107@hitachi.com>
 <CA+b37P3U=cAbUvs=2B9wA4F7S9o49vh7d-KamjPsHcz-b9ZYLA@mail.gmail.com>
 <52808D53.7080904@hitachi.com> <5280B6C8.7050807@hitachi.com>
 <20131111105812.GC28302@mudshark.cambridge.arm.com>
 <528114C4.5000506@hitachi.com>
 <CA+b37P08cLAvBYAXSkozLPzrpuXn=N0SUetwL6N8JL+10AtYjQ@mail.gmail.com>
 <5281D848.7000502@hitachi.com>
 <CA+b37P1sNsEXrJFfVL51sZ-SeGNCBiwXnOwCiFY8CBwSXPw+mQ@mail.gmail.com>
 <20131113143110.GF28881@mudshark.cambridge.arm.com>
Message-ID: <CA+b37P1-DPtSu5vB+_4HamUtDNSFn0qNbPWk9A6+vUAp4tu6_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 November 2013 20:01, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Nov 13, 2013 at 06:55:33AM +0000, Sandeepa Prabhu wrote:
>> >>> I'm unsure about arm64's debug feature behavior, what does happen when
>> >>> it performs a single-step on sw-breakpoint?
>> >>>
>> >>>> Sandeepa: I think you need to retry Masami's test on the arm64 model, since
>> >>>> I'm fairly sure it won't work as expected without some additional code.
>> >>>
>> >>> OK, anyway, for testing same one, we need to port ftrace first. So the next
>> >
>> > Sorry for confusion, s/next/fallback is what I meant. Making a kprobe module
>> > can be done without ftrace port.
>> >
>> >>> plan is to make a kprobe module to put a probe (which just printk something)
>> >>> on a specific function (e.g. vfs_symlink), and run perf record with
>> >>> hw-breakpoint as below
>> >>>
>> >>> $ perf record -e "mem:0xXXXXXX:k" ln -s /dev/null /tmp/foo
>> >>>
>> >>> Note that 0xXXXXXX is the address of vfs_symlink.
>> >>>
>> >>> After that, you can see the message in dmesg and also check the perf result
>> >>> with "sudo perf script --dump" (you can find a PERF_RECORD_SAMPLE entry if
>> >>> it works)
>> Hi Will, Masami,
>>
>> I am not sure of 'perf' right now (my minimal rootfs doesn't have) but
>> I tried to test hardware breakpoints using sample modules
>> "samples/hw_breakpoint/" on arm64 upstream branch. This should use
>> same kernel api as perf I believe.
>>
>> 1.  Placing watchpoint ( attr.bp_type = HW_BREAKPOINT_W |
>> HW_BREAKPOINT_R) upon vfs_symlink symbol, but seems watch-point is not
>> triggering at all.
>
> vfs_symlink is a function. Why would you expect to write it?
This is generic test module (samples/hw_breakpoint/data_breakpoint.ko)
which places watchpoint for bothe read/write.
Atleast watchpt should have triggered for Read right? I also tried
with othe functions like do_fork, vfs_read etc but no hit.

>
>> 2.  Placing text breakpoint (modified sample module with attr.bp_type
>> = HW_BREAKPOINT_X) upon vfs_symlink, and run "ln -s /dev/null
>> /tmp/foo".  This time, breakpoint hit but exception is re-cursing
>> infinitely!
>
> The problem here is that we expect the overflow handler to deal with the
> stepping (like GDB does via ptrace). If you don't register a handler, the
> kernel will do the step (like you would get if you used perf stat -e
> mem:0xNNNN:x).
[This test was done on upstream branch, without kprobes patches.]
Hmm, then this is expected with test breakpoint right? is this
handling to be done by perf and ptrace?
I did not see arm64 support in linux/tools/perf/,  there are multiple
patches in mailing list though. Are you aware of any version of perf
that work with arm64?

~Sandeepa
>
> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
