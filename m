From: will.deacon@arm.com (Will Deacon)
Date: Tue, 3 May 2016 09:57:59 +0100
Subject: [PATCH] arm64: kvm: Fix kvm teardown for systems using the
 extended idmap
In-Reply-To: <57286432.2000606@arm.com>
References: <1461775633-29715-1-git-send-email-james.morse@arm.com>
 <1461950823-9790-1-git-send-email-james.morse@arm.com>
 <20160502130535.19b20b79@arm.com> <20160503083651.GB17923@cbox>
 <57286432.2000606@arm.com>
Message-ID: <20160503085758.GA2604@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Tue, May 03, 2016 at 09:41:22AM +0100, Marc Zyngier wrote:
> On 03/05/16 09:36, Christoffer Dall wrote:
> > On Mon, May 02, 2016 at 01:05:35PM +0100, Marc Zyngier wrote:
> >> On Fri, 29 Apr 2016 18:27:03 +0100
> >> James Morse <james.morse@arm.com> wrote:
> >>> If memory is located above 1<<VA_BITS, kvm adds an extra level to its page
> >>> tables, merging the runtime tables and boot tables that contain the idmap.
> >>> This lets us avoid the trampoline dance during initialisation.
> >>>
> >>> This also means there is no trampoline page mapped, so
> >>> __cpu_reset_hyp_mode() can't call __kvm_hyp_reset() in this page. The good
> >>> news is the idmap is still mapped, so we don't need the trampoline page.
> >>> The bad news is we can't call it directly as the idmap is above
> >>> HYP_PAGE_OFFSET, so its address is masked by kvm_call_hyp.
> >>>
> >>> Add a function __extended_idmap_trampoline which will branch into
> >>> __kvm_hyp_reset in the idmap, change kvm_hyp_reset_entry() to return
> >>> this address if __kvm_cpu_uses_extended_idmap(). In this case
> >>> __kvm_hyp_reset() will still switch to the boot tables (which are the
> >>> merged tables that were already in use), and branch into the idmap (where
> >>> it already was).
> >>>
> >>> This fixes boot failures on these systems, where we fail to execute the
> >>> missing trampoline page when tearing down kvm in init_subsystems():
> >>> [    2.508922] kvm [1]: 8-bit VMID
> >>> [    2.512057] kvm [1]: Hyp mode initialized successfully
> >>> [    2.517242] kvm [1]: interrupt-controller at e1140000 IRQ13
> >>> [    2.522622] kvm [1]: timer IRQ3
> >>> [    2.525783] Kernel panic - not syncing: HYP panic:
> >>> [    2.525783] PS:200003c9 PC:0000007ffffff820 ESR:86000005
> >>> [    2.525783] FAR:0000007ffffff820 HPFAR:00000000003ffff0 PAR:0000000000000000
> >>> [    2.525783] VCPU:          (null)
> >>> [    2.525783]
> >>> [    2.547667] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.6.0-rc5+ #1
> >>> [    2.555137] Hardware name: Default string Default string/Default string, BIOS ROD0084E 09/03/2015
> >>> [    2.563994] Call trace:
> >>> [    2.566432] [<ffffff80080888d0>] dump_backtrace+0x0/0x240
> >>> [    2.571818] [<ffffff8008088b24>] show_stack+0x14/0x20
> >>> [    2.576858] [<ffffff80083423ac>] dump_stack+0x94/0xb8
> >>> [    2.581899] [<ffffff8008152130>] panic+0x10c/0x250
> >>> [    2.586677] [<ffffff8008152024>] panic+0x0/0x250
> >>> [    2.591281] SMP: stopping secondary CPUs
> >>> [    3.649692] SMP: failed to stop secondary CPUs 0-2,4-7
> >>> [    3.654818] Kernel Offset: disabled
> >>> [    3.658293] Memory Limit: none
> >>> [    3.661337] ---[ end Kernel panic - not syncing: HYP panic:
> >>> [    3.661337] PS:200003c9 PC:0000007ffffff820 ESR:86000005
> >>> [    3.661337] FAR:0000007ffffff820 HPFAR:00000000003ffff0 PAR:0000000000000000
> >>> [    3.661337] VCPU:          (null)
> >>> [    3.661337]
> >>>
> >>>
> >>> Reported-by: Will Deacon <will.deacon@arm.com>
> >>> Signed-off-by: James Morse <james.morse@arm.com>

[...]

> >> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> >>
> > thanks!  Will, should this go via the kvmarm tree or the arm64 tree?
> 
> I believe this issue only exists with the hibernation patches, so I
> suggest we let Will handle this though the arm64 tree together with the
> rest of this series.

Appplied and pushed to for-next/core. Sorry for the delay (bank holiday
here) and thanks for the comments.

Will
