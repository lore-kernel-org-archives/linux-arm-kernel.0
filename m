From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 21 Mar 2017 13:14:52 -0700
Subject: [PATCH] netfilter: nfnetlink_cthelper: Fix memory leak
In-Reply-To: <1490079425-6172-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1490079425-6172-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <CAKdAkRSyMyGDFP_VotukxZWpfTr1GUfKpD_+1mP=djz1sG+WRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 11:57 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> We have memory leaks of nf_conntrack_helper & expect_policy.
>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

This looks reasonable to me:

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

But you need to send it to correct lists, and linux-arm-kernel is not it:

./scripts/get_maintainer.pl -f net/netfilter/nfnetlink_cthelper.c
Pablo Neira Ayuso <pablo@netfilter.org> (supporter:NETFILTER)
Jozsef Kadlecsik <kadlec@blackhole.kfki.hu> (supporter:NETFILTER)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
netfilter-devel at vger.kernel.org (open list:NETFILTER)
coreteam at netfilter.org (open list:NETFILTER)
netdev at vger.kernel.org (open list:NETWORKING [GENERAL])
linux-kernel at vger.kernel.org (open list)

> ---
>
>  net/netfilter/nfnetlink_cthelper.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/net/netfilter/nfnetlink_cthelper.c b/net/netfilter/nfnetlink_cthelper.c
> index de87823..99d4bd7 100644
> --- a/net/netfilter/nfnetlink_cthelper.c
> +++ b/net/netfilter/nfnetlink_cthelper.c
> @@ -191,6 +191,8 @@ nfnl_cthelper_parse_expect_policy(struct nf_conntrack_helper *helper,
>                 if (ret < 0)
>                         goto err;
>         }
> +
> +       kfree(helper->expect_policy);
>         helper->expect_policy = expect_policy;
>         return 0;
>  err:
> @@ -249,6 +251,7 @@ nfnl_cthelper_create(const struct nlattr * const tb[],
>
>         return 0;
>  err:
> +       kfree(helper->expect_policy);
>         kfree(helper);
>         return ret;
>  }
> @@ -612,6 +615,8 @@ static int nfnl_cthelper_del(struct net *net, struct sock *nfnl,
>
>                         found = true;
>                         nf_conntrack_helper_unregister(cur);
> +                       kfree(cur->expect_policy);
> +                       kfree(cur);
>                 }
>         }
>         /* Make sure we return success if we flush and there is no helpers */
> @@ -675,6 +680,8 @@ static void __exit nfnl_cthelper_exit(void)
>                                 continue;
>
>                         nf_conntrack_helper_unregister(cur);
> +                       kfree(cur->expect_policy);
> +                       kfree(cur);
>                 }
>         }
>  }

Thanks.

-- 
Dmitry
