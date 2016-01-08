From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Fri, 8 Jan 2016 11:18:25 -0800
Subject: [PATCH] arm64: net: bpf: don't BUG() on large shifts
In-Reply-To: <568FE77A.3090107@iogearbox.net>
References: <1452015543-6790-1-git-send-email-rabin@rab.in>
 <20160105175557.GC83548@ast-mbp.thefacebook.com>
 <20160106203127.GA16059@debian>
 <20160106221247.GA95332@ast-mbp.thefacebook.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CCBF08E@AcuExch.aculab.com>
 <568E5EB0.8020102@iogearbox.net> <20160108155837.GA28291@debian>
 <568FE77A.3090107@iogearbox.net>
Message-ID: <20160108191824.GB11561@ast-mbp.thefacebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 05:44:42PM +0100, Daniel Borkmann wrote:
> On 01/08/2016 04:58 PM, Rabin Vincent wrote:
> >On Thu, Jan 07, 2016 at 01:48:48PM +0100, Daniel Borkmann wrote:
> >>The question is what is less risky in terms of uabi. To reject such
> >>filters with such K shift vals upfront in verifier, or to just allow
> >>[0, reg_size - 1] values and handle outliers silently. I think both
> >>might be possible, the latter just needs to be clearly specified in
> >>the documentation somewhere. If we go for the latter, then probably
> >>just rewriting that K value as masked one might seem better. Broken
> >>programs might then still be loadable (and still be broken) ... afaik
> >>in case of register (case of shifts with X) with large shift vals
> >>ARM64 is doing 'modulo reg_size' implicitly.
> >
> >The case of what happens with such shifts with X is also already
> >architecture-specific, even when using the interpreters.  For example, the
> >following program returns 1 on ARM64 but 0 on ARM.
> >
> >	BPF_STMT(BPF_LD | BPF_IMM, 1),
> >	BPF_STMT(BPF_LDX | BPF_IMM, 32),
> >	BPF_STMT(BPF_ALU | BPF_LSH | BPF_X, 0),
> >	BPF_STMT(BPF_RET | BPF_A, 0)
> >
> >To start rejecting large K shifts in the verifier because they are
> >architecture-specific while continuing to allow the equally
> >architecture-specific large X shifts (because we can't verify them
> >statically) would be rather inconsistent.
> 
> Hmm, yeah, agree with you that this would be inconsistent. Last time we
> actually had this topic [1], I believe the consensus was that such BPF
> programs are to be considered "undefined".
> 
> In that case, I think just masking the K value silently into its allowed
> range for classic and eBPF might be better. It would eventually not be
> uniform with regards to shifts where X is involved, but if we consider
> it "undefined" behaviour, such uniformity is probably not needed.

I don't think masking the K makes it any more 'consistent'.
As was shown arm and arm64 cpus are inconsistent between themselves
and it's not a job of sw to cover up such things.
imo rejecting broken programs at the load time for both cBPF and eBPF
is better for users, program authors and compiler writers in
the first place. If llvm (due to a bug) generates a shift with constant>32,
I'd prefer verifier to tell me about it instead of silently doing the mask
which likely will be much harder to discover and program going to stay
broken anyway.
