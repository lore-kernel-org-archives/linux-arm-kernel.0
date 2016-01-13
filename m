From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 Jan 2016 11:09:00 +0000
Subject: [RFC] arm64: failed when run the command: timedatectl
 set-timezone Asia/Shanghai
In-Reply-To: <5695A57B.1060905@huawei.com>
References: <56946932.70601@huawei.com> <569473B2.3030909@huawei.com>
 <CAPvkgC3HkZ5nP4qxDO+LRCeK5dd29zEpz9ZeK7J_mrCWXrszGA@mail.gmail.com>
 <5695A57B.1060905@huawei.com>
Message-ID: <20160113110900.GA23370@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 09:16:43AM +0800, Xishi Qiu wrote:
> On 2016/1/12 18:59, Steve Capper wrote:
> 
> > On 12 January 2016 at 03:32, Xishi Qiu <qiuxishi@huawei.com> wrote:
> >> On 2016/1/12 10:47, Xishi Qiu wrote:
> >>
> >>> Failed when run the command: timedatectl set-timezone Asia/Shanghai
> >>> But CONFIG_PGTABLE_LEVELS=3 is OK, and CONFIG_PGTABLE_LEVELS=4 is failed.
> >>> The kernel is v4.1, and this command need the lib polikit.
> >>>
> >>> Is this the bug of kernel?
> >>>
> >>> Thanks,
> >>> Xishi Qiu
> >>
> >> [  241.310558] polkitd[3531]: unhandled level 0 translation fault (11) at 0x7fff9010c040, esr 0x92000004
> >> [  241.319838] pgd = ffff801fb3e05000
> >> [  241.323259] [7fff9010c040] *pgd=0000000000000000
> >>
> >> [  241.329407] CPU: 0 PID: 3531 Comm: polkitd Not tainted 4.1.12+ #1
> >> [  241.336312] Hardware name: Huawei Taishan 2160 /BC11SPCA, BIOS 1.12 12/30/2015
> >> [  241.343566] task: ffff801fb8772f00 ti: ffff80003f454000 task.ti: ffff80003f454000
> >> [  241.351089] PC is at 0xffff91d281ec
> >> [  241.354594] LR is at 0xffff91cb5b24
> >> [  241.358099] pc : [<0000ffff91d281ec>] lr : [<0000ffff91cb5b24>] pstate: 20000000
> >> [  241.365526] sp : 0000ffffd47a4380
> >> [  241.368858] x29: 0000ffffd47a47c0 x28: 0000000078e8107e
> >> [  241.374215] x27: 0000aaaafaf68020 x26: 00007fff9010c040
> >> [  241.379571] x25: 0000aaaafaf6c2b0 x24: 0000ffff91ed4000
> >> [  241.384931] x23: 0000000000000005 x22: 0000000000000000
> >> [  241.390288] x21: 0000000000000000 x20: 0000000000000008
> >> [  241.395644] x19: 0000ffff91ed4000 x18: 00000000000007df
> >> [  241.401004] x17: 0000ffff91ed5740 x16: 0000ffff91ce84ec
> >> [  241.406360] x15: 0000ffffd47a46a0 x14: 0000ffff91c07370
> >> [  241.411716] x13: 00000000000003d0 x12: 0000ffff92340000
> >> [  241.417074] x11: 0000000000000000 x10: 0101010101010101
> >> [  241.422431] x9 : 0000ffff90108218 x8 : 00000000f20217f7
> >> [  241.427786] x7 : 0000aaaafaf6db40 x6 : 0000ffff90109060
> >> [  241.433146] x5 : 0000000000000000 x4 : 0000aaaafaf6dc30
> >> [  241.438502] x3 : 0000000000000001 x2 : 0000000000000008
> >> [  241.443858] x1 : 0000aaaafaf68020 x0 : 00007fff9010c040
> >>
> >>
> >>
> > 
> > Hi Xishi,
> > This looks like a bug in the Mozilla Javascript engine (which is used
> > by polkitd). It incorrectly assumes that virtual addresses are at most
> > 47 bit and uses the upper bits for pointer tagging.
> > When we enable a 48-bit VA on arm64, this then exacerbates the problem
> > (your VA of 0x7fff9010c040 should likely be 0xffff9010c040).
> > 
> > I have raised this issue at:
> > https://bugzilla.mozilla.org/show_bug.cgi?id=1143022
> > 
> > I'm not sure as to the best way of getting this fixed, I would suggest
> > adding to the bug report above as a first step.
> > 
> 
> Hi Steve,
> 
> I find another issue at:
> https://bugzilla.redhat.com/show_bug.cgi?id=1242326

Per your question below, the proposed patch is incorrect.

Userspace can only assume ownership of the upper 8 bits, and only in the
cases described in [1]. Userspace MUST NOT assume it can use other bits
for its own purposes.

This was a deliberate decision such that the address space can be
enlarged in future. For example, ARMv8.2 expands addresses to 52 bits
[2], and addresses could grow further in future.

> In your issue, Tom Schuster said it sounds like bug 910845
> https://bugzilla.mozilla.org/show_bug.cgi?id=910845

Controlled allocation as in this patch is probably a workable approach.

However, the arm64 kernel can be built with a very small VA range, and
the base chosen is outside of the minimum range. The kernel currently
goes as low as 36 bits (with 16K pages), though the architectural
minimum seems to be 24 currently.

To be safe for all configurations, I guess the best option is to
allocate as close to zero as possible, or to dynamically choose a base
depending on the VA range. I'm not sure how to correctly determine the
VA range from userspace, however.

> Does "__ia64__" mean Itanium arch or all the 64-bit arch?

Using __ia64__ only covers Itanium.

> I'm not familiar with these rpms, so which fix is correct?

Hopefully that's answered above.

Thanks,
Mark.

[1]  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/arm64/tagged-pointers.txt?h=v4.4&id=afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc
[2] https://community.arm.com/groups/processors/blog/2016/01/05/armv8-a-architecture-evolution
