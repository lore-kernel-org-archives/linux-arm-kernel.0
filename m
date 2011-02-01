From: ecc@cmu.edu (Eric Cooper)
Date: Tue, 1 Feb 2011 16:50:59 -0500
Subject: advice needed on how best to fix kirkwood kexec
Message-ID: <20110201215059.GC7547@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I found the problem with kexec'ing kirkwood kernels:

During late initialization, the kirkwood_clock_gate function powers
down unused units, including the PCIe.  But the early initialization
(kirkwood_timer_init) relies on reading the device ID register, which
is in the PCIe space, so it will hang when started by kexec.

My question is, should I patch the kexec code or the initialization code?

Patching the kexec code is much more useful, because it allows
kexec'ing the existing kirkwood kernels that are already "out there",
in distros, etc.  But it requires a kirkwood-specific operation in the
otherwise generic machine_kexec().

Patching just the kirkwood initialization is better from an
"information hiding" perspective, but won't provide any benefit until
it makes its way into the kernels that people might want to kexec.

-- 
Eric Cooper             e c c @ c m u . e d u
