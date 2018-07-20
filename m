From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 20 Jul 2018 16:09:43 +0100
Subject: [PATCH v4 00/26] arm64: provide pseudo NMI with GICv3
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Message-ID: <20180720150943.i4u2s7wie7falh7p@holly.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 10:49:06AM +0100, Julien Thierry wrote:
> This series is a continuation of the work started by Daniel [1]. The goal
> is to use GICv3 interrupt priorities to simulate an NMI.
> 
> To achieve this, set two priorities, one for standard interrupts and
> another, higher priority, for NMIs. Whenever we want to disable interrupts,
> we mask the standard priority instead so NMIs can still be raised. Some
> corner cases though still require to actually mask all interrupts
> effectively disabling the NMI.
> 
> Currently, only PPIs and SPIs can be set as NMIs. IPIs being currently
> hardcoded IRQ numbers, there isn't a generic interface to set SGIs as NMI
> for now. I don't think there is any reason LPIs should be allowed to be set
> as NMI as they do not have an active state.
> When an NMI is active on a CPU, no other NMI can be triggered on the CPU.
> 
> After the big refactoring I get performances similar to the ones I had
> in v3[2], reposting old results here:
> 
> - "hackbench 200 process 1000" (average over 20 runs)
> +-----------+----------+------------+------------------+
> |           | native   | PMR guest  | v4.17-rc6 guest  |
> +-----------+----------+------------+------------------+
> | PMR host  | 40.0336s |   39.3039s |         39.2044s |
> | v4.17-rc6 | 40.4040s |   39.6011s |         39.1147s |
> +-----------+----------+------------+------------------+
> 
> - Kernel build from defconfig:
> PMR host:  13m45.743s
> v4.17-rc6: 13m40.400s
> 
> I'll try to post more detailed benchmarks later if I find notable
> differences with the previous version.

So... I'm rather late sharing these benchmarks but...

I ran some kernel build benchmarks on the Developerbox from 96Boards
(aka Synquacer E-series by Socionext): 24 C-A53 cores running at 1GHz.
This is obviously a real workload and one that anything called
Developerbox needs to care about!

The difference in performance is slight but PMR based locking is
marginally slower than using the I-bit. It varies with the
parrallel-ness of the build slightly but the slowdown on this platform
is between 0.2% and 0.6% [1].

This delta was sufficiently small that I was willing to leave the PMR
masking in place for a fair amount of my day to day work. On that basis
these patches could also be described as:

Tested-by: Daniel Thompson <daniel.thompson@linaro.org> 


Daniel.


[1] For anyone interested in the raw numbers then the spreadsheet where
    I checked the results is here:
https://docs.google.com/spreadsheets/d/1gGxAJd_gL-HjeTF-x0Ut5lWT4JULNRDeTbPvPInZ4H4/edit?usp=sharing
