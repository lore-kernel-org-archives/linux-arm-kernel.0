From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Nov 2015 16:23:41 +0000
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <56436420.9090401@iogearbox.net>
References: <20151111004208.GA47378@ast-mbp.thefacebook.com>
 <CABg9mcux0wEC5=nWuR9o8NwUTp73zqZ-N2e67_f7oS_mX1XGdg@mail.gmail.com>
 <4902833.k8y8bz0YLV@wuerfel> <20151111102406.GB9562@arm.com>
 <56431B83.5060500@iogearbox.net> <20151111115851.GE9562@arm.com>
 <564332B0.2090103@iogearbox.net> <20151111123831.GJ9562@arm.com>
 <20151111125807.GP17308@twins.programming.kicks-ass.net>
 <56436420.9090401@iogearbox.net>
Message-ID: <20151111162341.GN9562@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Thanks for investigating this further.

On Wed, Nov 11, 2015 at 04:52:00PM +0100, Daniel Borkmann wrote:
> I played a bit around with eBPF code to assign the __sync_fetch_and_add()
> return value to a var and dump it to trace pipe, or use it as return code.
> llvm compiles it (with the result assignment) and it looks like:
> 
> [...]
> 206: (b7) r3 = 3
> 207: (db) lock *(u64 *)(r0 +0) += r3
> 208: (bf) r1 = r10
> 209: (07) r1 += -16
> 210: (b7) r2 = 10
> 211: (85) call 6 // r3 dumped here
> [...]
> 
> [...]
> 206: (b7) r5 = 3
> 207: (db) lock *(u64 *)(r0 +0) += r5
> 208: (bf) r1 = r10
> 209: (07) r1 += -16
> 210: (b7) r2 = 10
> 211: (b7) r3 = 43
> 212: (b7) r4 = 42
> 213: (85) call 6 // r5 dumped here
> [...]
> 
> [...]
> 11: (b7) r0 = 3
> 12: (db) lock *(u64 *)(r1 +0) += r0
> 13: (95) exit // r0 returned here
> [...]
> 
> What it seems is that we 'get back' the value (== 3 here in r3, r5, r0)
> that we're adding, at least that's what seems to be generated wrt
> register assignments. Hmm, the semantic differences of bpf target
> should be documented somewhere for people writing eBPF programs to
> be aware of.

If we're going to document it, a bug tracker might be a good place to
start. The behaviour, as it stands, is broken wrt the definition of the
__sync primitives. That is, there is no way to build __sync_fetch_and_add
out of BPF_XADD without changing its semantics.

We could fix this by either:

(1) Defining BPF_XADD to match __sync_fetch_and_add (including memory
    barriers).

(2) Introducing some new BPF_ atomics, that map to something like the
    C11 __atomic builtins and deprecating BPF_XADD in favour of these.

(3) Introducing new source-language intrinsics to match what BPF can do
    (unlikely to be popular).

As it stands, I'm not especially keen on adding BPF_XADD to the arm64
JIT backend until we have at least (1) and preferably (2) as well.

Will
