From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 20 Jun 2012 14:40:00 +0800
Subject: [RFC PATCH 1/1] ARM: imx: enable SPARSE_IRQ for imx
In-Reply-To: <20120620054015.GB1568@S2100-06.ap.freescale.net>
References: <20120619130145.GD10387@shlinux2.ap.freescale.net>
 <1340111993-6676-1-git-send-email-b29396@freescale.com>
 <20120619140613.GH21951@S2101-09.ap.freescale.net>
 <20120620022313.GE10387@shlinux2.ap.freescale.net>
 <20120620054015.GB1568@S2100-06.ap.freescale.net>
Message-ID: <20120620063959.GH10387@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 01:40:17PM +0800, Shawn Guo wrote:
> On Wed, Jun 20, 2012 at 10:23:15AM +0800, Dong Aisheng wrote:
> > I did see what you said, but you did not go with reasons and that was not so
> > convinced to me
> > Can you explain more why you choose linux virt irq and how about the real exist
> > potential issues i raised before?
> > 
> It's not my choice.  Instead, this is how struct resource defined in
> Linux.  What more reasons do you need to understand that?
> 
It's not about how struct resource defined.
It's about why you directly define linux irq for device rather than
using standard api irq_find_mapping to get the correct linux virt irq
for device after using irqdomain.

> I do not take the thing you raised as issues, because in the end all
> these static definitions will be removed after we move over to device
> tree.
So you agree they're issues for non-dt?
IMHO moving to dt is not an excuse to do wrong things for non-dt.

> 
> > Hmm, it's not driver code.
> > And i did see a lot of such code in mach-specific file.
> 
> That does not mean you are encouraged to add more.  We are trying to
> remove them.
> 
> > If wrong, any other better way to distinguish the different SoCs?
> > 
> There are certainly better way, since we have soc specific
> initialization to do all the soc specific setup.  That said, we do
> not have to necessarily use all those ugly cpu_is_xxx and #ifdef.
> 
I did not see your point, for soc specific setup, it definitely does not have
such issue. The issue happens in a common function shared by many SoCs.
And without dev_id as used by drivers, how do we do it in machine code
in a better way than cpu_is_xx for non-dt?

> > That is a way, but i would prefer to do it in mach-specific code first
> 
> No.  Do not make imx special on this.  We would like to use resource
> definition in the way how it's defined and how everyone else use it.
> 
> > since i'm not sure if other people will also like that.
> 
> No one (except yourself) likes it.  As I said, we are not supposed to
> manipulate resource definition this way.
> 
Hmm, how can you say NO one?

Looking at my patch, you will see the main difference is i use
irq_find_mapping to get the correct linux irq number not matter
what the type of irqdomain of this irqchip is and how virtual irq
range used,
while you're doing based on the assumption that "i know the irqdomain
type of this chip is legacy and i know how virtual irq range is allocated,
then i konw after irqdomain map the linux virtual irq number
should be x, so i directly define x as the irq number for device without
using irq_find_mapping api",
the later one is obviously non-standard and dangerous.
Why you still think the later one is better?

Regards
Dong Aisheng
