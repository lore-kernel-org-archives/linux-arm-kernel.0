From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 7 Jul 2015 15:38:14 +0800
Subject: [PATCH 0/2] arm: berlin: add cpu hotplug support
In-Reply-To: <559B7FA2.4080005@gmail.com>
References: <1436253035-371-1-git-send-email-jszhang@marvell.com>
 <559B7FA2.4080005@gmail.com>
Message-ID: <20150707153814.72a8ec8f@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian,

On Tue, 07 Jul 2015 09:28:34 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 07/07/2015 09:10 AM, Jisheng Zhang wrote:
> > These patches try to add cpu hotplug support for Marvell BG2, BG2Q SoCs.
> > These SoCs can't power off cpu independently, but we still want cpu hotplug
> > support for them. However, we need to address "CPU still sat on kernel text"
> > as pointed out by Mark Rutland[1]. We achieved this by putting the dying CPU
> > in WFI state after the coherency is disabled, then asserting the dying CPU
> > reset bit to put the CPU in reset state.
> 
> Jisheng,
> 
> thanks for the patches! Out of curiosity, did you measure overall SoC 
> power consumption with WFI and with reset respectively? I'd expect a
> slightly _higher_ power consumption while in reset depending on clock
> gating applied to the processor hardware.

Thank you for your review.
You are right. The cpu in reset state consumes a bit higher power than in WFI.
But seems we have no choice for BG2\BG2Q.

For newer Berlin SoCs than BG2Q, we support cpu power off and we'll walk through
the PSCI code path.

Thanks,
Jisheng

> 
> Sebastian
> 
> > patch1 use non-self-cleared control register to reset cpu. This is to prepare
> > for the next cpu hotplug commit.
> >
> > patch2 adds the cpu hotplug support finally.
> >
> >
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/342642.html
> >
> > Jisheng Zhang (2):
> >    arm: berlin: use non-self-cleared reset register to reset cpu
> >    arm: berlin: add CPU hotplug support
> >
> >   arch/arm/mach-berlin/platsmp.c | 29 ++++++++++++++++++++++++++++-
> >   1 file changed, 28 insertions(+), 1 deletion(-)
> >
