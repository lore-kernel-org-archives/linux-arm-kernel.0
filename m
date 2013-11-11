From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Nov 2013 15:00:13 +0000
Subject: [PATCH v4 3/4] AArch64: KGDB: Add step debugging support
In-Reply-To: <CALicx6uaK_xk+nNCvYMjO2FrNQDQWqhWk54NMccYTE2ji=gycw@mail.gmail.com>
References: <1383641146-27274-1-git-send-email-vijay.kilari@gmail.com>
 <1383641146-27274-4-git-send-email-vijay.kilari@gmail.com>
 <20131108141841.GI17461@mudshark.cambridge.arm.com>
 <CALicx6uaK_xk+nNCvYMjO2FrNQDQWqhWk54NMccYTE2ji=gycw@mail.gmail.com>
Message-ID: <20131111150013.GJ28302@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 11:09:46AM +0000, Vijay Kilari wrote:
> On Fri, Nov 8, 2013 at 7:48 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Nov 05, 2013 at 08:45:45AM +0000, vijay.kilari at gmail.com wrote:
> >> @@ -153,6 +166,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
> >>                * Packet D (Detach), k (kill). No special handling
> >>                * is required here
> >>                */
> >> +             atomic_set(&kgdb_cpu_doing_single_step, -1);
> >> +             kgdb_single_step =  0;
> >
> > This looks really weird: you have two variables, which you attempt to keep
> > in sync, only one of them is an atomic access and you don't have any
> > locking or memory barriers between them, so it must be ok if they're not
> > in-sync. In which case, why do we have two variables?
> >
> IMHO, two variables are being used by kgdb framework
> The variables 'kgdb_cpu_doing_single_step'  holds the cpu on which
> step debugging
> is happening. With this, when during step debugging, it ensures that on next
> step debug exception only this CPU aquires master lock and step
> debugging is performed.
> 
> The variable 'kgdb_single_step' is used to know if step debugging is
> ongoing or not.
> If so, the non-primary cpu's are not released untill the continue
> command is received
> So, with this the cpu's are not released and acquired for every step command

Ok, but in what situation would you have both kgdb_cpu_doing_single_step == -1
and kgdb_single_step == 1 (ignoring races between setting the two variables)?

In other words, can we reduce this to a single variable?

Will
