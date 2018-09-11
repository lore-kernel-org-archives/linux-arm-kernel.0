From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 11 Sep 2018 11:37:34 -0700
Subject: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined
 irq events properly
In-Reply-To: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
References: <20180823225731.19063-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180911183734.GA21976@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 23, 2018 at 03:57:31PM -0700, Jae Hyun Yoo wrote:
> In most of cases, interrupt bits are set one by one but there are
> also a lot of other cases that Aspeed I2C IP sends multiple
> interrupt bits with combining master and slave events using a
> single interrupt call. It happens much more in multi-master
> environment than single-master. For an example, when master is
> waiting for a NORMAL_STOP interrupt in its MASTER_STOP state,
> SLAVE_MATCH and RX_DONE interrupts could come along with the
> NORMAL_STOP in case of an another master immediately sends data
> just after acquiring the bus. In this case, the NORMAL_STOP
> interrupt should be handled by master_irq and the SLAVE_MATCH and
> RX_DONE interrupts should be handled by slave_irq. This commit
> modifies irq hadling logic to handle the master/slave combined
> events properly.
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

This patch causes a boot stall when booting witherspoon-bmc with
qemu v3.0, and all i2c device probes fail with error -110 (timeout).
Bisect log is attached for reference.

With the same kernel configuration (aspeed_g5_defconfig),
ast2500-evb and romulus-bmc are still able to boot.
palmetto-bmc with aspeed_g4_defconfig also appears to work.

Is this a problem with qemu ? Should I drop the qemu test
for witherspoon-bmc starting with the next kernel release ?

Thanks,
Guenter

---
# bad: [09c0888767529cdb382f34452819e42d1a66a114] Add linux-next specific files for 20180911
# good: [11da3a7f84f19c26da6f86af878298694ede0804] Linux 4.19-rc3
git bisect start 'HEAD' 'v4.19-rc3'
# bad: [a2ebc71cf97bed9b453318418e4a281434565e8b] Merge remote-tracking branch 'nfc-next/master'
git bisect bad a2ebc71cf97bed9b453318418e4a281434565e8b
# good: [6fde463b32bf4105c28c0a297a5b66aca5d6ecd4] Merge remote-tracking branch 's390/features'
git bisect good 6fde463b32bf4105c28c0a297a5b66aca5d6ecd4
# bad: [136fd6d530a3ae0dd003984f683345cfe88c01f3] Merge remote-tracking branch 'v4l-dvb/master'
git bisect bad 136fd6d530a3ae0dd003984f683345cfe88c01f3
# good: [c7ae95368af43c08f5f615b00f2f7bf2e9c45788] Merge remote-tracking branch 'v9fs/9p-next'
git bisect good c7ae95368af43c08f5f615b00f2f7bf2e9c45788
# good: [4c640c41381e47b328c6507bcf534812761256cd] Merge branch 'for-4.19/fixes' into for-next
git bisect good 4c640c41381e47b328c6507bcf534812761256cd
# good: [5bc91f70c5ecc2bc5967b98ce7fa4e55ad230d99] Merge remote-tracking branch 'hid/for-next'
git bisect good 5bc91f70c5ecc2bc5967b98ce7fa4e55ad230d99
# bad: [657b9d37406ed1625d469db0fd356e364dc75dd8] Merge remote-tracking branch 'hwmon-staging/hwmon-next'
git bisect bad 657b9d37406ed1625d469db0fd356e364dc75dd8
# bad: [fc9f90ddace238716cfcbd00d51428ee8baa12c7] Merge branch 'i2c/for-current' into i2c/for-next
git bisect bad fc9f90ddace238716cfcbd00d51428ee8baa12c7
# good: [34b7be301d4c5d85d1d093d2faf856f3d727416f] Merge branch 'i2c/for-current' into i2c/for-next
git bisect good 34b7be301d4c5d85d1d093d2faf856f3d727416f
# bad: [3e9efc3299dd78a0fa96515f0a453fab1ed4a1bd] i2c: aspeed: Handle master/slave combined irq events properly
git bisect bad 3e9efc3299dd78a0fa96515f0a453fab1ed4a1bd
# good: [fc66b39fe36acfd06f716e338de7cd8f9550fad2] i2c: mediatek: Use DMA safe buffers for i2c transactions
git bisect good fc66b39fe36acfd06f716e338de7cd8f9550fad2
# first bad commit: [3e9efc3299dd78a0fa96515f0a453fab1ed4a1bd] i2c: aspeed: Handle master/slave combined irq events properly
