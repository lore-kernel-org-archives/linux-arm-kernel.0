From: walken@google.com (Michel Lespinasse)
Date: Tue, 19 Feb 2013 17:40:50 +0800
Subject: [PATCH v6 08/46] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
In-Reply-To: <51227810.6090009@linux.vnet.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <20130218123920.26245.56709.stgit@srivatsabhat.in.ibm.com>
 <CANN689HhVxDv+3Bn9UAxOMzj0egTvVp_c7oAmQ2nnQ8Xjn_aMA@mail.gmail.com>
 <51225A36.40600@linux.vnet.ibm.com>
 <CANN689FJPLfz06MFRJ9T+BuToejAzjYP_yrw_H4iGi1Kb3p2-g@mail.gmail.com>
 <51227810.6090009@linux.vnet.ibm.com>
Message-ID: <CANN689E-98zK69pGeojbm30n3sswQYVBvhk3i3OzqvbeqSrSrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 2:50 AM, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> But, the whole intention behind removing the parts depending on the
> recursive property of rwlocks would be to make it easier to make rwlocks
> fair (going forward) right? Then, that won't work for CPU hotplug, because,
> just like we have a legitimate reason to have recursive
> get_online_cpus_atomic(), we also have a legitimate reason to have
> unfairness in locking (i.e., for deadlock-safety). So we simply can't
> afford to make the locking fair - we'll end up in too many deadlock
> possibilities, as hinted in the changelog of patch 1.

Grumpf - I hadn't realized that making the underlying rwlock fair
would break your hotplug use case. But you are right, it would. Oh
well :/

> So the only long-term solution I can think of is to decouple
> percpu-rwlocks and rwlock_t (like what Tejun suggested) by implementing
> our own unfair locking scheme inside. What do you think?

I have no idea how hard would it be to change get_online_cpus_atomic()
call sites so that the hotplug rwlock read side has a defined order vs
other locks (thus making sure the situation you describe in patch 1
doesn't happen). I agree we shouldn't base our short term plans around
that, but maybe that's doable in the long term ???

Otherwise, I think we should add some big-fat-warning that percpu
rwlocks don't have reader/writer fairness, that the hotplug use case
actually depends on the unfairness / would break if the rwlock was
made fair, and that any new uses of percpu rwlocks should be very
carefully considered because of the reader/writer fairness issues.
Maybe even give percpu rwlocks a less generic sounding name, given how
constrained they are by the hotplug use case.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
