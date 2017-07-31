From: james.morse@arm.com (James Morse)
Date: Mon, 31 Jul 2017 18:15:41 +0100
Subject: [PATCH v3 0/5] ARM64: disable irq between breakpoint and step
 exception
In-Reply-To: <cover.1501496603.git.panand@redhat.com>
References: <cover.1501496603.git.panand@redhat.com>
Message-ID: <597F65BD.3070200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 31/07/17 11:40, Pratyush Anand wrote:
> samples/hw_breakpoint/data_breakpoint.c passes with x86_64 but fails with
> ARM64. Even though it has been NAKed previously on upstream [1, 2], I have
> tried to come up with patches which can resolve it for ARM64 as well.
> 
> I noticed that even perf step exception can go into an infinite loop if CPU
> receives an interrupt while executing breakpoint/watchpoint handler. So,
> event though we are not concerned about above test, we will have to find a
> solution for the perf issue.

This caught my eye as I've been reworking the order the DAIF flags get
set/cleared[0].

What causes your infinite loop? Is it single-stepping kernel_exit? If so patch 4
"arm64: entry.S mask all exceptions during kernel_exit" [1] may help.

If its more like "single stepping something we didn't expect" you will get the
same problem if we take an SError. (which with that series is unmasked ~all the
time).
Either way this looks like a new and exciting way of hitting the 'known issue'
described in patch 12 [3].


Would disabling MDSCR_EL1.SS if we took an exception solve your problem?

If so, I think we should add a new flag, 'TIF_KSINGLESTEP', causing us to
save/restore MDSCR_EL1.SS into pt_regs on el1 exceptions. This would let us
single-step without modifying the DAIF flags for the location we are stepping,
and allow taking any kind of exception from that location.

We should disable nested users of single-step, we can do that by testing the
flag, print a warning then pretend we missed the breakpoint. (hence it needs to
be separate from the user single-step flag).


Thanks,

James

[0] https://www.spinics.net/lists/arm-kernel/msg596684.html
[1] https://www.spinics.net/lists/arm-kernel/msg596686.html
[2] https://www.spinics.net/lists/arm-kernel/msg596689.html
