From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 7 Oct 2010 15:39:32 +0900
Subject: [PATCH 00/08] ARM: Dynamic IRQ demux support
In-Reply-To: <AANLkTi=So8SAY+TRRP1xjxzoYGxZjk0PzLHDhR_qKGUc@mail.gmail.com>
References: <20101006071731.28048.89938.sendpatchset@t400s>
	<AANLkTi=So8SAY+TRRP1xjxzoYGxZjk0PzLHDhR_qKGUc@mail.gmail.com>
Message-ID: <AANLkTimAjypE8jTEymyO-0FucXrT8voQ7jVxiZxHF==d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Wed, Oct 6, 2010 at 10:06 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Wed, Oct 6, 2010 at 3:17 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> ARM: Dynamic IRQ demux support

> Just FYI, I had a patch months ago for this:
>
> http://www.spinics.net/linux/lists/arm-kernel/msg92836.html
>
> Do you think that's a simpler way to go?

Thanks for the pointer. I wasn't aware of your patch, but the fact
that both of us came up with similar solutions to the same problem
clearly shows that there is a need for this feature.

Your patch is much less intrusive compared to what i came up with. I
like the simplicity. I guess it is natural that the simplicity comes
with a bit of overhead. I'm thinking of the extra branches and
whatever potential cache misses coming from the code and callback
being located in different cache lines compared to the rest of the
code in __irq_svc and __irq_usr.

My patches keeps the handlers in the same cache lines as before, but
this comes with the cost of more serious rearrangement of the code.
Also, my alignment_trap patch may decrease performance, not sure how
to deal with that in a good way.

I don't mind so much which patch that gets merged, but I'm a little
bit concerned about code duplication. My patch moves macros into a
header file that each demux instance can make use of to minimize the
amount of duplicated code. I'm not sure how you are planning on
implementing each demux instance. If possible I'd like to see the
irq_handler macro in a header file somewhere so we don't have to
duplicate that code.

On top of that I'd also like to break out the GIC demux code and put
it in a central location, but that's a separate issue.

Any thoughts? Shall I try to move the irq_handler macro to some header file?

Thanks,

/ magnus
