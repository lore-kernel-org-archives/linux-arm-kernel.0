From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 25 Nov 2015 15:54:00 +0100
Subject: [PATCH net-next 0/3] mvneta: Introduce RSS support
Message-ID: <1448463243-21057-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series is the first step add RSS support on mvneta.

It will allow associating an ethernet interface to a given CPU through
RSS by using "ethtool -X ethX weight". Indeed, currently I only enable
one entry in the RSS lookup table. Even if it is not really RSS, it
allows to get back the irq affinity feature we lost by using the
percpu interrupt.

Compared to the RFC series I added a missing patch for the series, I
rebased onto v4.4-rc1 and I fixed the mvneta_config_rss. Marcin
pointed that making the interrupt should be done on all the CPUs.

Th first patch make the default queue associate to each port and no
more a global variable.

The second patch really associates the RX queues with the CPUs instead
of masking the percpu interrupts for doing it. All the RX queues are
enabled and are statically associated with the CPUs by using a modulo
of the number of present CPUs. But at this stage only one RX queue
will receive the stream.

I also choose to associate all the TX queues on the same CPU that the
one associated to the RX queue. It allows to contain all the
interrupts on the same CPU. I think that an improvement on this side
would be the support of the XPS.

The last patch introduces a first level of RSS support through the
ethtool functions. As explained in the introduction there is only one
entry in the RSS lookup table which permits at the end to associate an
mvneta port to a CPU through the RX queues because the mapping is
static.

Thanks,

Gregory CLEMENT (3):
  net: mvneta: Make the default queue related for each port
  net: mvneta: Associate RX queues with each CPU
  net: mvneta: Add naive RSS support

 drivers/net/ethernet/marvell/mvneta.c | 298 +++++++++++++++++++++++++++++-----
 1 file changed, 253 insertions(+), 45 deletions(-)

-- 
2.5.0
