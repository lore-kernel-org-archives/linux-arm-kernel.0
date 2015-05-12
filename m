From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 May 2015 16:23:32 +0100
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <55520F0F.5010906@free.fr>
References: <55520F0F.5010906@free.fr>
Message-ID: <20150512152332.GO2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 04:32:47PM +0200, Mason wrote:
> Hello,
> 
> I'm working on a Cortex A9 based platform.
> 
> I have a basic clock tree, and a very basic cpufreq driver using
> mostly generic driver glue:
> 
> static struct cpufreq_driver tangox_cpufreq_driver = {
> 	.name		= "tangox-cpufreq",
> 	.init		= tangox_cpu_init,
> 	.verify		= cpufreq_generic_frequency_table_verify,
> 	.target_index	= tangox_target,
> 	.get		= cpufreq_generic_get,
> 	.exit		= cpufreq_generic_exit,
> 	.attr		= cpufreq_generic_attr,
> };
> 
> My target_index function is trivial:
> 
> static int tangox_target(struct cpufreq_policy *policy, unsigned int idx)
> {
> 	return clk_set_rate(policy->clk, freq_table[idx].frequency * 1000);
> }
> 
> I was testing an unrelated driver at low frequencies, with the nominal
> frequency (999 MHz) divided by 54 (i.e. freq = 18.5 MHz) and I noticed
> that when the driver calls
> 
>     schedule_timeout(HZ);
> 
> the thread sleeps 54 seconds instead of 1.

I'm guessing that this will be because your local timer changes frequency
with the CPU, which means that the clockevent which was set for one second
ends up timing out after 54 seconds.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
