From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Jan 2018 14:33:45 +0000
Subject: [PATCH v2 01/11] arm64: use RET instruction for exiting the
 trampoline
In-Reply-To: <CAKv+Gu-efng1k+QbeKmd2pGz1p4vhoFE4fZ8rZ7bihGvsb-e+w@mail.gmail.com>
References: <1515157961-20963-1-git-send-email-will.deacon@arm.com>
 <1515157961-20963-2-git-send-email-will.deacon@arm.com>
 <CAKv+Gu-efng1k+QbeKmd2pGz1p4vhoFE4fZ8rZ7bihGvsb-e+w@mail.gmail.com>
Message-ID: <20180108143345.GH25869@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 06, 2018 at 01:13:23PM +0000, Ard Biesheuvel wrote:
> On 5 January 2018 at 13:12, Will Deacon <will.deacon@arm.com> wrote:
> > Speculation attacks against the entry trampoline can potentially resteer
> > the speculative instruction stream through the indirect branch and into
> > arbitrary gadgets within the kernel.
> >
> > This patch defends against these attacks by forcing a misprediction
> > through the return stack: a dummy BL instruction loads an entry into
> > the stack, so that the predicted program flow of the subsequent RET
> > instruction is to a branch-to-self instruction which is finally resolved
> > as a branch to the kernel vectors with speculation suppressed.
> >
> 
> How safe is it to assume that every microarchitecture will behave as
> expected here? Wouldn't it be safer in general not to rely on a memory
> load for x30 in the first place? (see below) Or may the speculative
> execution still branch anywhere even if the branch target is
> guaranteed to be known by that time?

The main problem with this approach is that EL0 can read out the text and
find the kaslr offset. The memory load is fine, because the data page is
unmapped along with the kernel text. I'm not aware of any
micro-architectures where this patch doesn't do what we need.

Will
