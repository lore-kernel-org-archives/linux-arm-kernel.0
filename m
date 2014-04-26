From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Apr 2014 16:33:01 -0400
Subject: [PATCH v2 22/38] ARM: orion: switch to a per-platform
 handle_irq() function
In-Reply-To: <535BD3F1.8000706@gmail.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-23-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140426145457.GV28159@titan.lakedaemon.net> <535BD3F1.8000706@gmail.com>
Message-ID: <B3DF11DE-D10F-41EB-BE40-2C26DA3BF719@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On Apr 26, 2014, at 11:42 AM, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
> 
>> On 04/26/2014 04:54 PM, Jason Cooper wrote:
>>> On Tue, Apr 22, 2014 at 11:26:26PM +0200, Thomas Petazzoni wrote:
>>> Moving to the Device Tree implies having CONFIG_MULTI_IRQ_HANDLER
>>> enabled, even for non-DT platforms (if we want both DT and non-DT
>>> platforms to be supported in a single kernel).
>>> 
>>> However, the common CONFIG_MULTI_IRQ_HANDLER handler for non-DT
>>> platforms in plat-orion/irq.c doesn't match the needs of
>>> Orion5x. Also, it doesn't make much sense for orion_irq_init() to
>>> register the multi-IRQ handler: orion_irq_init() is called once for
>>> each IRQ cause/mask tuple, while the multi-IRQ handler only needs to
>>> be registered once.
>>> 
>>> To solve this problem, we move the multi-IRQ handle in per-platform
>>> code: mach-kirkwood/irq.c and mach-dove/irq.c. The Orion5x variant
>>> will be introduced in a followup commit. Of course, this code will
>>> ultimately be completely removed once all boards are converted to the
>>> Device Tree.
>>> 
>>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>> ---
>>> arch/arm/mach-dove/irq.c     | 36 +++++++++++++++++++++++++++++++++++
>>> arch/arm/mach-kirkwood/irq.c | 36 +++++++++++++++++++++++++++++++++++
>>> arch/arm/plat-orion/irq.c    | 45 --------------------------------------------
>>> 3 files changed, 72 insertions(+), 45 deletions(-)
>> 
>> Dabbit!   So close...  I pulled in 10 - 38 into mvebu/soc-orion5x and it
>> failed to build kirkwood_defconfig:
>> 
>> arch/arm/mach-kirkwood/irq.c:44:23: error: expected ?=?, ?,?, ?;?, ?asm? or ?__attribute__? before ?kirkwood_legacy_handle_irq?
>> arch/arm/mach-kirkwood/irq.c: In function ?kirkwood_init_irq?:
>> arch/arm/mach-kirkwood/irq.c:71:17: error:
>> ?kirkwood_legacy_handle_irq? undeclared (first use in this function)
>> arch/arm/mach-kirkwood/irq.c:71:17: note: each undeclared
>> identifier is reported only once for each function it appears in
>> arch/arm/mach-kirkwood/irq.c: At top level:
>> arch/arm/mach-kirkwood/irq.c:41:22: warning: ?kirkwood_irq_base?
>> defined but not used [-Wunused-variable]
>> make[1]: *** [arch/arm/mach-kirkwood/irq.o] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> arch/arm/kernel/return_address.c:63:2: warning: #warning "TODO:
>> return_address should use unwind tables" [-Wcpp]
>> make: *** [arch/arm/mach-kirkwood] Error 2
>> make: *** Waiting for unfinished jobs....
> 
> Jason,
> 
> adding a missing #include <asm/exception.h> fixes the build issue.
> Can you squash adding it in?
> 

Yep, that fixed it.  Entire gamut of build tests have passed.  So I squashed it into this patch and push the series out to mvebu/soc-orion5x

thx,

Jason.
