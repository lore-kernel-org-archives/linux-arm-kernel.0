From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Feb 2013 17:14:10 +0000
Subject: [PATCH 0/4] Convert highbank to use PSCI calls
In-Reply-To: <512E0F79.6080301@gmail.com>
References: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
 <201302270858.20864.arnd@arndb.de> <512E0F79.6080301@gmail.com>
Message-ID: <20130227171410.GC22286@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 01:51:53PM +0000, Rob Herring wrote:
> On 02/27/2013 02:58 AM, Arnd Bergmann wrote:
> >> This series converts highbank to use PSCI calls for secondary core boot,
> >> hotplug, cpuidle, suspend/resume, reset, and poweroff. Doing this removes
> >> about 200 lines of platform code (1/3 of it) and abstracts out the A9 and
> >> A15 differences (some of which are not yet in place).
> > 
> > This looks pretty cool. Can you or Will comment on what is still left
> > for the SMP ops that is actually required as platform specific code?
> > 
> > Specifically, I'm wondering if we could have a set of default smp_ops
> > based on this that we could use with the default machine descriptor [1]
> > and any platform that has SMP enabled but a NULL smp_ops pointer.
> 
> My smp code is exactly the same as mach-virt with this, but adds cpu_die
> for hotplug. smp_secondary_init will go away with Catalin's series to
> use notifiers for the gic secondary init. This leaves smp_boot_secondary.
> 
> We could move these remaining smp_ops to psci.c and create psci_smp_ops.
> That probably needs to be after the gic notifier changes.
> 
> Your patch, psci smp ops, and converting the arch timers to use
> OF_CLKSRC_DECLARE will eliminate mach-virt unless Will has more things
> planned for it.

As long as we remain compatible with "linux,dummy-virt" then I'm not fussed
what happens to the support code. I don't envisage adding anything else to
it that can't live under drivers/ (e.g. new virtio devices).

Will
