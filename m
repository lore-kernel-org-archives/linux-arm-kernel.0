From: oleg@redhat.com (Oleg Nesterov)
Date: Sun, 4 Jan 2015 19:40:12 +0100
Subject: [RFC 8/8] ARM64: Add uprobe support
In-Reply-To: <54A944ED.5010408@redhat.com>
References: <cover.1420038188.git.panand@redhat.com>
 <0694af6935f9c6873ef8d25ad51630a40a74a116.1420038188.git.panand@redhat.com>
 <20150102172333.GA6264@redhat.com> <54A944ED.5010408@redhat.com>
Message-ID: <20150104184012.GA12614@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04, Pratyush Anand wrote:
>
> On Friday 02 January 2015 10:53 PM, Oleg Nesterov wrote:
>> But the main question is: why do we need add/find_ss_context ?? Please
>> explain.
>>
>
> See arch/arm64/kernel/debug-monitors.c: call_step_hook
>
> Unlike breakpoint exception, there is no ESR info check for step
> exception. So, it is the responsibility of step handler
> (uprobe_single_step_handler) to make sure that exception was generated
> for it.

Yes, yes, this is clear. My point was, we can (I think) rely on
uprobe_post_sstep_notifier() which checks ->active_uprobe != NULL.

And I guess you understood what I meant, but since I wasn't clear let
me repeat to ensure we really understand each other.

Can't

	uprobe_single_step_handler(regs, esr)
	{
		if (user_mode(regs) && uprobe_post_sstep_notifier(regs))
			return HANDLED;
		return ERROR;
	}

work without this step_ctx logic?

If everything is correct, the probed task can execute a single (xol) insn
in user-mode before the trap. If ->active_uprobe is set we know that we
expect the ss trap in user-mode, and nothing else except this xol insn can
generate it?

Perhaps arm64 needs additional checks, I dunno... If you think that the
->active_uprobe check is not enough you can probably also verify that
"utask->state = UTASK_SSTEP" and/or "regs->pc - 4 == utask->xol_vaddr",
but so far it seems to me that these additional checks can only make sense
under WARN_ON().

Oleg.
