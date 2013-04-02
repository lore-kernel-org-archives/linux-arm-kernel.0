From: olof@lixom.net (Olof Johansson)
Date: Tue, 2 Apr 2013 15:11:43 -0700
Subject: [GIT PULL] Preparatory GIC patches for arm64 support
In-Reply-To: <20130402180339.GJ25867@quad.lixom.net>
References: <20130328140239.GF24039@arm.com>
 <20130402180339.GJ25867@quad.lixom.net>
Message-ID: <CAOesGMhoaXqCOYLu0mYbcRtcwch0Lr4FKi+14vudWw0BU+Gciw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 2, 2013 at 11:03 AM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Mar 28, 2013 at 02:02:39PM +0000, Catalin Marinas wrote:
>> Hi,
>>
>> As I'm about to go on holiday for two weeks and I haven't heard any
>> preference for who should be merging these patches, I'm sending the pull
>> request to arm-soc given that 90% of the changes target SoC code. Apart
>> from the gic_secondary_init() patch, the rest is trivial header code
>> moving around or removal.
>>
>> Russell, if you have any objections, please let arm-soc guys and me know
>> and feel free to pull these patches via your tree. I don't mind either
>> way.
>>
>> Thanks,
>>
>> Catalin
>>
>>
>> The following changes since commit a937536b868b8369b98967929045f1df54234323:
>>
>>   Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git gic
>
>
> Pulled as gic/cleanup into next/cleanup.
>
> I got a handful of context conflicts due to additions near the old
> secondary_init functions, and one add/add conflict on includes. All trivial to
> resolve.

Tsk. When you removed <asm/mach/irq.h> from irq-vic.c, the implicit
include of linux/irq.h fell out. Clearly you didn't build test this
across arm defconfigs. :P

I've added the following fix on top of the branch you staged:

---


irqchip: vic: add include of linux/irq.h

With the include of <asm/mach/irq.h> removed, the implicit include of
linux/irq.h also disappeared. Add it back.

Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index e38cb00..884d11c 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_address.h>



-Olof
