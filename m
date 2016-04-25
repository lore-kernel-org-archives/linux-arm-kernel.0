From: ahs3@redhat.com (Al Stone)
Date: Mon, 25 Apr 2016 16:35:04 -0600
Subject: [RFC] Is /dev/port useful on arm64?
Message-ID: <571E9B98.4050505@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In examining a bug report where lm_sensors fails on arm64 (and panics the
kernel, which is kind of annoying), it turns out it is trying to read
information from an ISA port using the /dev/port device.

It's easy enough to disable this; you can:

   -- set CONFIG_DEVPORT=n for arm64 (in arch/arm64/Kconfig)

   -- or, redefine the macro arch_has_dev_port() to:

	#define arch_has_dev_port()	(0)

      in arch/arm64/include/asm/io.h

However, /dev/port is used for both ISA and PCI IO ports.  So, this led me
to what may be a dumb question: is there really a need for PCI support in
/dev/port for arm64?

Supporting ISA just seems silly, at least from an ARMv8 server standpoint,
but PCI is less clear to me.  Anyone have opinions one way or the other?

It seems like it would be a waste of time to do the work to make sure the
PCI ports work correctly only to find out they will never be used, but I
can't think of anyone that actually needs them.

Thanks.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
