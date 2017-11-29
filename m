From: vinmenon@codeaurora.org (Vinayak Menon)
Date: Wed, 29 Nov 2017 11:35:28 +0530
Subject: [PATCH 1/2] mm: make faultaround produce old ptes
In-Reply-To: <CAADWXX8FmAs1qB9=fsWZjt8xTEnGOAMS=eCHnuDLJrZiX6x=7w@mail.gmail.com>
References: <1511845670-12133-1-git-send-email-vinmenon@codeaurora.org>
 <CAADWXX8FmAs1qB9=fsWZjt8xTEnGOAMS=eCHnuDLJrZiX6x=7w@mail.gmail.com>
Message-ID: <f09cd880-f647-7dc8-2ca9-67dab411c6c3@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2017 1:15 AM, Linus Torvalds wrote:
> On Mon, Nov 27, 2017 at 9:07 PM, Vinayak Menon <vinmenon@codeaurora.org> wrote:
>> Making the faultaround ptes old results in a unixbench regression for some
>> architectures [3][4]. But on some architectures it is not found to cause
>> any regression. So by default produce young ptes and provide an option for
>> architectures to make the ptes old.
> Ugh. This hidden random behavior difference annoys me.
>
> It should also be better documented in the code if we end up doing it.
Okay.
> The reason x86 seems to prefer young pte's is simply that a TLB lookup
> of an old entry basically causes a micro-fault that then sets the
> accessed bit (using a locked cycle) and then a restart.
>
> Those microfaults are not visible to software, but they are pretty
> expensive in hardware, probably because they basically serialize
> execution as if a real page fault had happened.
>
> HOWEVER - and this is the part that annoys me most about the hidden
> behavior - I suspect it ends up being very dependent on
> microarchitectural details in addition to the actual load. So it might
> be more true on some cores than others, and it might be very
> load-dependent. So hiding it as some architectural helper function
> really feels wrong to me. It would likely be better off as a real
> flag, and then maybe we could make the default behavior be set by
> architecture (or even dynamically by the architecture bootup code if
> it turns out to be enough of an issue).
>
> And I'm actually somewhat suspicious of your claim that it's not
> noticeable on arm64. It's entirely possible that the serialization
> cost of the hardware access flag is much lower, but I thought that in
> virtualization you actually end up taking a SW fault, which in turn
> would be much more expensive. In fact, I don't even find that
> "Hardware Accessed" bit in my armv8 docs at all, so I'm guessing it's
> new to 8.1? So this is very much not about architectures at all, but
> about small details in microarchitectural behavior.
The experiments were done on v8.2 hardware with CONFIG_ARM64_HW_AFDBM enabled.
I have tried with CONFIG_ARM64_HW_AFDBM "disabled", and the unixbench score drops down,
probably due to the SW faults.

Thanks,
Vinayak
