From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 10 Jun 2015 06:59:12 -0400
Subject: Moan: usage of __iormb() and __iowmb() outside of asm/io.h
In-Reply-To: <20150608184701.GA7557@n2100.arm.linux.org.uk>
References: <20150608184701.GA7557@n2100.arm.linux.org.uk>
Message-ID: <55781880.7040700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2015 02:47 PM, Russell King - ARM Linux wrote:
> Guys,
>
> I notice that we have users of __iormb() and __iowmb() outside of asm/io.h:
>
> drivers/clocksource/timer-keystone.c:   __iowmb();
> drivers/dma/cppi41.c:                   __iormb();
> drivers/dma/cppi41.c:   __iowmb();
> drivers/dma/cppi41.c:           __iowmb();
> drivers/dma/cppi41.c:                   __iormb();
> drivers/soc/ti/knav_qmss_queue.c:       __iowmb();
>
> These are not official kernel barriers - the only reason they exist in
> asm/io.h is purely to provide a barrier implementation _for_ creating
> the accessors _in_ asm/io.h, which are macros, and therefore these
> macros need to stay around for the same scope as those accessors.
>
> As with all details which are an architecture matter, they are subject
> to the whims of the architecture maintainer to provide whatever semantics
> for them that the architecture maintainer deems fit: there is no official
> requirement for anything of that nature to do anything, and no guarantee
> that anything such a detail does today it will do so tomorrow.
>
> This is why only official interfaces should be used, and if they do not
> satisfy the requirements, then new official interfaces need to be
> proposed.  Don't ever poke about with stuff that's an architecture
> implementation detail.
>
> We've been here before with some of the cache flushing code - and people
> have been burnt by it.
>
> I do wish that people would see the difference between stuff which is
> implemented to facilitate the implementation of an architecture detail
> vs something which is provided for everyone's use.
>
> I'm working on a patch which will completely remove these from view.
> I would strongly suggest that these uses are removed from the above
> code as a matter of urgency.
>
> (Thankfully, it looks like it's only TI OMAP related code which has the
> issue right now.)
>

Adding Santosh as well.

-- 
Murali Karicheri
Linux Kernel, Keystone
