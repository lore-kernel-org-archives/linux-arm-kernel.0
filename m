From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 Aug 2013 18:33:13 +1000
Subject: linux-next: manual merge of the arm-soc tree with the pm tree
Message-ID: <20130827183313.aa7d51c6dd0b21cd8168aa35@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-mvebu/platsmp.c between commit f6cec7cd0777 ("ARM: mvebu:
remove device tree parsing for cpu nodes") from the  tree and commit
994c8c94b419 ("ARM: mvebu: Remove the harcoded BootROM window
allocation") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-mvebu/platsmp.c
index 594b63d,4f960f0..0000000
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@@ -29,28 -30,31 +30,31 @@@
  #include "pmsu.h"
  #include "coherency.h"
  
+ #define AXP_BOOTROM_BASE 0xfff00000
+ #define AXP_BOOTROM_SIZE 0x100000
+ 
 +static struct clk *__init get_cpu_clk(int cpu)
 +{
 +	struct clk *cpu_clk;
 +	struct device_node *np = of_get_cpu_node(cpu, NULL);
 +
 +	if (WARN(!np, "missing cpu node\n"))
 +		return NULL;
 +	cpu_clk = of_clk_get(np, 0);
 +	if (WARN_ON(IS_ERR(cpu_clk)))
 +		return NULL;
 +	return cpu_clk;
 +}
 +
  void __init set_secondary_cpus_clock(void)
  {
 -	int thiscpu;
 +	int thiscpu, cpu;
  	unsigned long rate;
 -	struct clk *cpu_clk = NULL;
 -	struct device_node *np = NULL;
 +	struct clk *cpu_clk;
  
  	thiscpu = smp_processor_id();
 -	for_each_node_by_type(np, "cpu") {
 -		int err;
 -		int cpu;
 -
 -		err = of_property_read_u32(np, "reg", &cpu);
 -		if (WARN_ON(err))
 -			return;
 -
 -		if (cpu == thiscpu) {
 -			cpu_clk = of_clk_get(np, 0);
 -			break;
 -		}
 -	}
 -	if (WARN_ON(IS_ERR(cpu_clk)))
 +	cpu_clk = get_cpu_clk(thiscpu);
 +	if (!cpu_clk)
  		return;
  	clk_prepare_enable(cpu_clk);
  	rate = clk_get_rate(cpu_clk);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130827/fea86084/attachment.sig>
