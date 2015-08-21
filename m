From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Aug 2015 14:46:30 +0100
Subject: [PATCH 0/4] Efficiency cleanups
In-Reply-To: <20150821133043.GV7557@n2100.arm.linux.org.uk>
References: <CABXk95C=CpeL4mNmS6-jJ-0bMJf6fawwfs6DM1-p8FctTEFbpw@mail.gmail.com>
 <20150821133043.GV7557@n2100.arm.linux.org.uk>
Message-ID: <20150821134630.GW7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While developing the previous patch set, I noticed that the kernel's
"fast" exit path efficiency was not what it's supposed to be due to the
addition of trace and context tracking.

These add several instances of register stacking and unstacking around
various function calls, several of which we can avoid.  Many of these
instances don't need to stack any register other than r0.

Moreover, we can avoid stacking and unstacking r0 if these features are
enabled by storing r0 in the pt_regs as we would do in our slow return
path.

Various other cleanups are included in this set as well.  Acks welcome.

 arch/arm/include/asm/assembler.h   | 22 ++++++++------
 arch/arm/include/asm/thread_info.h | 20 +++++--------
 arch/arm/include/asm/uaccess.h     | 47 ++++++++---------------------
 arch/arm/kernel/entry-common.S     | 61 ++++++++++++++++++++++++++++----------
 arch/arm/kernel/signal.c           |  6 ++++
 5 files changed, 84 insertions(+), 72 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
