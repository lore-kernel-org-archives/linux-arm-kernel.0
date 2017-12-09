From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 10 Dec 2017 00:27:43 +0100
Subject: [PATCH net-next 2/2 v6] net: ethernet: Add a driver for Gemini
 gigabit ethernet
In-Reply-To: <20171205190331.GA29007@qmqm.qmqm.pl>
References: <20171202110640.5284-1-linus.walleij@linaro.org>
 <20171202110640.5284-2-linus.walleij@linaro.org>
 <20171205190331.GA29007@qmqm.qmqm.pl>
Message-ID: <CACRpkdb7Y4TFNy1ZDrFZM=iuqLvH2iqXqt3ED7iMwY6Q8HV37A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 8:03 PM, Micha? Miros?aw <mirq-linux@rere.qmqm.pl> wrote:

> I'm happy to see that my work didn't go to /dev/null after all.
> I haven't finished it at the time because the box I had broke down
> beyond repair.

Ooops that explains why the submission was just haning in mid-air.
Sorry man :(

> I skimmed through the patch - please find my comments below.

Thanks a lot! :)

I fixed most of them for v8, just some comments:

> [...]
>> +static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
>> +     GMAC_RXDESC_0_T word0, unsigned frame_len)
>> +{
>> +     struct sk_buff *skb = NULL;
>> +     unsigned rx_status = word0.bits.status;
>> +     unsigned rx_csum = word0.bits.chksum_status;
>
>> +     port->rx_stats[rx_status]++;
>> +     port->rx_csum_stats[rx_csum]++;
>> +
>> +     if (word0.bits.derr || word0.bits.perr ||
>> +         rx_status || frame_len < ETH_ZLEN ||
>> +         rx_csum >= RX_CHKSUM_IP_ERR_UNKNOWN) {
>> +             port->stats.rx_errors++;
>> +
>> +             if (frame_len < ETH_ZLEN || RX_ERROR_LENGTH(rx_status))
>> +                     port->stats.rx_length_errors++;
>> +             if (RX_ERROR_OVER(rx_status))
>> +                     port->stats.rx_over_errors++;
>> +             if (RX_ERROR_CRC(rx_status))
>> +                     port->stats.rx_crc_errors++;
>> +             if (RX_ERROR_FRAME(rx_status))
>> +                     port->stats.rx_frame_errors++;
>> +
>> +             return NULL;
>
> Could support RXALL feature here.

Probably! I might experiment with it in a separate (follow up) patch
since I have to figure out how much the hardware supports ignoring
errors and exploit that properly.

>> +static unsigned int gmac_rx(struct net_device *netdev, unsigned budget)
>> +{
> [...]
>> +             if (unlikely(!mapping)) {
>> +                     netdev_err(netdev,
>> +                                "rxq[%u]: HW BUG: zero DMA desc\n", r);
>> +                     goto err_drop;
>> +             }
>
> I wonder if this was a bug in the driver or in HW. Does it trigger on
> your boxes?

No I haven't seen it. I think it may be a HW bug on elder chips
(before SL3512 and SL3516) that is just not manifesting on newer
hardware.

Better keep the code though.

>> +static void gmac_set_rx_mode(struct net_device *netdev)
>> +{
>> +     struct gemini_ethernet_port *port = netdev_priv(netdev);
>> +     struct netdev_hw_addr *ha;
>> +     __u32 mc_filter[2];
>> +     unsigned bit_nr;
>> +     GMAC_RX_FLTR_T filter = { .bits = {
>> +             .broadcast = 1,
>> +             .multicast = 1,
>> +             .unicast = 1,
>> +     } };
>> +
>> +     mc_filter[1] = mc_filter[0] = 0;
>
> Looks like this should be = ~0u (IFF_ALLMULTI case).

Yeah it's some error compared to the (horrible) vendor code
here. The vendor tree explicitly checks for both promiscuous
and multicast and sets the masks to ~0 in both cases
explicitly, else leave it as default 0 with the funky
algorithm to set up the mask bit by bit.

I rewrote this piece of code to do the same.

Yours,
Linus Walleij
