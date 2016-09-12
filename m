From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Tue, 13 Sep 2016 01:29:36 +0900
Subject: [PATCH v3] arm64: Improve kprobes test for atomic sequence
In-Reply-To: <57D60AA7.6010304@linaro.org>
References: <1473449169-16032-1-git-send-email-dave.long@linaro.org>
 <20160910144841.1bbbffd8548128146df11a41@kernel.org>
 <57D60AA7.6010304@linaro.org>
Message-ID: <20160913012936.489d3dc7a0b5a9e0f0670745@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 11 Sep 2016 21:53:43 -0400
David Long <dave.long@linaro.org> wrote:

> On 09/10/2016 01:48 AM, Masami Hiramatsu wrote:
> > On Fri,  9 Sep 2016 15:26:09 -0400
> > David Long <dave.long@linaro.org> wrote:
> >
> >> From: "David A. Long" <dave.long@linaro.org>
> >>
> >> Kprobes searches backwards a finite number of instructions to determine if
> >> there is an attempt to probe a load/store exclusive sequence. It stops when
> >> it hits the maximum number of instructions or a load or store exclusive.
> >> However this means it can run up past the beginning of the function and
> >> start looking at literal constants. This has been shown to cause a false
> >> positive and blocks insertion of the probe. To fix this, further limit the
> >> backwards search to stop if it hits a symbol address from kallsyms. The
> >> presumption is that this is the entry point to this code (particularly for
> >> the common case of placing probes at the beginning of functions).
> >>
> >> This also improves efficiency by not searching code that is not part of the
> >> function. There may be some possibility that the label might not denote the
> >> entry path to the probed instruction but the likelihood seems low and this
> >> is just another example of how the kprobes user really needs to be
> >> careful about what they are doing.
> >
> > Of course user should be careful, but also, in such case, kernel can reject
> > to probe it.
> >
> 
> I'm not exactly sure what you mean.  I'm just saying when everything 
> goes right we still cannot promise perfection in detecting a probe 
> within an atomic sequence.  This patch will reject a probe that is after 
> a ldx and has no intervening kallsyms label (and assuming it's within 
> the defined maximum count of subsequent instructions).
> 

Hmm, what I meant was the below code.

> >> +	/*
> >> +	 * If there's a symbol defined in front of and near enough to
> >> +	 * the probe address assume it is the entry point to this
> >> +	 * code and use it to further limit how far back we search
> >> +	 * when determining if we're in an atomic sequence. If we could
> >> +	 * not find any symbol skip the atomic test altogether as we
> >> +	 * could otherwise end up searching irrelevant text/literals.
> >> +	 * KPROBES depends on KALLSYMS so this last case should never
> >> +	 * happen.
> >> +	 */
> >> +	if (kallsyms_lookup_size_offset((unsigned long) addr, &size, &offset)) {
> >> +		if (offset < (MAX_ATOMIC_CONTEXT_SIZE*sizeof(kprobe_opcode_t)))
> >> +			scan_end = addr - (offset / sizeof(kprobe_opcode_t));
> >> +		else
> >> +			scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
> >
> >          } else
> >                 return INSN_REJECTED;
> >
> >    that is what I expected...

As you said above,

> >> +	 * KPROBES depends on KALLSYMS so this last case should never
> >> +	 * happen.

If it should never happen, it also would be better to reject it because
it is unexpected result.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
