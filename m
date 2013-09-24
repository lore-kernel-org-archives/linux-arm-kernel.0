From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Sep 2013 22:48:00 +0100
Subject: new binutils needed for arm in 3.12-rc1
In-Reply-To: <1380057828.1974.73@driftwood>
References: <yw1xpprywhad.fsf@unicorn.mansr.com> <1380057828.1974.73@driftwood>
Message-ID: <20130924214800.GV25647@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 24, 2013 at 04:23:48PM -0500, Rob Landley wrote:
> What value is there in requiring the new toolchain? From what I could  
> see of the commits it was micro-optimizations around memory barriers.
>
> *shrug* I can revert the patch locally, or patch the extra instruction  
> into my toolchain. But I do object to changing the documentation  
> globally for every architecture because one architecture did something  
> they apparently never thought through (or they'd have commented in the  
> commit that it requires a big toolchain version jump; pretty sure they  
> didn't actually notice).

Some of us are notoriously slow at updating our toolchains.  I'm still
using gcc 4.5.4 here, and people regard that as bordering on "too old"
because of the amount of warnings it spits out.  Binutils?  I upgraded
to 2.22 when I needed to fix a problem I was having with the previous
binutils I was using (I think that was 2.18).

I generally don't touch my toolchain unless there's a _reason_ I need
to, and as I've already updated to 2.22, it's a normally a pretty safe
bet that everyone else is already using 2.22 or later.  One reason for
this is that I don't want to be messing around trying to work out
whether a bug I'm seeing is because of a toolchain problem or something
in the kernel.

I realised at the time that I'm going to got shouted at if I accepted
the patches by a minority who wanted to keep their old toolchains, but
I also realise that if I don't accept the patches, I'll get shouted at
by another group.  It's the classic damned if I do and damned if I
don't.  So I've chosen the lesser of the two weavels.

Now, if you feel strongly about this, we _could_ introduce a
CONFIG_OLD_BINUTILS and give everyone their cake - but it will be
fragile.  Not everyone will remember to get that right, because they'll
be using the later binutils.  Also, we already have an excessive number
of potential breakage-inducing options and we certainly don't need
another.

Use IS_ENABLED() I hear you say.  That won't get the one dsb instruction
in some SoC code which was missed which will break the build on older
toolchains.
