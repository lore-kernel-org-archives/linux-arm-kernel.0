From: dave.taht@gmail.com (Dave Taht)
Date: Wed, 8 Aug 2018 10:57:45 -0700
Subject: [PATCH v1 6/7] net: mvneta: Don't use GRO on Armada 3720
In-Reply-To: <20180808165846.GK7275@lunn.ch>
References: <20180808152706.21727-1-marek.behun@nic.cz>
 <20180808152706.21727-7-marek.behun@nic.cz>
 <20180808165846.GK7275@lunn.ch>
Message-ID: <CAA93jw7dna_9M_Mt22iCvSPeC3piLdrHRg+3NR3R44+VVmgREA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2018 at 10:00 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Aug 08, 2018 at 05:27:05PM +0200, Marek Beh?n wrote:
> > For some reason on Armada 3720 boards (EspressoBin and Turris Mox) the
> > networking driver behaves weirdly when using napi_gro_receive.
> >
> > For example downloading a big file from a local network (low ping) is
> > fast, but when downloading from a remote server (higher ping), the
> > download speed is at first high but drops rapidly to almost nothing or
> > absolutely nothing.
> >
> > This is fixed when using netif_receive_skb instead of napi_gro_receive.
>
> Before doing this, we should really understand what is going on. It is
> probably just a driver bug which needs fixing. And GRO should be good
> for performance, so we do want to use it, if possible.

I'd just disable it and worry about it later. The software gro in the
mvneta would batch up 64k and is one of the reasons why sch_cake does
gso splitting by default. (64k unsplit, downshifted to 1mbit = ~540ms
of latency). If this mvneta facility is in addition buggy, that
explains some puzzling things I've seen in various benchmarks. thx for
the steer as to what to look for!

IMHO: in general gro looks good on dumb single stream benchmarks, not
as useful on mixed routed traffic with more entropy, and batching
clutters up the mvneta receive path that otherwise could be draining
the rx ring and spitting packets into the rest of the system faster.
The mvneta is mostly (?) used on routing devices.



>
>     Andrew



-- 

Dave T?ht
CEO, TekLibre, LLC
http://www.teklibre.com
Tel: 1-669-226-2619
