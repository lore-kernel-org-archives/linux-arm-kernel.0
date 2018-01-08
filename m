From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Jan 2018 14:45:34 +0000
Subject: [PATCH v2 01/11] arm64: use RET instruction for exiting the
 trampoline
In-Reply-To: <CAKv+Gu_F_hWvF7CghnDCQGCaxeViTZjvT=zqdFdD5rqdORCceQ@mail.gmail.com>
References: <1515157961-20963-1-git-send-email-will.deacon@arm.com>
 <1515157961-20963-2-git-send-email-will.deacon@arm.com>
 <CAKv+Gu-efng1k+QbeKmd2pGz1p4vhoFE4fZ8rZ7bihGvsb-e+w@mail.gmail.com>
 <20180108143345.GH25869@arm.com>
 <CAKv+Gu_F_hWvF7CghnDCQGCaxeViTZjvT=zqdFdD5rqdORCceQ@mail.gmail.com>
Message-ID: <20180108144534.GI25869@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 08, 2018 at 02:38:00PM +0000, Ard Biesheuvel wrote:
> On 8 January 2018 at 14:33, Will Deacon <will.deacon@arm.com> wrote:
> > On Sat, Jan 06, 2018 at 01:13:23PM +0000, Ard Biesheuvel wrote:
> >> On 5 January 2018 at 13:12, Will Deacon <will.deacon@arm.com> wrote:
> >> > Speculation attacks against the entry trampoline can potentially resteer
> >> > the speculative instruction stream through the indirect branch and into
> >> > arbitrary gadgets within the kernel.
> >> >
> >> > This patch defends against these attacks by forcing a misprediction
> >> > through the return stack: a dummy BL instruction loads an entry into
> >> > the stack, so that the predicted program flow of the subsequent RET
> >> > instruction is to a branch-to-self instruction which is finally resolved
> >> > as a branch to the kernel vectors with speculation suppressed.
> >> >
> >>
> >> How safe is it to assume that every microarchitecture will behave as
> >> expected here? Wouldn't it be safer in general not to rely on a memory
> >> load for x30 in the first place? (see below) Or may the speculative
> >> execution still branch anywhere even if the branch target is
> >> guaranteed to be known by that time?
> >
> > The main problem with this approach is that EL0 can read out the text and
> > find the kaslr offset.
> 
> Not really - the CONFIG_RANDOMIZE_BASE path puts the movz/movk
> sequence in the next page, but that does involve an unconditional
> branch.

Ah sorry, I had missed that. The unconditional branch may still be attacked,
however.

> > The memory load is fine, because the data page is
> > unmapped along with the kernel text. I'm not aware of any
> > micro-architectures where this patch doesn't do what we need.
> >
> 
> Well, the memory load is what may incur the delay, creating the window
> for speculative execution of the indirect branch. What I don't have
> enough of a handle on is whether this speculative execution may still
> branch to wherever the branch predictor is pointing even if the
> register containing the branch target is already available.

For the micro-architectures I'm aware of, the return stack predictor will
always safely mispredict the jump into the kernel vectors with this patch
applied.

Will
