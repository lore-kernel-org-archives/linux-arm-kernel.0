From: w@1wt.eu (Willy Tarreau)
Date: Mon, 15 Apr 2013 14:05:48 +0200
Subject: net: mvneta: fix improper tx queue usage in mvneta_tx()
In-Reply-To: <516BE98D.2040706@free-electrons.com>
References: <20130415063537.GA26507@1wt.eu>
 <516BE98D.2040706@free-electrons.com>
Message-ID: <20130415120548.GD27217@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 01:50:37PM +0200, Gregory CLEMENT wrote:
> Hi Willy
> 
> On 04/15/2013 08:35 AM, Willy Tarreau wrote:
> > From 4f2069c92a27790e6071dc2a80f92c166e0b0ca4 Mon Sep 17 00:00:00 2001
> > From: Willy Tarreau <w@1wt.eu>
> > Date: Thu, 11 Apr 2013 23:00:37 +0200
> > Subject: net: mvneta: fix improper tx queue usage in mvneta_tx()
> > 
> > mvneta_tx() was using a static tx queue number causing crashes as
> > soon as a little bit of traffic was sent via the interface, because
> > it is normally expected that the same queue should be used as in
> > dev_queue_xmit().
> > 
> > As suggested by Ben Hutchings, let's use skb_get_queue_mapping() to
> > get the proper Tx queue number, and use alloc_etherdev_mqs() instead
> > of alloc_etherdev_mq() to create the queues.
> > 
> > Both my Mirabox and my OpenBlocks AX3 used to crash without this patch
> > and don't anymore with it. The issue appeared in 3.8 but became more
> > visible after the fix allowing GSO to be enabled.
> > 
> > Original work was done by Dmitri Epshtein and Thomas Petazzoni. I
> > just adapted it to take care of Ben's comments.
> 
> Thanks for this work. I have tested on a DB-MV784MP-GP board in SMP
> with 4 CPUs. Without this patch a "iperf -P 4" lead to a kernel crash
> in 80% of the case and to a hang in the remaining cases. Now after
> a dozen of tests on this board, I didn't see any crash or hang.
> You can add my
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks for testing Gregory !

Willy
