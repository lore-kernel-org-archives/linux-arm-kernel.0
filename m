From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 18 Dec 2017 10:40:31 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <1513588684-15647-1-git-send-email-mw@semihalf.com>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
Message-ID: <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 December 2017 at 10:17, Marcin Wojtas <mw@semihalf.com> wrote:
> Hi,
>
> This patchset introduces ACPI support in mvpp2 and mvmdio drivers.
> First three patches introduce fwnode helpers for obtaining PHY
> information from nodes and also MDIO fwnode API for registering
> the bus with its PHY/devices.
>
> Following patches update code of the mvmdio and mvpp2 drivers
> to support ACPI tables handling. The latter is done in 4 steps,
> as can be seen in the commits. For the details, please
> refer to the commit messages.
>
> Drivers operation was tested on top of the net-next branch
> with both DT and ACPI. Although for compatibility reasons
> with older platforms, the mvmdio driver keeps using
> of_ MDIO registering, new fwnode_ one proved to fully work
> with DT as well (tested on MacchiatoBin board).
>
> mvpp2/mvmdio driver can work with the ACPI representation, as exposed
> on a public branch:
> https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/commits/marvell-armada-wip
> It was compiled together with the most recent Tianocore EDK2 revision.
> Please refer to the firmware build instruction on MacchiatoBin board:
> http://wiki.macchiatobin.net/tiki-index.php?page=Build+from+source+-+UEFI+EDK+II
>
> Above support configures 1G to use its PHY normally. 10G can work now
> only with the link interrupt mode. Somehow reading of the
> string property in fwnode_mdiobus_child_is_phy works only with
> DT and cannot cope with 10G PHY nodes as in:
> https://pastebin.com/3JnYpU0A
>
> Above root cause will be further checked. In the meantime I will
> appreciate any comments or remarks for the kernel patches.
>

Hi Marcin,

I have added linux-acpi and Graeme to cc. I think it makes sense to
discuss the way you describe the device topology before looking at the
patches in more detail.

In particular, I would like to request feedback on the use of
[redundant] 'reg' properties and the use of _DSD + compatible to
describe PHYs. Usually, we try to avoid this, given that it is
essentially a ACPI encapsulated DT dialect that is difficult to
support in drivers unless they are based on DT to begin with. Also,
non-standard _DSD properties require a vendor prefix, it is not
freeform.

For reference, the ACPI description is here (starting at line 175)
https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/blob/72d5ac23b20dd74d479daa5e40ba443264b31261/Platforms/Marvell/Armada/AcpiTables/Armada80x0McBin/Dsdt.asl

-- 
Ard.
