From: davem@davemloft.net (David Miller)
Date: Thu, 08 Feb 2018 15:34:53 -0500 (EST)
Subject: net: thunder: change q_len's type to handle max ring size
In-Reply-To: <151811766130.10712.18293368656209944798.email-sent-by-dnelson@aqua>
References: <151811766130.10712.18293368656209944798.email-sent-by-dnelson@aqua>
Message-ID: <20180208.153453.774785043965984772.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dean Nelson <dnelson@redhat.com>
Date: 

> The Cavium thunder nicvf driver supports rx/tx rings of up to 65536 entries per.
> The number of entires are stored in the q_len member of struct q_desc_mem. The
> problem is that q_len being a u16, results in 65536 becoming 0.
> 
> In getting pointers to descriptors in the rings, the driver uses q_len minus 1
> as a mask after incrementing the pointer, in order to go back to the beginning
> and not go past the end of the ring.
> 
> With the q_len set to 0 the mask is no longer correct and the driver does go
> beyond the end of the ring, causing various ills. Usually the first thing that
> shows up is a "NETDEV WATCHDOG: enP2p1s0f1 (nicvf): transmit queue 7 timed out"
> warning.
> 
> This patch remedies the problem by changing q_len to a u32.
> 
> Signed-off-by: Dean Nelson <dnelson@redhat.com>

Applied, thanks.

Another way to solve this could have been to encode that length
as "length - 1"
