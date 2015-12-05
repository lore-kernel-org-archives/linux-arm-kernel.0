From: mw@semihalf.com (Marcin Wojtas)
Date: Sat, 5 Dec 2015 20:14:31 +0100
Subject: [PATCH net-next v2 4/4] net: mvneta: Spread out the TX queues
 management on all CPUs
In-Reply-To: <1449254700-32685-5-git-send-email-gregory.clement@free-electrons.com>
References: <1449254700-32685-1-git-send-email-gregory.clement@free-electrons.com>
 <1449254700-32685-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAPv3WKe32dUP0jTkjJkWF=tpJDkR_J3Z5aSR5YT8rJtoMAKyjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

> @@ -1824,13 +1835,16 @@ error:
>  static int mvneta_tx(struct sk_buff *skb, struct net_device *dev)
>  {
>         struct mvneta_port *pp = netdev_priv(dev);
> -       u16 txq_id = skb_get_queue_mapping(skb);
> +       u16 txq_id = smp_processor_id() % txq_number;

I think it may be ok to bind TXQs to different CPUs, but I don't think
that replacing skb_get_queue_mapping by in fact smp_processor_id() is
the best idea. This way you use only 2 TXQs on A385 and 4 TXQs on AXP.
There are HW mechanisms like WRR or EJP that provide balancing for
egress, so let's better keep all 8.

As a compromise I think it's enough to do the mapping and we would
achieve some offload by TX processing done on different CPU's and let
BQL do the balance on higher level. FYI, I've already implemented BQL
and will submit it asap, however I still have some weird problems
after enabling it.

Best regards,
Marcin
