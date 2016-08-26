From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Aug 2016 17:16:27 +0100
Subject: [PATCH v2 9/9] arm64: Work around systems with mismatched cache
 line sizes
In-Reply-To: <f72be21a-fd67-dc30-ca1b-278dd99821a2@arm.com>
References: <1472203398-8751-1-git-send-email-suzuki.poulose@arm.com>
 <1472203398-8751-10-git-send-email-suzuki.poulose@arm.com>
 <CAKv+Gu_AyrQLdjf+1-QuZu3k2goT-_6Dk5mQbvP6XSmu30V4cQ@mail.gmail.com>
 <f2ff63f1-9cc7-6930-60eb-5f1fb8fde2e6@arm.com>
 <f72be21a-fd67-dc30-ca1b-278dd99821a2@arm.com>
Message-ID: <20160826161627.GL30302@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 02:08:01PM +0100, Suzuki K Poulose wrote:
> On 26/08/16 14:04, Suzuki K Poulose wrote:
> >On 26/08/16 12:03, Ard Biesheuvel wrote:
> >>IMO, this is a pattern that we should avoid: you are introducing one
> >>instance now, which will make it hard to say no to the next one in the
> >>future. Isn't there a better way to organize the arm64_ftr_reg array
> >>that allows us to reference entries directly? Ideally, a way that gets
> >>rid of the runtime sorting, since I don't think that is a good
> >>replacement for developer discipline anyway (although I should have
> >>spoken up when that was first introduced) Or am I missing something
> >>here?
> >
> >I had some form of direct access to the feature register in one of
> >the versions [0], but was dropped based on Catalin's suggestion at [1].
> 
> Forgot to add, [0] wouldn't solve this issue cleanly either. It would simply
> speed up the read_system_reg(). So we do need a call to read_system_reg()
> from assembly code, which makes it a little bit tricky.

It might be worth looking to see if we can pass the ctr as an extra
parameter to the assembly routines that need it. Then you can access it
easily from C code, and if you pass it as 0 that could result in the asm
code reading it from the h/w register, removing the need for the _raw
stuff you add.

Of course, it could also be a complete mess fixing up all the callers,
but it's probably worth investigating to see what the trade-off is.

Will
