From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Jun 2018 10:42:43 +0100
Subject: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
In-Reply-To: <E1fOhn6-00008E-3b@rmk-PC.armlinux.org.uk>
References: <E1fOhn6-00008E-3b@rmk-PC.armlinux.org.uk>
Message-ID: <20180604094241.GE9482@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Jun 01, 2018 at 12:00:16PM +0100, Russell King wrote:
> Executing loops such as:
> 
> 	while (1)
> 		cpu_relax();
>
> with interrupts disabled results in a livelock of the entire system,
> as other CPUs are prevented making progress.  This is most noticable
> as a failure of crashdump kexec, which stops just after issuing:
> 
> 	Loading crashdump kernel...
> 
> to the system console.  Two other locations of these loops within the
> ARM code have been identified and fixed up.

Can you confirm that this only happens if CONFIG_ARM_ERRATA_754327=y?
The only erratum I can find for A9 that matches this behaviour exists
when the body of the tight loop contains a DMB and some of the possible
workarounds are:

  - Add ten NOPs after the DMB
  - Use DSB instead of DMB in the tight loop
  - Set bit 16 in the diagnostic control register (p15, c1, 5, 0, c0, 1)

WFE is probably fine (the write-up isn't clear), but if this only occurs
due to CONFIG_ARM_ERRATA_754327=y it would be nice to mitigate it in the
alternative cpu_relax() definition itself, which isn't generally possible
with WFE.

Will
