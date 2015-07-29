From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 29 Jul 2015 13:14:44 +0200
Subject: [RFC PATCH 0/2] disambiguate s3c64xx controller-data and ofpart
 partition nodes
Message-ID: <cover.1438168484.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

the ofpart partition nodes and s3c64xx controller-data nodes are both subnodes
of MTD SPI slaves such as spi-nor.

When ofpart is compiled-in and no partitions are defined on a MTD SPI slave
ofpart tries to parse the controller-data node, gets confused, mtd probe fails,
and the mtd device is inaccessible.

ofpart claims all subnodes of mtd devices which have no compatible and when
there is a subnode but no partitions are found it reports error which is then
propagated to mtd probe.

A simple fix that turns the error into a warning was rejected on the basis that
the ofpart parser could then accept invalid devicetree as fallback.

https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg941351.html

Firstly, the ofpart parser already does accept 'invalid' trees as fallback.
Looking at the code it only requires that there is one mtd subnode that parses
as partition and there can be arbitrary number of other nodes which were not
understood. It only singles out the case when there are subnodes but none is
understood as partition.

Secondly, the fact that a devicetree node is not understood by a particular
driver does not make it 'invalid'.

In my view either it is acceptable that nodes without compatible property exist
and then drivers using such nodes should be ready to gracefully handle nodes
that do not have compatible property but are meant for another driver. The
s3c64xx driver already does this but ofpart does not.

On the other hand, if not using a compatible property is not acceptable then
both drivers should use a compatible property to reserve their subnodes for
themselves and avoid any conflict.

Either way I would like the maintainers of the conflicting drivers to agree on
where compatible property should be and where not so that compiling-in ofpart
does not make valid MTD devices inaccessible.

The patches are only for illustration and are not meant to be included
anywhere. They are not tested and miss adding the properties to tens of binding
docs and dts files.

Thanks

Michal

Michal Suchanek (2):
  dt: mtd: ofpart: use compatible for partitions
  dt: spi: s3c64xx: add compatible to controller-data

 .../devicetree/bindings/mtd/partition.txt          |  7 +++++-
 .../devicetree/bindings/spi/spi-samsung.txt        |  3 +++
 drivers/mtd/ofpart.c                               | 26 +++++++++++++---------
 drivers/spi/spi-s3c64xx.c                          |  4 ++++
 4 files changed, 29 insertions(+), 11 deletions(-)

-- 
2.1.4
