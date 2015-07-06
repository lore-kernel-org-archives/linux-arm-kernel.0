From: masami.hiramatsu.pt@hitachi.com (Masami Hiramatsu)
Date: Mon, 06 Jul 2015 20:56:59 +0900
Subject: [PATCH 1/2] arm64: Blacklist non-kprobe-able symbols
In-Reply-To: <20150706104815.GA17305@dhcppc13.redhat.com>
References: <cover.1436158027.git.panand@redhat.com>
 <9994841a0b0a8194a6dcc1b6af148ba358488c62.1436158027.git.panand@redhat.com>
 <20150706090323.GB30342@arm.com> <20150706104815.GA17305@dhcppc13.redhat.com>
Message-ID: <559A6D0B.9040201@hitachi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/07/06 19:48, Pratyush Anand wrote:
> On 06/07/2015:10:03:24 AM, Will Deacon wrote:
>> On Mon, Jul 06, 2015 at 06:03:21AM +0100, Pratyush Anand wrote:
>>> Add all function symbols which are called from do_debug_exception under
>>> NOKPROBE_SYMBOL, as they can not kprobed.
>>
>> It's a shame this has to be so manual, but I suppose it's done on a
>> best-effort basis to catch broken probe placement.
>>
>> If we miss a function and somebody probes it, do we just get stuck in a
>> recursive exception, or could we print something suggesting that a symbol
>> be annotated as NOKPROBE?
> 
> In some cases we land into a recursive reenter_kprobe:
> 
> echo "p kfree" > /sys/kernel/debug/tracing/kprobe_events
> echo "p single_step_handler" >> /sys/kernel/debug/tracing/kprobe_events
> echo 1 >  /sys/kernel/debug/tracing/events/enable
> 
> [  116.904194] BUG: failure at
> .../arch/arm64/kernel/kprobes.c:288/reenter_kprobe()!
> 
> In some other 
> echo "p kfree" > /sys/kernel/debug/tracing/kprobe_events
> echo "p el0_sync" >> /sys/kernel/debug/tracing/kprobe_events
> echo 1 >  /sys/kernel/debug/tracing/events/enable
> 
> Infinite loop of:
> [  142.731336] Unexpected kernel single-step exception at EL1
> 
> In 1st case currently only address is printed.
> pr_warn("Unrecoverable kprobe detected at %p.\n", p->addr);
> So, while in 1st case we may also print name of symbol, we can not do
> much in second case.

Ah, that's a good point of aarch64 :)

> Now, I am running some test with all the symbols in /proc/kallsyms and
> I noticed that there might be few more symbols which may not allow
> kprobing. So, may be I will resend this series with updates.

Sounds good to me :)

Thank you for testing!

-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt at hitachi.com
