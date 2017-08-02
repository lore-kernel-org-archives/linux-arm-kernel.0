From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 2 Aug 2017 17:39:01 +0100
Subject: [PATCH RFC] arm64: introduce mm_context_t flags
In-Reply-To: <20170731144825.31322-1-ynorov@caviumnetworks.com>
References: <20170731144825.31322-1-ynorov@caviumnetworks.com>
Message-ID: <20170802163900.66gnhogililb3uak@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yury,

On Mon, Jul 31, 2017 at 05:48:25PM +0300, Yury Norov wrote:
> In patch 06beb72fbe23e ("arm64: introduce mm context flag to keep 32 bit task
> information") you introduce the field flags but use it only for a single flag -
> TIF_32BIT. It looks hacky to me for three reasons:
>  - The flag is introduced for the case where it's impossible to get the thread
>    info structure for the thread associated with mm. So thread_info flags (TIF)
>    may also be unavailable at place. This is not the case for the only existing
>    user of if - uprobes, but in general this approach requires to include thread
>    headers in mm code, which may become unwanted dependency.
>  - New flag, if it uses TIF bits, for consistency should for example set/clear
>    TIF_32BIT_AARCH64 for ILP32 tasks. And to be completely consistent, with
>    current approach we'd mirror thread_info flags to mm_context flags. And keep
>    it syncronized.
>  - If we start using TIF flags here, we cannot easily add new mm_context
>    specific bits because they may mess with TIF ones.
> 
> I think that this is not what was intended when you added new field in
> mm_context_t.

TIF_32BIT was handy at the time but it indeed denotes AArch32 user
task. For ILP32 we wouldn't need to set this bit since the instruction
set is A64 and uprobe should support it (though not sure anyone tried).
I noticed in your patch introducing binfmt_ilp32.c that SET_PERSONALITY
actually sets this flag in the mm context.

As with the TIF bits, the PERSONALITY macros become more complicated
with more bits to set/clear. Since we don't have any plans for other mm
context flags (independent of TIF), should we simply rename it to
thread_flags and just copy the thread_info flags:

	current->mm->context.thread_flags = current_thread_info()->flags;

-- 
Catalin
