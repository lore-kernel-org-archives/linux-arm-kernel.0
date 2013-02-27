From: robherring2@gmail.com (Rob Herring)
Date: Wed, 27 Feb 2013 07:51:53 -0600
Subject: [PATCH 0/4] Convert highbank to use PSCI calls
In-Reply-To: <201302270858.20864.arnd@arndb.de>
References: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
 <201302270858.20864.arnd@arndb.de>
Message-ID: <512E0F79.6080301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2013 02:58 AM, Arnd Bergmann wrote:
> On Wednesday 27 February 2013, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This series converts highbank to use PSCI calls for secondary core boot,
>> hotplug, cpuidle, suspend/resume, reset, and poweroff. Doing this removes
>> about 200 lines of platform code (1/3 of it) and abstracts out the A9 and
>> A15 differences (some of which are not yet in place).
> 
> Hi Rob,
> 
> This looks pretty cool. Can you or Will comment on what is still left
> for the SMP ops that is actually required as platform specific code?
> 
> Specifically, I'm wondering if we could have a set of default smp_ops
> based on this that we could use with the default machine descriptor [1]
> and any platform that has SMP enabled but a NULL smp_ops pointer.

My smp code is exactly the same as mach-virt with this, but adds cpu_die
for hotplug. smp_secondary_init will go away with Catalin's series to
use notifiers for the gic secondary init. This leaves smp_boot_secondary.

We could move these remaining smp_ops to psci.c and create psci_smp_ops.
That probably needs to be after the gic notifier changes.

Your patch, psci smp ops, and converting the arch timers to use
OF_CLKSRC_DECLARE will eliminate mach-virt unless Will has more things
planned for it.

Rob
