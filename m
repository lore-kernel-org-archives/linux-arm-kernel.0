From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jul 2013 16:24:44 +0100
Subject: [Linux-Xtensa] Re: sched_clock always 0 and no process time
 accounting with 3.11-rc1
In-Reply-To: <8572CFB6-0D88-46F4-B055-7834F8B9BDA5@tensilica.com>
References: <CAMo8BfLO31GgMMA_hENr0xm=qaUz3EVLtaQ8hewiQHdbV+s6sA@mail.gmail.com>
 <20130717061925.GC6950@tarshish>
 <8572CFB6-0D88-46F4-B055-7834F8B9BDA5@tensilica.com>
Message-ID: <20130717152443.GO24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 08:15:08AM -0700, Marc Gauthier wrote:
> Hi Baruch,
> 
> On 2013-07-16, at 11:19 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> > -    sched_clock_mask = (1 << bits) - 1;
> > +    sched_clock_mask = (1ULL << bits) - 1;
> 
> Might it be more efficient to use:
> 
>    sched_clock_mask = 0xffffffff >> (32 - bits);
> 
> to avoid using 64 bit ints?
> (assuming bits > 0, didn't check)

bits being 0 would be rather silly (it implies a mask of zero, and therefore
no bits available for the clock.)  We could modify the BUG_ON() above to
make that point, or add it as commentry against the function.

Given that, and that sched_clock_mask is a u32, then I agree with you - the
above would be a better way to do this.  Personally, I'd suggest ~0u rather
than 0xffffffff because its less typing.
