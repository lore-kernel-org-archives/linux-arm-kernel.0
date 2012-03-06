From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Tue, 06 Mar 2012 04:13:50 -0800
Subject: [PATCH v4] lpc32xx: Added ethernet driver
In-Reply-To: <4F55D099.5070006@antcom.de>
References: <1330983641-32622-1-git-send-email-stigge@antcom.de>
 <1330987524.2538.61.camel@bwh-desktop> <4F55D099.5070006@antcom.de>
Message-ID: <1331036030.2474.40.camel@edumazet-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mardi 06 mars 2012 ? 09:53 +0100, Roland Stigge a ?crit :

> Sounds reasonable, and will do it.
> 
> However, I implemented it from the example of
> drivers/net/ethernet/via/via-velocity.c:velocity_poll() - is there a
> good reason for doing it that way in the velocity driver or is it done
> incorrectly there, also?
> 

Its done in a non efficient way.

It works as is, but its not the right thing to do.
The NAPI port was very minimal on via-velocity it seems.

A better way is to hold no locks in the RX handler, allowing calls to
netif_receive_skb() [ and potential calls to xmit while handling this
incoming skbs ]

Problem of saying "we dont expect to be SMP anyway", is that this let
reference material for future drivers that will copy/paste the code,
then experience performance problems.
