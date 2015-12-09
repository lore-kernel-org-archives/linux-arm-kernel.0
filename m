From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed,  9 Dec 2015 18:23:47 +0100
Subject: [PATCH net-next v3 0/4] mvneta: Introduce RSS support and XPS
 configuration
Message-ID: <1449681831-2798-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series is the first step add RSS support on mvneta.

It will allow associating an ethernet interface to a given CPU through
RSS by using "ethtool -X ethX weight". Indeed, currently I only enable
one entry in the RSS lookup table. Even if it is not really RSS, it
allows to get back the irq affinity feature we lost by using the
percpu interrupt.

The main change compared to the second version is the setup for the XPS
instead of using specific hack inside the driver in the forth
patch.

Th first patch make the default queue associate to each port and no
more a global variable.

The second patch really associates the RX queues with the CPUs instead
of masking the percpu interrupts for doing it. All the RX queues are
enabled and are statically associated with the CPUs by using a modulo
of the number of present CPUs. But at this stage only one RX queue
will receive the stream.

The third patch introduces a first level of RSS support through the
ethtool functions. As explained in the introduction there is only one
entry in the RSS lookup table which permits at the end to associate an
mvneta port to a CPU through the RX queues because the mapping is
static.

Thanks,

Gregory

Gregory CLEMENT (4):
  net: mvneta: Make the default queue related for each port
  net: mvneta: Associate RX queues with each CPU
  net: mvneta: Add naive RSS support
  net: mvneta: Configure XPS support

 drivers/net/ethernet/marvell/mvneta.c | 328 +++++++++++++++++++++++++++++-----
 1 file changed, 285 insertions(+), 43 deletions(-)

-- 
2.5.0
