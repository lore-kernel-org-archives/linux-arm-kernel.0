From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Nov 2018 20:01:39 +0000
Subject: [PATCH 2/2] arm64: defconfig: enable BPF related configs
In-Reply-To: <20181127231839.GF30658@n2100.armlinux.org.uk>
References: <20181111181048.10933-1-pbrobinson@gmail.com>
 <20181111181048.10933-2-pbrobinson@gmail.com>
 <20181112183623.GA2265@brain-police>
 <CAKv+Gu9EE_bWcoxEFr4pi41pfAQsDAywKR+gSueA9vE_Z4Np+g@mail.gmail.com>
 <20181126153820.GA28400@arm.com>
 <20181126155247.GY30658@n2100.armlinux.org.uk>
 <20181127193118.GG5641@arm.com>
 <20181127231839.GF30658@n2100.armlinux.org.uk>
Message-ID: <20181128200138.GB32668@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+Daniel and Alexei]

On Tue, Nov 27, 2018 at 11:18:39PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 27, 2018 at 07:31:18PM +0000, Will Deacon wrote:
> > On Mon, Nov 26, 2018 at 03:52:47PM +0000, Russell King - ARM Linux wrote:
> > > Another point to consider is whether the BPF JIT creates code that
> > > is safe from Spectre, or whether it opens up more Spectre issues.
> > > If it isn't, maybe the better option is to disable kernel-side BPF
> > > entirely until it is fixed up.
> > > 
> > > I've raised that point for 32-bit ARM already, and the 32-bit ARM
> > > BPF JIT isn't going to have the Spectre mitigations applied (since
> > > no one appears interested whenever I've raised it.)  So, for 32-bit
> > > ARM, it's better to have kernel-side BPF entirely disabled if you
> > > care about Spectre mitigations.
> > 
> > I thought that the Spectre mitigations (at least for variant 1) were handled
> > by the core BPF JIT, as a result of b2157399cc98 ("bpf: prevent out-of-bounds
> > speculation")? I think we rely on randomization to protect against variant 2
> > for JITted code.
> > 
> > Did I miss something here?
> 
> It depends - there's at least one case in eBPF that requires the JIT to
> be mitigated, and that's the tail-call stuff.  That's prime Spectre
> exploitation territory, because the pseudocode for that eBPF instruction
> is:
> 
> 	if (index >= array->map.max_entries)
> 		goto out;
> 	if (tail_call_cnt > MAX_TAIL_CALL_CNT)
> 		goto out;
> 	tail_call_cnt++;
> 	prog = array->ptrs[index];
> 	if (prog == NULL)
> 		goto out;
> 	goto *(prog->bpf_func + prologue_size);
> 
> If 'index' is larger than map.max_entries, and we speculate past the
> goto, then out of bounds cache lines in the array->ptrs[] could be
> loaded.

It looks like the verifier rewrites the BPF instructions so that the
index is masked here:


	/* instead of changing every JIT dealing with tail_call
	 * emit two extra insns:
	 * if (index >= max_entries) goto out;
	 * index &= array->index_mask;
	 * to avoid out-of-bounds cpu speculation
	 */
	if (bpf_map_ptr_poisoned(aux)) {
		verbose(env, "tail_call abusing map_ptr\n");
		return -EINVAL;
	}

	map_ptr = BPF_MAP_PTR(aux->map_state);
	insn_buf[0] = BPF_JMP_IMM(BPF_JGE, BPF_REG_3,
			map_ptr->max_entries, 2);
	insn_buf[1] = BPF_ALU32_IMM(BPF_AND, BPF_REG_3,
			container_of(map_ptr,
				struct bpf_array,
				map)->index_mask);
	insn_buf[2] = *insn;
	cnt = 3;
	new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);


so I think that should be ok. In the worst case, we have some redundant
bounds checking of the index in the arch code.

> In cBPF, it seems to me that there is enough support to do something
> like:
> 
> 	if (val > max)		// BPF_JMP | BPF_JGT | BPF_K
> 		jump somewhere;
> 	addr += val;		// BPF_ALU | BPF_ADD | BPF_W
> 	val2 = *addr;		// BPF_LDX | BPF_MEM | BPF_W
> 
> which looks to me like it can fit the Spectre exploitation pattern,
> but is much harder to work around than the eBPF tailcall (we would
> need to detect the BPF instruction sequence.)  I haven't validated
> that such a sequence is actually possible in cBPF, but as cBPF is
> used for packet filtering, and there's a need for it to support
> jumping over the headers which can be variable lengths, then I
> would not be surprised if such BPF sequences were possible.

I was under the impression that the BPF type system didn't allow you to
construct arbitrary addresses like that, but I must defer to the BPF
developers on the details.

Will
