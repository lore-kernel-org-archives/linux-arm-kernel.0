From: wcohen@redhat.com (William Cohen)
Date: Mon, 6 Jul 2015 10:42:03 -0400
Subject: [PATCH 1/2] arm64: Blacklist non-kprobe-able symbols
In-Reply-To: <559A688D.1040501@hitachi.com>
References: <cover.1436158027.git.panand@redhat.com>
 <9994841a0b0a8194a6dcc1b6af148ba358488c62.1436158027.git.panand@redhat.com>
 <20150706090323.GB30342@arm.com> <559A688D.1040501@hitachi.com>
Message-ID: <559A93BB.7090007@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2015 07:37 AM, Masami Hiramatsu wrote:
> On 2015/07/06 18:03, Will Deacon wrote:
>> On Mon, Jul 06, 2015 at 06:03:21AM +0100, Pratyush Anand wrote:
>>> Add all function symbols which are called from do_debug_exception under
>>> NOKPROBE_SYMBOL, as they can not kprobed.
>>
>> It's a shame this has to be so manual, but I suppose it's done on a
>> best-effort basis to catch broken probe placement.
> 
> Ah, yes. You can use kprobe-tracer in ftrace by feeding all symbols to
> them and enabling it (and pray).

Yes, this approach isn't guaranteed to find problem functions.  There could be problems hidden on conditional paths that are rarely called.  This was observed with the aarch64 kretprobe trampoline handler.  Most times it wouldn't call kfree and everything would run fine.  However, sometimes the kfree which was instrumented for a systemtap test would get called from inside the trampoline handler and trigger a recursive exception.  This is why aarch64 tramopline was rewritten avoid using kprobe.

Is there some tool that can generate a static call graph of the kernel?  Maybe use the output of that to get more complete list of which functions should be off limits for kprobes.  One complication is that some tools might not analyze functions written in assembly and miss some possible function calls.

-Will Cohen
   
> 
> 
>> If we miss a function and somebody probes it, do we just get stuck in a
>> recursive exception, or could we print something suggesting that a symbol
>> be annotated as NOKPROBE?
> 
> For some cases we can detect recursion, but usually, it may reset
> itself or infinite recursion loop before detecting it. :(
> 
> Thank you,
> 
