From: sandeepa.prabhu@linaro.org (Sandeepa Prabhu)
Date: Mon, 11 Nov 2013 11:09:42 +0530
Subject: [PATCH RFC 2/6] arm64: Kprobes with single stepping support
In-Reply-To: <527DFC1C.1020107@hitachi.com>
References: <1382008671-4515-1-git-send-email-sandeepa.prabhu@linaro.org>
 <1382008671-4515-3-git-send-email-sandeepa.prabhu@linaro.org>
 <20131108165639.GD15074@mudshark.cambridge.arm.com>
 <527DFC1C.1020107@hitachi.com>
Message-ID: <CA+b37P3U=cAbUvs=2B9wA4F7S9o49vh7d-KamjPsHcz-b9ZYLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 November 2013 14:40, Masami Hiramatsu
<masami.hiramatsu.pt@hitachi.com> wrote:
> (2013/11/09 1:56), Will Deacon wrote:
>> Hi Sandeepa,
>>
>> On Thu, Oct 17, 2013 at 12:17:47PM +0100, Sandeepa Prabhu wrote:
>>> Add support for basic kernel probes(kprobes), jump probes (jprobes)
>>> for ARM64.
>>
>> I think this series will conflict quite heavily with the jump_label series,
>> since they both introduce some common instruction manipulation code. On the
>> debug side, there will also be conflicts with the kgdb series, so it might
>> make sense for us to merge those two first, then you can rebase on a stable
>> branch from us.
>
> [...]
>
>> In fact, how do you avoid a race with hardware breakpoints? E.g., somebody
>> places a hardware breakpoint on an instruction in the kernel for which
>> kprobes has patched in a brk. We take the hardware breakpoint, disable the
>> breakpoint and set up a single step before returning to the brk. The brk
>> then traps, but we must take care not to disable single-step and/or unmask
>> debug exceptions, because that will cause the hardware breakpoint code to
>> re-arm its breakpoint before we've stepped off the brk instruction.
>
> Hmm, frankly to say, this kind of race issue is not seriously discussed
> on x86 too, since kgdb is still a special tool (not used on the production
> system).
> I think under such situation kgdb operator must have full control of the
> system, and he can (and has to) avoid such kind of race.
Masami,

Hmm I think in same lines, but not sure if we expect kprobes to be
able to work fool-proof along with kgdb or hw breakpoints ?

Thanks,
Sandeepa
>
> Thank you,
>
> --
> Masami HIRAMATSU
> IT Management Research Dept. Linux Technology Center
> Hitachi, Ltd., Yokohama Research Laboratory
> E-mail: masami.hiramatsu.pt at hitachi.com
>
>
