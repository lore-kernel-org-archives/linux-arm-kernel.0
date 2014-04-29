From: lznuaa@gmail.com (Frank Li)
Date: Tue, 29 Apr 2014 08:57:20 -0500
Subject: [PATCH net-next 5/7] net:fec: add support for dumping transmit
 ring on timeout
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F7014F0@AcuExch.aculab.com>
References: <1398773350-7293-1-git-send-email-Frank.Li@freescale.com>
 <1398773350-7293-5-git-send-email-Frank.Li@freescale.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F7014F0@AcuExch.aculab.com>
Message-ID: <CAHrpEqSCSw=bYgx5Egk4Mva-CODnw5=vvK6y3VWmB3_QpBQ8sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 8:38 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Of Frank Li
> ...
>> When we timeout on transmit, it would be useful to dump the transmit
>> ring, so we can see the ring state.  This can be helpful to diagnose
>> the cause of transmit timeouts.
> ...
>> +static void fec_dump(struct net_device *ndev)
>> +{
>> +     struct fec_enet_private *fep = netdev_priv(ndev);
>> +     struct bufdesc *bdp = fep->tx_bd_base;
>> +     unsigned index = 0;
>> +
>> +     netdev_info(ndev, "TX ring dump\n");
>> +     pr_info("Nr     SC     addr       len  SKB\n");
>> +
>> +     do {
>> +             pr_info("%3u %c%c 0x%04x 0x%08lx %4u %p\n",
>> +                     index,
>> +                     bdp == fep->cur_tx ? 'S' : ' ',
>> +                     bdp == fep->dirty_tx ? 'H' : ' ',
>> +                     bdp->cbd_sc, bdp->cbd_bufaddr, bdp->cbd_datlen,
>> +                     fep->tx_skbuff[index]);
>> +             bdp = fec_enet_get_nextdesc(bdp, fep);
>> +             index++;
>> +     } while (bdp != fep->tx_bd_base);
>> +}
>> +
>
> You probably want the read and write indexes as well.

                     bdp == fep->cur_tx ? 'S' : ' ',
                     bdp == fep->dirty_tx ? 'H' : ' ',

Above code already print read and write index. 'S', 'H'

Frank Li

>
>         David
>
>
>
