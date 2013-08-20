From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Aug 2013 17:28:25 -0600
Subject: [GIT PULL 2/4] ARM: tegra: core SoC enhancements for 3.12
In-Reply-To: <87mwocj680.fsf@kernel.org>
References: <1376673628-5867-1-git-send-email-swarren@wwwdotorg.org>
 <1376673628-5867-2-git-send-email-swarren@wwwdotorg.org>
 <87mwocj680.fsf@kernel.org>
Message-ID: <5213FB99.5030903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2013 05:24 PM, Kevin Hilman wrote:
> + Mike Turquette
> 
> Stephen Warren <swarren@wwwdotorg.org> writes:
> 
>> This branch includes a number of enhancements to core SoC support for
>> Tegra devices. The major new features are:
>>
>> * Adds a new CPU-power-gated cpuidle state for Tegra114.
>> * Adds initial system suspend support for Tegra114, initially supporting
>>   just CPU-power-gating during suspend.
>> * Adds "LP1" suspend mode support for all of Tegra20/30/114. This mode
>>   both gates CPU power, and places the DRAM into self-refresh mode.
>> * A new DT-driven PCIe driver to Tegra20/30. The driver is also moved
>>   from arch/arm/mach-tegra/ to drivers/pci/host/.
>>
>> The PCIe driver work depends on the following tag from Thomas Petazzoni:
>> git://git.infradead.org/linux-mvebu.git mis-3.12.2
>> ... which is merged into the middle of this pull request.
>>
>> ----------------------------------------------------------------
>>
>> (If the location of the merge into this branch is problematic, just let
>> me know and I'll rebase everything on top of the merge)
> 
> The merge looks fine, but...
> 
>> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
>>
>>   Linux 3.11-rc1
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.12-soc
>>
>> for you to fetch changes up to b4f173752a56187bd55752b0474429202f2ab1d3:
>>
>>   ARM: tegra: disable LP2 cpuidle state if PCIe is enabled
>>
>> ----------------------------------------------------------------
>>
>> Jay Agarwal (1):
>>       PCI: tegra: Add Tegra 30 PCIe support
>>
>> Joseph Lo (21):
>>       ARM: tegra: enable Cortex-A15 erratum 798181
>>       Revert "ARM: tegra: add cpu_disable for hotplug"
>>       ARM: tegra114: Reprogram GIC CPU interface to bypass IRQ on CPU PM entry
>>       ARM: tegra114: add low level support for CPU idle powered-down mode
>>       ARM: tegra114: cpuidle: add powered-down state
>>       ARM: tegra: do v7_invalidate_l1 only when CPU is Cortex-A9
>>       ARM: tegra: add a flag for tegra_disable_clean_inv_dcache to do LoUIS or ALL
>>       ARM: tegra: set up the correct L2 data RAM latency for Cortex-A15
>>       ARM: tegra: add low level code for Tegra114 cluster power down
>>       ARM: tegra: shut off the CPU rail when the last CPU in suspend
>>       ARM: tegra: hook tegra_tear_down_cpu function
>>       ARM: tegra: flowctrl: add support for cpu_suspend_enter/exit
>>       clk: tegra: add suspend/resume function for tegra_cpu_car_ops
> 
> This one...
> 
>>       ARM: tegra: remove the limitation that Tegra114 can't support suspend
>>       ARM: tegra: add common resume handling code for LP1 resuming
>>       ARM: tegra: config the polarity of the request of sys clock
>>       clk: tegra114: add LP1 suspend/resume support
> 
> ...and this one are drivers/clk and I don't see an ack from the
> clock framework maintainer (Mike Turquette) on either.
> 
> If Mike is OK for them to go via arm-soc, that should be specified in
> the description above (and he should ack them), otherwise they should be
> split out and sent via Mike.
> 
> A quick glance suggests there are no direct dependencies, so it's
> probably best if those changes go through Mike.

There are at least run-time dependencies here, although it's possible
they're limited to "suspend won't work on Tegra114 unless all those
patches are present" rather than "if all these patches aren't present,
something other than a new feature will regress due to this series".

Mike's certainly been CC'd on the patches many times as quite a few
versions of each were posted, and I asked for acks, but got no response.
In the past, that's meant he's fine with the patches...
