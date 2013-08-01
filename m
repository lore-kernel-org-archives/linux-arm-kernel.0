From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 1 Aug 2013 08:02:56 -0400
Subject: [PATCH v3 05/16] ARM: mvebu: remove device tree parsing for
 cpu nodes
In-Reply-To: <51FA3064.9080502@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492747-13879-6-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <51FA3064.9080502@arm.com>
Message-ID: <20130801120256.GW5882@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sudeep,

On Thu, Aug 01, 2013 at 10:54:44AM +0100, Sudeep KarkadaNagesha wrote:
> On 22/07/13 12:32, Sudeep KarkadaNagesha wrote:
> > From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> > 
> > Currently set_secondary_cpus_clock assume the CPU logical ordering
> > and the MPDIR in DT are same, which is incorrect.
> > 
> > Since the CPU device nodes can be retrieved in the logical ordering
> > using the DT helper, we can remove the devices tree parsing.
> > 
> > This patch removes DT parsing by making use of of_get_cpu_node.
> > 
> > Cc: Gregory Clement <gregory.clement@free-electrons.com>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Hi Gregory/Andrew/Jason,
> 
> Does this change look fine for mvebu?
> If yes, can I have your ACKs ?

Gregory is the one best suited to review/Ack this.  He'll be back on
Monday.

thx,

Jason.

> 
> Regards,
> Sudeep
> > ---
> >  arch/arm/mach-mvebu/platsmp.c | 52 ++++++++++++++++++++-----------------------
> >  1 file changed, 24 insertions(+), 28 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
> > index ce81d30..001dd42 100644
> > --- a/arch/arm/mach-mvebu/platsmp.c
> > +++ b/arch/arm/mach-mvebu/platsmp.c
> > @@ -23,51 +23,47 @@
> >  #include <linux/of.h>
> >  #include <linux/mbus.h>
> >  #include <asm/cacheflush.h>
> > +#include <asm/prom.h>
> >  #include <asm/smp_plat.h>
> >  #include "common.h"
> >  #include "armada-370-xp.h"
> >  #include "pmsu.h"
> >  #include "coherency.h"
> >  
> > +static struct clk *__init get_cpu_clk(int cpu)
> > +{
> > +	struct clk *cpu_clk;
> > +	struct device_node *np = of_get_cpu_node(cpu);
> > +
> > +	if (WARN(!np, "missing cpu node\n"))
> > +		return NULL;
> > +	cpu_clk = of_clk_get(np, 0);
> > +	if (WARN_ON(IS_ERR(cpu_clk)))
> > +		return NULL;
> > +	return cpu_clk;
> > +}
> > +
> >  void __init set_secondary_cpus_clock(void)
> >  {
> > -	int thiscpu;
> > +	int thiscpu, cpu;
> >  	unsigned long rate;
> > -	struct clk *cpu_clk = NULL;
> > -	struct device_node *np = NULL;
> > +	struct clk *cpu_clk;
> >  
> >  	thiscpu = smp_processor_id();
> > -	for_each_node_by_type(np, "cpu") {
> > -		int err;
> > -		int cpu;
> > -
> > -		err = of_property_read_u32(np, "reg", &cpu);
> > -		if (WARN_ON(err))
> > -			return;
> > -
> > -		if (cpu == thiscpu) {
> > -			cpu_clk = of_clk_get(np, 0);
> > -			break;
> > -		}
> > -	}
> > -	if (WARN_ON(IS_ERR(cpu_clk)))
> > +	cpu_clk = get_cpu_clk(thiscpu);
> > +	if (!cpu_clk)
> >  		return;
> >  	clk_prepare_enable(cpu_clk);
> >  	rate = clk_get_rate(cpu_clk);
> >  
> >  	/* set all the other CPU clk to the same rate than the boot CPU */
> > -	for_each_node_by_type(np, "cpu") {
> > -		int err;
> > -		int cpu;
> > -
> > -		err = of_property_read_u32(np, "reg", &cpu);
> > -		if (WARN_ON(err))
> > +	for_each_possible_cpu(cpu) {
> > +		if (cpu == thiscpu)
> > +			continue;
> > +		cpu_clk = get_cpu_clk(cpu);
> > +		if (!cpu_clk)
> >  			return;
> > -
> > -		if (cpu != thiscpu) {
> > -			cpu_clk = of_clk_get(np, 0);
> > -			clk_set_rate(cpu_clk, rate);
> > -		}
> > +		clk_set_rate(cpu_clk, rate);
> >  	}
> >  }
> >  
> > 
> 
> 
