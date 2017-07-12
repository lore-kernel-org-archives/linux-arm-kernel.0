From: james.morse@arm.com (James Morse)
Date: Wed, 12 Jul 2017 18:18:55 +0100
Subject: [PATCH 1/2] arm64: mm: abort uaccess retries upon fatal signal
In-Reply-To: <1499782763-31418-2-git-send-email-mark.rutland@arm.com>
References: <1499782763-31418-1-git-send-email-mark.rutland@arm.com>
 <1499782763-31418-2-git-send-email-mark.rutland@arm.com>
Message-ID: <596659FF.7070605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/07/17 15:19, Mark Rutland wrote:
> When there's a fatal signal pending, arm64's do_page_fault()
> implementation returns 0. The intent is that we'll return to the
> faulting userspace instruction, delivering the signal on the way.
> 
> However, if we take a fatal signal during fixing up a uaccess, this
> results in a return to the faulting kernel instruction, which will be
> instantly retried, resulting in the same fault being taken forever. As
> the task never reaches userspace, the signal is not delivered, and the
> task is left unkillable. While the task is stuck in this state, it can
> inhibit the forward progress of the system.
> 
> To avoid this, we must ensure that when a fatal signal is pending, we
> apply any necessary fixup for a faulting kernel instruction. Thus we
> will return to an error path, and it is up to that code to make forward
> progress towards delivering the fatal signal.

VM_FAULT_RETRY's 'I released your locks' behaviour is pretty nasty, but this
looks right. FWIW:
Reviewed-by: James Morse <james.morse@arm.com>

I also gave this a spin through LTP on Juno, based on v4.12-defconfig:
Tested-by: James Morse <james.morse@arm.com>


Thanks,

James
