From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Mar 2018 16:54:33 +0100
Subject: arm/arm64: smp_spin_table.c for arm32?
In-Reply-To: <OSBPR01MB2054DFD1BEECD87186E29E51D2A30@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2054DFD1BEECD87186E29E51D2A30@OSBPR01MB2054.jpnprd01.prod.outlook.com>
Message-ID: <20180328155432.znx2w2xfa3aflccs@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2018 at 08:12:50AM +0000, Michel Pollet wrote:
> I'm currently adapting a port from a machine-file based approach to driver based, and I
> would have a need for arch/arm64/kernel/smp_spin_table.c -- it's *exactly* my use
> case, but for arm32.
> So what would be my options here?
> 
> 1) Make myself a custom driver and ignore this one...
> 2) Fully duplicate smp_spin_table.c in arch/arm/kernel...
> 3) .... something else involving a shared bit of code?

There will be some small differences between the two like writeq() vs
writel(). My advice:

4) Use PSCI, already available in arch/arm/kernel/psci_smp.c

Otherwise, if you do need a spin table, duplicating is probably the
easiest, especially since you need a .S counterpart, but you'd need to
keep the arch/arm/mach-* directory. Also see this thread (and maybe
others):

https://lkml.org/lkml/2014/3/28/458

As long as booting is not standardised for your SoC, I don't think you'd
be able to move everything into drivers/.

On arm64, we only keep the pen release mechanism for XGene as they don't
have EL3 and cannot implement PSCI. All other platforms use PSCI (at
least those supported upstream).

-- 
Catalin
