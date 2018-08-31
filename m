From: npiggin@gmail.com (Nicholas Piggin)
Date: Fri, 31 Aug 2018 21:50:04 +1000
Subject: [PATCH 00/12] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
In-Reply-To: <20180831104945.GI24124@hirez.programming.kicks-ass.net>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
 <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com>
 <20180831110054.475a3534@roar.ozlabs.ibm.com>
 <CA+55aFyweLwdAeeLnPv1ceje2y9Qc2AkM+LdMzK_z29fFb96ug@mail.gmail.com>
 <20180831095417.GF13166@arm.com>
 <20180831101014.GG24124@hirez.programming.kicks-ass.net>
 <20180831203234.7b8f4d13@roar.ozlabs.ibm.com>
 <20180831104945.GI24124@hirez.programming.kicks-ass.net>
Message-ID: <20180831215004.0ae58904@roar.ozlabs.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 Aug 2018 12:49:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Aug 31, 2018 at 08:32:34PM +1000, Nicholas Piggin wrote:
> > Oh gee, I suppose. powerpc hash is kind of interesting because it's
> > crazy, Aneesh knows that code a lot better than I do. radix modulo
> > some minor details of exact instructions is fairly like x86   
> 
> The whole TLB broadcast vs explicit IPIs is a fairly big difference in
> my book.

That's true I guess. Maybe arm64 is closer.

> Anyway, have you guys tried the explicit IPI approach? Depending on how
> IPIs are routed vs broadcasts it might save a little bus traffic. No
> point in getting all CPUs to process the TLBI when there's only a hand
> full that really need it.

It has been looked at now and again there's a lot of variables to
weigh. And things are also sized and speced to cover various
hypervisors, OSes, hash and radix, etc. This is something we need to
evaluate on radix a bit better.

> 
> OTOH, I suppose the broadcast thing has been optimized to death on the
> hardware side, so who knows..

There are some advantages of doing it in hardware. Also some of doing
IPIs though. The "problem" is actually Linux is well optimised and it
can be hard to notice much impact until you get to big systems. At
least I don't know of any problem workloads outside micro benchmarks or
stress tests.

Thanks,
Nick
