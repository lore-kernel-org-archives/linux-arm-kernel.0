From: david@fromorbit.com (Dave Chinner)
Date: Wed, 19 Oct 2011 15:33:15 +1100
Subject: [PATCH 0/3] ARM 4Kstacks: introduction
In-Reply-To: <4E9E0B71.9020708@am.sony.com>
References: <4E9E0B71.9020708@am.sony.com>
Message-ID: <20111019043315.GE21338@dastard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 04:27:45PM -0700, Tim Bird wrote:
> I'm about to submit a set of patches (really pretty small)
> to add 4K stack support to ARM (defaulted to 'N').
> 
> This has been kicking around in my Sony tree for a few years,
> and it's about time to mainline it.  The first patch is
> the actual 4KSTACKS patch.  See subsequent patches
> for tools to help with stack reduction to avoid the problems
> that apparently led to the removal of this feature on x86.

Not this again. There's a good reason 4k stacks went away: it's
simply not enough space for the deep 60+ function call stacks we see
with even trivial storage stack configurations.

The stack usage on 32 bit ARM and x86 is going to be similar, so
you're going to be fighting a losing battle - there is no stack
space tha tcan be trimmed from most paths. To make matter worse,
there's been stuff done to the storage stack that significantly
increases stack usage since 4k stacks went away (e.g. the on-stack
block plugging changes).

And FWIW, XFS is widely used on ARM based NAS devices, so this isn't
a theoretical problem I'm making up here...

Cheers,

Dave.
-- 
Dave Chinner
david at fromorbit.com
