From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 17 Apr 2018 18:34:11 +0100
Subject: [RFC PATCH] arm64: fault: Don't leak data in ESR context for user
 fault on kernel VA
In-Reply-To: <20180413142101.GY16308@e103592.cambridge.arm.com>
References: <20180413100204.9674-1-peter.maydell@linaro.org>
 <20180413142101.GY16308@e103592.cambridge.arm.com>
Message-ID: <CAFEAcA_MKzoNV3rAs=wkfxjSXL8twOWcMxcaXct-o=WFmEVMnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 April 2018 at 15:21, Dave Martin <Dave.Martin@arm.com> wrote:
> There are certain fault types that should never be exposed to
> userspace, such as TLB conflict aborts, access flag faults, etc.
> See the changes upstream between v4.16 and torvalds/master (which I had
> temporarily forgotten about...)
>
> Now, __do_user_fault() is called for these cases but the signal has
> already been mapped to SIGKILL by this point via the fault_info[]
> table.  It doesn't matter too much what we do in such cases because
> the user task will be killed on signal delivery and so doesn't get a
> chance to inspect the ESR contents anyway.  It might be worth expanding
> the WARN() to catch mismaintenance of the fault_info[] table -- but that
> may be overkill.  Maybe adding some comments explaining the dependency
> is sufficient.

I had a look at the code in current master, and from my reading
of it it does not call __do_user_fault() for faults like TLB
conflict aborts, etc. Those all have fault_info[] table entries
that specify do_bad() as the function pointer, which just returns 1.
It's only do_page_fault(), do_translation_fault() and do_alignment()
fault that can get into __do_user_fault().

So I don't think there's any change that needs to be made for this
point. Am I misunderstanding what you have in mind? If so it would
probably be simplest if you explained the change you'd like to see.

(The changes in master since v4.16 do require a rebase anyway, mostly
for textual reasons, so I'll base v2 on master unless you have a
different branch you'd rather I based it on.)

I've made the various other changes you suggest.

thanks
-- PMM
