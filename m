From: christopher.lee.bostic@gmail.com (christopher.lee.bostic at gmail.com)
Date: Thu, 12 Jan 2017 16:34:57 -0600
Subject: [PATCH v2 14/18] drivers/fsi: Add FSI bus documentation
Message-ID: <1484260497-80241-1-git-send-email-christopher.lee.bostic@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Bostic <cbostic@us.ibm.com>

Add details on the basic functions of the FSI serial bus.

Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
---
 Documentation/devicetree/bindings/fsi/fsi.txt | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi.txt

diff --git a/Documentation/devicetree/bindings/fsi/fsi.txt b/Documentation/devicetree/bindings/fsi/fsi.txt
new file mode 100644
index 0000000..7fa2394
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/fsi.txt
@@ -0,0 +1,54 @@
+FSI: Flexible Support processor Interface
+
+FSI is a two line serial bus capable of running at speeds up to 166 MHz.
+The lines consist of a clock responsible for synchronizing the target device
+(slave) with the master which is responsible for all transactions on the bus.
+The master owns the clock line and is the only side allowed to change its
+state. The second line, SDA, is a data line that conveys information to/from
+the slave who samples based on the clock line.  The data line is
+bi-directional.
+
+The master initiates communication by sending a command to the slave and
+depending on the type of command will allow the slave to control the bus
+to return requested data.  All commands are CRC protected.  The slave upon
+receipt of a command will determine if the CRC is correct and discard
+the data if noise has corrupted the line.  In the same manner the master
+will verify the CRC received from the slave.
+
+Types of commands:
+Read 32 bit:  Read a 32 bit word from a specified address on the slave.
+Read 16 bit:  Read a 16 bit 'half word' from a specified address on the slave.
+read 8 bit:   Read a byte from a specified address on the slave.
+Write 32,16,8 bit: Write to a specified address on the slave with the provided
+		data.
+BREAK:		Initialize the slave's logic to receive commands.
+TERM:		Terminate the slave's error lockout to resume communications
+		after an error on the bus is detected.
+D-POLL:		Poll the slave to determine when it is no longer buy processing
+		a previous command.
+I-POLL:		Interrupt signal check.  Master queries slave to see if any
+		interrupts are asserting.
+
+High fanout capability:
+FSI buses can be chained together in 'hub' configurations to expand the
+available communications channels and thus allow connetion to more slaves.
+
+
+Typical implementation
+
+ FSI master ----- slave with local FSI master (hub) ------- downstream slave
+
+
+Each two line combination of a clock and data line is collectively referred
+to as a 'FSI link'.   Depending on hardware the primary FSI master may support
+up to 64 links.  Hub FSI masters can support at most 8 links.  Total number
+of supported slaves can grow exponentially depending on how many hubs are
+placed in the path.  Presently only two hubs in the chain are allowed but
+in the future this may be expanded.
+
+The slave hardware logic responsible for decoding FSI master commands is
+contained in a CFAM (Common Field replaceable unit Access Macro).  Up to
+4 slaves or CFAMs can be connected on each FSI link.  CFAMs in addition
+to the slave logic (or engine) can contain other functions that allow access
+via FSI.  Common additional functionality includes I2C masters, GPIO
+controllers, UARTs, etc...
-- 
1.8.2.2
