From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 10 Apr 2013 16:46:54 -0600
Subject: [PATCH v3 07/12] PCI: tegra: Move PCIe driver to drivers/pci/host
In-Reply-To: <20130405060351.GA15848@avionic-0098.mockup.avionic-design.de>
References: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
 <1365000318-28256-8-git-send-email-thierry.reding@avionic-design.de>
 <515DF096.2000703@wwwdotorg.org> <515DF0D9.40007@wwwdotorg.org>
 <20130405060351.GA15848@avionic-0098.mockup.avionic-design.de>
Message-ID: <5165EBDE.3080202@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2013 12:03 AM, Thierry Reding wrote:
> On Thu, Apr 04, 2013 at 03:30:01PM -0600, Stephen Warren wrote:
>> On 04/04/2013 03:28 PM, Stephen Warren wrote:
>>> On 04/03/2013 08:45 AM, Thierry Reding wrote:
>>>> Move the PCIe driver from arch/arm/mach-tegra into the
>>>> drivers/pci/host directory. The motivation is to collect
>>>> various host controller drivers in the same location in order
>>>> to facilitate refactoring.
>>>> 
>>>> The Tegra PCIe driver has been largely rewritten, both in
>>>> order to turn it into a proper platform driver and to add MSI
>>>> (based on code by Krishna Kishore <kthota@nvidia.com>) as
>>>> well as device tree support.
>>> 
>>>> arch/arm/boot/dts/tegra20.dtsi                     |   53 +
>>> 
>>> I guess this has to touch both the driver and the dtsi file so
>>> that bisectabilty isn't broken? I guess that's OK.
>> 
>> Actually, can't you move all the *.dts/*.dtsi changes to the
>> start of the series, then put the driver conversion patch last,
>> to avoid any bisectability issues and still keep code and DT
>> changes separate?
> 
> I'm not sure if that'll work. There's this oddity in the Harmony
> DTS where the regulator at 3 is disabled with a comment that this is a
> hack required until board-harmony-pcie.c is removed. If we change
> the DTS before the driver rewrite I think that would break
> requesting the GPIO in the board file.

Hmm. Well I guess that PCIe doesn't really work right now anyway. I
mean the enumeration works, but actual instantiation of the Linux
devices doesn't due to the resource conflict issues, which your new
driver works around.

As such, it might be simplest to just submit all the following in a
single kernel version:

* Delete old Tegra PCI support.
* Add new driver (add not move); this would just touch drivers/pci/host.
* Add all the required new DT content.

That would be basically what you've already posted, except that the DT
changes in this patch can be moved later, and all the arch/arm/*.c
patches can happen earlier if you want.

Does that sound reasonable?

I think you can do:

* All the DT changes first, except the one-line change to enable the
regulator. DT additions for the new PCIe controller would be
status=disabled.

* Add/move the new PCI.

We'd probably still want all this to go through a single tree so (i.e.
the Tegra tree, and not submit the drivers/pci/host addition through
the PCI tree) to avoid ever having 2 drivers at once for the Tegra PCI
controller.
