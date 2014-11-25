From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 25 Nov 2014 08:25:22 -0800
Subject: [PATCH] opp: convert dev_warn() to dev_dbg() for duplicate OPPs
In-Reply-To: <CAKohpo=dDTAV=B0CvCqD1H-QGuQ+i2w5Lfr3egpWzrvRYVNWmw@mail.gmail.com>
References: <7017fa592bdaf73c260ad001a2b7abdc8d14f08a.1416211616.git.viresh.kumar@linaro.org>
 <5171628.FRGslOuEb6@vostro.rjw.lan>
 <CAKohpomz_UiRErSsDPLWcmU4e7ocXZZu7bwCF8TvoSJupikd7A@mail.gmail.com>
 <42965945.ST26GKfzPz@vostro.rjw.lan>
 <20141124161435.GE5050@linux.vnet.ibm.com>
 <CAKohpo=dDTAV=B0CvCqD1H-QGuQ+i2w5Lfr3egpWzrvRYVNWmw@mail.gmail.com>
Message-ID: <20141125162522.GD5050@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 04:07:35PM +0530, Viresh Kumar wrote:
> On 24 November 2014 at 21:44, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > As Rafael says, if opp is reachable by RCU readers, you cannot just
> > immediately kfree() it.  Immediately kfree()ing it like this -will-
> > cause your RCU readers to see freed memory, which, as you noted, can
> > cause crashes.
> 
> In order to reply you at some level, I tried going through RCU documentation
> today before replying anymore. And yes I understood this part.
> 
> > Except that srcu_notifier_call_chain() involves SRCU readers.  So,
> > unless I am confused, you instead need something like this:
> >
> > static void kfree_opp_rcu(struct rcu_head *rhp)
> > {
> >         struct device_opp *opp = container_of(rhp, struct device_opp, opp_list);
> >
> >         kfree(opp);
> > }
> >
> > Then replace the above kfree() by:
> >
> >         call_srcu(&opp->rcu, kfree_opp_rcu);
> 
> Correct. But you missed the srcu which should be the first argument here :)

Indeed I did!  ;-)

> > This will require adding the following to struct device_opp:
> >
> >         struct rcu_head rcu;
> 
> We were freeing struct dev_pm_opp, and so I believe you
> wanted me to add it there? Its already there.

Fair enough!

> > All that said, I do not claim to understand the OPP code, so please take
> > the above suggested changes with a grain of salt.  And if you let me know
> > where I am confused, I should be able to offer better suggestions.
> 
> Thanks for your suggestions. I have sent the patch to list and cc'd you on
> the relevant ones. Would be great if you can review the rcu part there.

Done!

							Thanx, Paul
