From: w@1wt.eu (Willy Tarreau)
Date: Wed, 6 Jul 2016 07:04:31 +0200
Subject: [PATCH net] net: mvneta: set real interrupt per packet for tx_done
In-Reply-To: <1467771538-31811-1-git-send-email-mw@semihalf.com>
References: <1467771538-31811-1-git-send-email-mw@semihalf.com>
Message-ID: <20160706050431.GA26348@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 06, 2016 at 04:18:58AM +0200, Marcin Wojtas wrote:
> From: Dmitri Epshtein <dima@marvell.com>
> 
> Commit aebea2ba0f74 ("net: mvneta: fix Tx interrupt delay") intended to
> set coalescing threshold to a value guaranteeing interrupt generation
> per each sent packet, so that buffers can be released with no delay.
> 
> In fact setting threshold to '1' was wrong, because it causes interrupt
> every two packets. According to the documentation a reason behind it is
> following - interrupt occurs once sent buffers counter reaches a value,
> which is higher than one specified in MVNETA_TXQ_SIZE_REG(q). This
> behavior was confirmed during tests. Also when testing the SoC working
> as a NAS device, better performance was observed with int-per-packet,
> as it strongly depends on the fact that all transmitted packets are
> released immediately.
> 
> This commit enables NETA controller work in interrupt per sent packet mode
> by setting coalescing threshold to 0.

We had a discussion about this in January 2015 and I thought I sent a patch
to change it but I can't find it, so I think it was only proposed to some
users for testing. I also remember that on more recent kernels by then
(>=3.13) we observed a slightly better performance with this value set to
zero.

Acked-by: Willy Tarreau <w@1wt.eu>

Willy
