From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 6 Nov 2014 11:52:09 +0000
Subject: [PATCH] arm64: percpu: Implement this_cpu operations
In-Reply-To: <CAKv+Gu-ba8mSgh2qv8+=gb75rb0wOs0S9QRwHAkm8RRbMz9kHQ@mail.gmail.com>
References: <1415272377-5334-1-git-send-email-steve.capper@linaro.org>
 <CAKv+Gu-ba8mSgh2qv8+=gb75rb0wOs0S9QRwHAkm8RRbMz9kHQ@mail.gmail.com>
Message-ID: <20141106115208.GA6258@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 12:26:46PM +0100, Ard Biesheuvel wrote:
> Hi Steve,

Hey Ard,

> 
> On 6 November 2014 12:12, Steve Capper <steve.capper@linaro.org> wrote:
> > The generic this_cpu operations disable interrupts to ensure that the
> > requested operation is protected from pre-emption. For arm64, this is
> > overkill and can hurt throughput and latency.
> >
> > This patch provides arm64 specific implementations for the this_cpu
> > operations. Rather than disable interrupts, we use the exclusive
> > monitor or atomic operations as appropriate.
> >
> > The following operations are implemented: add, add_return, and, or,
> > read, write, xchg. We also wire up a cmpxchg implementation from
> > cmpxchg.h.
> >
> > Testing was performed using the percpu_test module and hackbench on a
> > Juno board running 3.18-rc3.
> >
> 
> Got any numbers?

For `./hackbench 100 process 1000' on a Juno system running all cores I get:

      w/o patch | with patch
 ---------------+------------
 mean     47.05 | 44.93
 stddev    0.38 |  0.68
 ---------------+------------
(times in seconds, rounded to 2d.p., six runs performed)

So a just under 5% speed boost.

[...]

> > diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
> > index 5279e57..e751681 100644
> > --- a/arch/arm64/include/asm/percpu.h
> > +++ b/arch/arm64/include/asm/percpu.h
> > @@ -44,6 +44,237 @@ static inline unsigned long __my_cpu_offset(void)

[...]

> > +static inline unsigned long __percpu_read(void *ptr, int size)
> > +{
> > +       unsigned long ret;
> > +
> > +       switch (size) {
> > +       case 1:
> > +               asm ("//__per_cpu_read_1\n"
> > +                       "ldrb %w[ret], %[ptr]\n" :
> > +                       [ret] "=&r"(ret), [ptr] "+Q"(*(u8 *)ptr));
> > +               break;
> > +       case 2:
> > +               asm ("//__per_cpu_read_2\n"
> > +                       "ldrh %w[ret], %[ptr]\n" :
> > +                       [ret] "=&r"(ret), [ptr] "+Q"(*(u16 *)ptr));
> > +               break;
> > +       case 4:
> > +               asm ("//__per_cpu_read_4\n"
> > +                       "ldr %w[ret], %[ptr]\n" :
> > +                       [ret] "=&r"(ret), [ptr] "+Q"(*(u32 *)ptr));
> > +               break;
> > +       case 8:
> > +               asm ("//__per_cpu_read_8\n"
> > +                       "ldr %[ret], %[ptr]\n" :
> > +                       [ret] "=&r"(ret), [ptr] "+Q"(*(u64 *)ptr));
> > +               break;
> > +       default:
> > +               BUILD_BUG();
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> 
> Why are the 'ptr' references '+Q' outputs here rather than 'Q' inputs?
> 

Because I fudged the constraint :-).
Thanks, you're quite right it should be 'Q' constraint as we're only reading
from that address.

> > +static inline void __percpu_write(void *ptr, unsigned long val, int size)
> > +{
> > +       switch (size) {
> > +       case 1:
> > +               asm ("//__per_cpu_write_1\n"
> > +                       "strb %w[val], %[ptr]\n" :
> > +                       [ptr] "+Q"(*(u8 *)ptr) : [val] "r"(val));
> > +               break;
> > +       case 2:
> > +               asm ("//__per_cpu_write_2\n"
> > +                       "strh %w[val], %[ptr]\n" :
> > +                       [ptr] "+Q"(*(u16 *)ptr) : [val] "r"(val));
> > +               break;
> > +       case 4:
> > +               asm ("//__per_cpu_write_4\n"
> > +                       "str %w[val], %[ptr]\n" :
> > +                       [ptr] "+Q"(*(u32 *)ptr) : [val] "r"(val));
> > +               break;
> > +       case 8:
> > +               asm ("//__per_cpu_write_8\n"
> > +                       "str %[val], %[ptr]\n" :
> > +                       [ptr] "+Q"(*(u64 *)ptr) : [val] "r"(val));
> > +               break;
> > +       default:
> > +               BUILD_BUG();
> > +       }
> > +}
> > +
> 
> ... and similarly, why are these '+Q' and not just '=Q' ?

Another mistake on my part, it should be "=Q" as we're only writing to that
address.

Thanks for going through this carefully Ard, I'll send out a corrected V2 once
I've sanity checked it.

Cheers,
-- 
Steve
