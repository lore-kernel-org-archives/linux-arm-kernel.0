From: Leonid.Yegoshin@imgtec.com (Leonid Yegoshin)
Date: Wed, 13 Jan 2016 14:26:16 -0800
Subject: [v3,11/41] mips: reuse asm-generic/barrier.h
In-Reply-To: <20160113104516.GE25458@arm.com>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
 <56945366.2090504@imgtec.com>
 <20160112092711.GP6344@twins.programming.kicks-ass.net>
 <20160112102555.GV6373@twins.programming.kicks-ass.net>
 <20160112104012.GW6373@twins.programming.kicks-ass.net>
 <20160112114111.GB15737@arm.com> <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com>
Message-ID: <5696CF08.8080700@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2016 02:45 AM, Will Deacon wrote:
>>
> I don't think the address dependency is enough on its own. By that
> reasoning, the following variant (WRC+addr+addr) would work too:
>
>
> P0:
> Wx = 1
>
> P1:
> Rx == 1
> <address dep>
> Wy = 1
>
> P2:
> Ry == 1
> <address dep>
> Rx = 0
>
>
> So are you saying that this is also forbidden?
> Imagine that P0 and P1 are two threads that share a store buffer. What
> then?

OK, I collected answers and it is:

     In MIPS R6 this test passes OK, I mean - P2: Rx = 1 if Ry is read 
as 1. By design.

     However, it is unclear that happens in MIPS R2 1004K.

     Moreover, there are voices against guarantee that it will be in 
future and that voices point me to Documentation/memory-barriers.txt 
section "DATA DEPENDENCY BARRIERS" examples which require SYNC_RMB 
between loading address/index and using that for loading data based on 
that address or index for shared data (look on CPU2 pseudo-code):
> To deal with this, a data dependency barrier or better must be inserted
> between the address load and the data load:
>
>         CPU 1                 CPU 2
>         ===============       ===============
>         { A == 1, B == 2, C = 3, P == &A, Q == &C }
>         B = 4;
>         <write barrier>
>         WRITE_ONCE(P, &B);
>                               Q = READ_ONCE(P);
>                               <data dependency barrier> <----------- 
> SYNC_RMB is here
>                               D = *Q;
...
> Another example of where data dependency barriers might be required is 
> where a
> number is read from memory and then used to calculate the index for an 
> array
> access:
>
>         CPU 1                 CPU 2
>         ===============       ===============
>         { M[0] == 1, M[1] == 2, M[3] = 3, P == 0, Q == 3 }
>         M[1] = 4;
>         <write barrier>
>         WRITE_ONCE(P, 1);
>                               Q = READ_ONCE(P);
>                               <data dependency barrier> <------------ 
> SYNC_RMB is here
>                               D = M[Q];

That voices say that there is a legitimate reason to relax HW here for 
performance if SYNC_RMB is needed anyway to work with this sequence of 
shared data.


And all that is out-of-topic here in my mind. I just want to be sure 
that this patchset still provides a use of a specific lightweight SYNCs 
on MIPS vs bold and heavy generalized "SYNC 0" in any case.

- Leonid.
