From: xiexiuqi@huawei.com (Xie XiuQi)
Date: Thu, 30 Mar 2017 18:31:00 +0800
Subject: [PATCH v3 0/8] arm64: acpi: apei: handle SEI notification type for
 ARMv8
Message-ID: <1490869877-118713-1-git-send-email-xiexiuqi@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM APEI extension proposal added SEI (asynchronous SError interrupt)
notification type for ARMv8.

Add a new GHES error source handling function for SEI. In firmware
first mode, if an error source's notification type is SEI. Then GHES
could parse and report the detail error information.

In firmware first mode, we could assume:
1) The ghes for sei is a global table, firmware should report one sei at a time.
2) SEI is masked while exception is processing
3) SEI may interrupt while irq handler is running 
4) SEA may interrupt while SEI handler is running

So, the memory area used to transfer hardware error information from
BIOS to Linux can be determined only in NMI, SEI(arm64), IRQ or timer
handler. We add a virtual page for SEI context.

Error Synchronization Barrier (ESB; part of the ARMv8.2 Extensions)
is used to synchronize Unrecoverable errors. That is, containable errors
architecturally consumed by the PE and not silently propagated.

With ESB it is generally possible to isolate an unrecoverable error
between two ESB instructions. So, it's possible to recovery from
unrecoverable errors reported by asynchronous SError interrupt.

Since SEI is asynchronous, a SEI generated on user process may propagate
to another user process via shared memory, which may cause unrecoverable.
We have a idea which only recover sei from user process which has no
writable shared memory.

The idea is still in the discussion, any comments is welcome.

This series is based on Tyler's series "[PATCH V13 00/10] Add UEFI 2.6 and ACPI 6.1 updates
for RAS on ARM64" and the latest mainline.

v3: add ARM processor error information trace event
    add a per-cpu variable to indecate sei is processing
    remove nmi_{enter/exit} protection for ghes_notify_sei()
    reserve a virtual page for processing ghes table in SEI context
    don't always inject vabt for sei
    serprate do_sei from bad_mode
    add esb which make recovery from sei possible
    add an idea to recovery from sei for shared memory process

v2: add kvm guest SEI notification support
    add nmi_{entry, exit} to protect ghes_notify_sei

https://lkml.org/lkml/2017/3/7/962
https://lkml.org/lkml/2017/3/3/189

Wang Xiongfeng (1):
  arm64: exception: check shared writable page in SEI handler

Xie XiuQi (7):
  trace: ras: add ARM processor error information trace event
  acpi: apei: handle SEI notification type for ARMv8
  arm64: apei: add a per-cpu variable to indecate sei is processing
  APEI: GHES: reserve a virtual page for SEI context
  arm64: KVM: add guest SEI support
  arm64: RAS: add ras extension runtime detection
  arm64: exception: handle asynchronous SError interrupt

 arch/arm64/Kconfig                   |  16 +++
 arch/arm64/include/asm/cpucaps.h     |   3 +-
 arch/arm64/include/asm/esr.h         |  14 +++
 arch/arm64/include/asm/sysreg.h      |   2 +
 arch/arm64/include/asm/system_misc.h |   1 +
 arch/arm64/kernel/cpufeature.c       |  11 ++
 arch/arm64/kernel/entry.S            |  70 ++++++++++-
 arch/arm64/kernel/traps.c            | 217 +++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/handle_exit.c         |  22 +++-
 drivers/acpi/apei/Kconfig            |  14 +++
 drivers/acpi/apei/ghes.c             | 166 +++++++++++++++++++--------
 include/acpi/ghes.h                  |   3 +
 include/linux/cper.h                 |   5 +
 include/ras/ras_event.h              |  87 ++++++++++++++
 14 files changed, 575 insertions(+), 56 deletions(-)

-- 
1.8.3.1
