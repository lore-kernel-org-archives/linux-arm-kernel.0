From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 26 Jan 2016 14:15:21 -0800
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <20160126201037.GU4503@linux.vnet.ibm.com>
References: <20160114204827.GE3818@linux.vnet.ibm.com>
 <20160118081929.GA30420@gondor.apana.org.au>
 <20160118154629.GB3818@linux.vnet.ibm.com>
 <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
 <20160126172227.GG6357@twins.programming.kicks-ass.net>
 <CA+55aFzcC6C8imPs5vk4yH1Y2YHjnAdFM9HCkVs04COxuDQH6w@mail.gmail.com>
 <20160126201037.GU4503@linux.vnet.ibm.com>
Message-ID: <CA+55aFxjb+2rs2wVHtiSCcOzgMrE8H=yDeNcjyujPQudDCtLgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 12:10 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Tue, Jan 26, 2016 at 11:44:46AM -0800, Linus Torvalds wrote:
>>
>> >         struct foo *x = READ_ONCE(*ptr);
>> >         smp_read_barrier_depends();
>> >         x->bar = 5;
>>
>> This case is complete BS. Stop perpetuating it. I already removed a
>> number of bogus cases of it, and I removed the incorrect documentation
>> that had this crap.
>
> If I understand your objection correctly, you want the above pattern
> expressed either like this:
>
>         struct foo *x = rcu_dereference(*ptr);
>         x->bar = 5;
>
> Or like this:
>
>         struct foo *x = lockless_dereference(*ptr);
>         x->bar = 5;
>
> Or am I missing your point?

You are entirely missing the point.

You might as well just write it as

    struct foo x = READ_ONCE(*ptr);
    x->bar = 5;

because that "smp_read_barrier_depends()" does NOTHING wrt the second write.

So what I am saying is simple: anybody who writes that
"smp_read_barrier_depends()" in there is just ttoally and completely
WRONG, and the fact that Peter wrote it out after I removed several
instances of that bloody f*cking idiocy is disturbing.

Don't do it. It's BS. It's wrong. Don't make excuses for it.

             Linus
