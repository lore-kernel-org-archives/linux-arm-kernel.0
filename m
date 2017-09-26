From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 26 Sep 2017 08:23:46 +0000
Subject: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe PEM-specific
 register range for ACPI case
In-Reply-To: <CAKv+Gu8x0j-O3WPE7Cvi4oX5J5Cq1vUhDNB_UdjE88eQh83DDA@mail.gmail.com>
References: <20160920140518.GD13855@localhost>
 <CAKv+Gu-j-gKiNMx-TvSxezJth1619FN8W1rAy7DKpkmfX9ii6A@mail.gmail.com>
 <20160920191744.GA4941@localhost> <20160921140549.GA11968@red-moon>
 <20160921180457.GB20006@localhost> <20160922094955.GB18637@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F8815A9@lhreml507-mbx>
 <20160922124446.GA21681@red-moon> <20160922183101.GA14510@localhost>
 <20160922221042.GA1514@localhost> <20160923101145.GA31120@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E1F884340@lhreml507-mbx>
 <CAKv+Gu8x0j-O3WPE7Cvi4oX5J5Cq1vUhDNB_UdjE88eQh83DDA@mail.gmail.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40C43928@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard

Sorry to reply late on this

> -----Original Message-----
> From: Ard Biesheuvel [mailto:ard.biesheuvel at linaro.org]
> Sent: 14 September 2017 15:07
> To: Gabriele Paoloni
> Cc: Lorenzo Pieralisi; Hanjun Guo; Marcin Wojtas; Wangyijing; linux-
> pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org; liudongdong
> (C); linux-acpi at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH V6 3/5] PCI: thunder-pem: Allow to probe PEM-
> specific register range for ACPI case
> 
> (remove most cc's)
> 
> Hi all,
> 
> Apologies for digging up this old thread.
> 
> I am currently looking into whether it is feasible to refactor some of
> the ACPI PCI quirk code we have so it can apply to more instances of
> the Synopsys Designware PCIe (i.e., for Marvell and Socionext SOCs),
> which all suffer from the same issue that type 0 config TLPs are not
> filtered before being sent out on the link, resulting in devices
> appearing multiple times.

What do you mean by "filtered"? Looking at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5f00f1a0178cf52928366a5e1f376a65f1f3f389
you can see that the issue is that accesses to the root buses config space
are done using a specific HW location rather than the ECAM space area
(used for the rest of the hierarchy).
Also only 32b accessors can operate on the root bus config space.

> 
> The pci-hisi.c quirk already appears to do exactly what would solve
> the problem on other SoCs as well. So I will try to refactor this code
> into something that I could propose for upstream, while probably
> getting the ARM SBSA authors to offer some guidance that this IP must
> not be used for new designs.

Mmm I am not sure how Kernel maintainers would open to accept more quirks...
as I remember we discussed to accept quirks only for existing platform
but not for any future one (i.e. future HW should not use the non-ECAM
DW IP). However this is my understanding, I may be wrong here...

> 
> In any case, the chances of any such changes being acceptable upstream
> are probably higher if we can reuse the exact same quirk as we have
> already implemented for HiSilicon, so I wonder if anyone from Huawei
> could comment on some questions I have:
> - Why does the config space accessor override use 32-bit accesses only
> for bus #0? Is that really necessary?

I have talked to our SoC HW designers and they said that 32b accesses is
a constraint due to Synopsys DW IP limitation and yes it is necessary

> - Why does the Hisi quirk use different config base addresses for bus
> #0 and the other buses? Is this simply because the firmware does not
> use contiguous iATU windows for bus #0 and buses #1 and up? So is

As I remember there is a dedicated continuous device memory slice that is
dedicated for all the root buses (therefore you cannot spilt such area
to have root bus slices contiguous with the different ECAM areas of each
RP hierarchy)

> there anything mapped in the 1 MB slice at the base of the respective
> 256 MB mappings that generate type1 config cycles?

If I remember correctly we map device memory to the 1MB slice but
we never access it (instead we in the accessors we use cfg->busr.start
to understand is the current cfg rd/wr if being done on a root bus and
eventually rout the access to the dedicate root bus cfg space) 

> 
> Having just a shared set of config space accessor overrides would
> already be an improvement, given that they can be shared with a DT
> based driver for this IP in ECAM mode as well.

Probably we could have shared accessors, but again we need to see
if the community is open to accept more quirks

Thanks
Gab

> 
> Thanks,
> Ard.
