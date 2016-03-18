From: james.morse@arm.com (James Morse)
Date: Fri, 18 Mar 2016 14:02:49 +0000
Subject: [PATCH v11 3/9] arm64: add copy_to/from_user to kprobes blacklist
In-Reply-To: <20160318132902.GA29225@dhcppc6.redhat.com>
References: <1457501543-24197-1-git-send-email-dave.long@linaro.org>
 <1457501543-24197-4-git-send-email-dave.long@linaro.org>
 <56E858D8.8030300@arm.com> <20160316054329.GC28915@dhcppc6.redhat.com>
 <56E9350A.7010909@arm.com> <20160317075726.GA16882@dhcppc6.redhat.com>
 <20160318132902.GA29225@dhcppc6.redhat.com>
Message-ID: <56EC0A89.3030606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 18/03/16 13:29, Pratyush Anand wrote:
> Probably, I can see why does not it work. So, when we are single stepping an
> instruction and page fault occurs, we will come to el1_da in entry.S. Here, we
> do enable_dbg. As soon as we will do this, we will start receiving single step
> exception after each instruction (not sure, probably for each alternate
> instruction). Since, there will not be any matching single step handler for
> these instructions, so we will see warning "Unexpected kernel single-step
> exception at EL1". 
> 
> So, I think, we should 
> 
> (1) may be do not enable debug for el1_da, or
> (2) enable_dbg only when single stepping is not enabled, or
> (3) or disable single stepping during el1_da execution.
> 
> (1) will solve the issue for sure, but not sure if it could be the best choice.

A variation on (3):

In kernel/entry.S when entered from EL0 we test for TIF_SINGLESTEP in the
thread_info flags, and use disable_step_tsk/enable_step_tsk to save/restore the
single-step state.

Could we do this regardless of which EL we came from?


Thanks,

James
