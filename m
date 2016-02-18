From: mw@semihalf.com (Marcin Wojtas)
Date: Thu, 18 Feb 2016 12:41:40 +0100
Subject: [PATCH v2 net-next 6/8] net: mvneta: bm: add support for hardware
 buffer management
In-Reply-To: <20160217.234321.1202099534402079240.davem@davemloft.net>
References: <1455636823-14470-1-git-send-email-gregory.clement@free-electrons.com>
 <1455636823-14470-7-git-send-email-gregory.clement@free-electrons.com>
 <20160217.234321.1202099534402079240.davem@davemloft.net>
Message-ID: <CAPv3WKfDo8YV1PksBwhVnL6PLeUomxhWgZzhDMZ7fKX95aSPpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,


2016-02-18 5:43 GMT+01:00 David Miller <davem@davemloft.net>:
> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Date: Tue, 16 Feb 2016 16:33:41 +0100
>
>>       pp->dev = dev;
>>       SET_NETDEV_DEV(dev, &pdev->dev);
>>
>> +     dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO;
>> +     dev->hw_features |= dev->features;
>> +     dev->vlan_features |= dev->features;
>> +     dev->priv_flags |= IFF_UNICAST_FLT;
>> +     dev->gso_max_segs = MVNETA_MAX_TSO_SEGS;
>> +
>> +     err = register_netdev(dev);
>> +     if (err < 0) {
>> +             dev_err(&pdev->dev, "failed to register\n");
>> +             goto err_free_stats;
>> +     }
>> +
>> +     pp->id = dev->ifindex;
>> +
>> +     /* Obtain access to BM resources if enabled and already initialized */
>> +     bm_node = of_parse_phandle(dn, "buffer-manager", 0);
>> +     if (bm_node && bm_node->data) {
>
> This set of changes has a lot of problems.
>
> First, the exact moment you call register_netdev() your device must be
> fully initialized because ->open() can be invoked immediately.  This
> means you must take care of all of this buffer manager stuff before
> calling register_netdev().
>
> It must precisely be the last thing you invoke in your probe function
> for this reason.

Ok. I shifted register_netdev in order to obtain port id dynamically
from netdev's ifindex (needed to control port <-> pool mapping). If
this order of registration is problematic, I will add an ID property
to DT.

>
> Also you are now adding conditionalized code to every fastpath in your
> driver, that is rediculous and is going to hurt performance.
>
> Add seperate code paths for the HWBM vs SWBM, and register a unique
> set of netdev_ops as appropriate.

TX is untouched and BM support affects only open, stop and change_mtu
- whose execution is not problematic in terms of performance. However
there are a couple new conditions in mvneta_rx(). It can be reduced to
a single condition check, moved to NAPI callback. I'll try to refactor
code in a way to avoid code duplication. Please bear in mind I don't
want to register to different NAPI functions (exactly the same apart
from one line), as the driver can fall back to SWBM after e.g.
unsuccessful mtu change.

Best regards,
Marcin
