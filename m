From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 11 Jul 2018 15:01:20 +0930
Subject: [RFC PATCH v2 2/4] Documentation: ABI: Add
 sysfs-devices-platform-field to testing
In-Reply-To: <20180711053122.30773-1-andrew@aj.id.au>
References: <20180711053122.30773-1-andrew@aj.id.au>
Message-ID: <20180711053122.30773-3-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Fields" expose control of hardware directly to userspace where
appropriate. Examples of expected use are single bit switches or other
small masks of registers where the range of values is entirely policy
driven and the field is not part of a larger, coherent design.

These fields can be from read-only, read-write or
write-1-set/write-1-clear register sets.

Using fields to control the behaviour of hardware local to the kernel
exposing them is likely incorrect. The use-case motivating the fields
feature is for Baseboard Management Controllers (BMCs) to expose policy
controls for booting and running their host systems.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---

Since RFC v1:

* Describe a 'type' attribute that determines the behaviour of the remaining
  attributes
* Rework paths to point through /sys/devices/platform
* Add a description to the commit message

 .../ABI/testing/sysfs-devices-platform-field  | 95 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-field

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-field b/Documentation/ABI/testing/sysfs-devices-platform-field
new file mode 100644
index 000000000000..216481d8bc99
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-field
@@ -0,0 +1,95 @@
+This document defines the sysfs attributes provided by the bmc-misc-ctrl
+driver. See Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt for
+exhaustive list of field definitions.
+
+What:		/sys/devices/platform/.../<field>/<label>/label
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc at lists.ozlabs.org
+Description:
+		An RO attribute providing the name of the field of interest.
+		Corresponds to the value of <label> in the path
+Users:		openbmc at lists.ozlabs.org
+
+What:		/sys/devices/platform/.../<field>/<label>/type
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc at lists.ozlabs.org
+Description:
+		An RO attribute describing the type of the field. The type
+		takes one of three values:
+
+		'ro':	The field is read-only. The 'value' attribute will be
+			read-only and neither 'set' nor 'clear' attributes will
+			be present.
+		'rw':	The field is read-write. The 'value' attribute will be
+			both readable and writable and neither 'set' nor
+			'clear' attributes will be present. Values written to
+			the 'value' attribute will be atomically updated.
+		'w1sc':	The field uses write-1-{set,clear} semantics. The
+			'value' attribute will be read-only, and both 'set' and
+			'clear' attributes will be present to manipulate
+			'value'. 'set' and 'clear' will both be write-only.
+Users:		openbmc at lists.ozlabs.org
+
+What:		/sys/devices/platform/.../<field>/<label>/mask
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc at lists.ozlabs.org
+Description:
+		An RO attribute providing the mask applied to the value
+		read/written from the 'value' attribute.
+Users:		openbmc at lists.ozlabs.org
+
+What:		/sys/devices/platform/.../<field>/<label>/value
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc at lists.ozlabs.org
+Description:
+		The value of the field of interest.
+
+		If the field is exposed from a read-modify-write register this
+		attribute will be RW, where writes will set the field to the
+		value written. Writing values that exceed the width of the
+		field will return an error.
+
+		If the field is exposed from a write-1-set/write-1-clear
+		register this attribute will be RO, and the attributes 'set'
+		and 'clear' will be present as write-only.
+Users:		openbmc at lists.ozlabs.org
+
+What:		/sys/devices/platform/.../<field>/<label>/set
+Users:		openbmc at lists.ozlabs.org
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc at lists.ozlabs.org
+Description:
+		A WO attribute that when written will set bits in the backing
+		register corresponding to set bits in the value written.
+		Register bits corresponding to cleared bits in the written
+		value will remain unchanged.
+
+		This attribute is exposed when the field is identified as being
+		composed of write-1-set and write-1-clear registers.
+
+		Writing values that exceed the width of the mask value will
+		return an error.
+Users:		openbmc at lists.ozlabs.org
+
+What:		/sys/devices/platform/.../<field>/<label>/clear
+Users:		openbmc at lists.ozlabs.org
+Date:		July, 2018
+KernelVersion:	v4.19
+Contact:	openbmc at lists.ozlabs.org
+Description:
+		A WO attribute that when written will clear bits in the backing
+		register corresponding to set bits in the value written.
+		Register bits corresponding to cleared bits in the written
+		value will remain unchanged.
+
+		This attribute is exposed when the field is identified as being
+		composed of write-1-set and write-1-clear registers.
+
+		Writing values that exceed the width of the mask value will
+		return an error.
+Users:		openbmc at lists.ozlabs.org
diff --git a/MAINTAINERS b/MAINTAINERS
index fa2033a522f2..d167f0340c11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2741,6 +2741,7 @@ R:	Andrew Jeffery <andrew@aj.id.au>
 L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/misc/bmc-misc-ctrl.txt
+F:	Documentation/ABI/testing/sysfs-devices-platform-field
 
 BPF (Safe dynamic programs and tools)
 M:	Alexei Starovoitov <ast@kernel.org>
-- 
2.17.1
