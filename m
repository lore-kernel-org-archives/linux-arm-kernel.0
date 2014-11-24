From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 24 Nov 2014 16:10:00 +0530
Subject: [PATCH] opp: convert dev_warn() to dev_dbg() for duplicate OPPs
In-Reply-To: <5171628.FRGslOuEb6@vostro.rjw.lan>
References: <7017fa592bdaf73c260ad001a2b7abdc8d14f08a.1416211616.git.viresh.kumar@linaro.org>
 <1714555.tu97zMrOn0@vostro.rjw.lan>
 <CAKohpoknu=V_wscVPWLdZO8xEGY6CVMNXuP4F76GNABnm9K4dQ@mail.gmail.com>
 <5171628.FRGslOuEb6@vostro.rjw.lan>
Message-ID: <CAKohpomz_UiRErSsDPLWcmU4e7ocXZZu7bwCF8TvoSJupikd7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 November 2014 at 21:28, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> What about @dynamic instead of @from_dt?  That may apply to more use cases if
> need be.

@Paul: I am stuck at a point and need help on RCUs :)

File: drivers/base/power/opp.c

We are trying to remove OPPs created from static data present in DT on
cpufreq driver's removal (when configured as module).

opp core uses RCUs internally and it looks like I need to implement:
list_for_each_entry_safe_rcu()

But, I am not sure because of these:
http://linux.derkeiler.com/Mailing-Lists/Kernel/2005-10/6280.html
http://patchwork.ozlabs.org/patch/48989/

So, wanted to ask you if I really need that or the OPP code is
buggy somewhere.

The code removing OPPs is:

        list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
                srcu_notifier_call_chain(&dev_opp->head, OPP_EVENT_REMOVE, opp);
                list_del_rcu(&opp->node);

                kfree(opp);
        }

Because we are freeing opp at the end, list_for_each_entry_rcu()
is trying to read the already freed opp to find opp->node.next
and that results in a crash.

What am I doing wrong ?

--
viresh
