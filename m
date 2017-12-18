From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 18 Dec 2017 16:49:48 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <CAKv+Gu8_6y3dU81ZS4WWCfpRZkfjGo_+_K--e3go_3_xXwBErQ@mail.gmail.com>
Message-ID: <CAPv3WKeF8Nw+rRjWmnJ5NhoyvwyPgpFBCbr-jCnjiHeghW3Tvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard

2017-12-18 10:40 GMT+01:00 Ard Biesheuvel <ard.biesheuvel@linaro.org>:
> On 18 December 2017 at 10:17, Marcin Wojtas <mw@semihalf.com> wrote:
>> Hi,
>>
>> This patchset introduces ACPI support in mvpp2 and mvmdio drivers.
>> First three patches introduce fwnode helpers for obtaining PHY
>> information from nodes and also MDIO fwnode API for registering
>> the bus with its PHY/devices.
>>
>> Following patches update code of the mvmdio and mvpp2 drivers
>> to support ACPI tables handling. The latter is done in 4 steps,
>> as can be seen in the commits. For the details, please
>> refer to the commit messages.
>>
>> Drivers operation was tested on top of the net-next branch
>> with both DT and ACPI. Although for compatibility reasons
>> with older platforms, the mvmdio driver keeps using
>> of_ MDIO registering, new fwnode_ one proved to fully work
>> with DT as well (tested on MacchiatoBin board).
>>
>> mvpp2/mvmdio driver can work with the ACPI representation, as exposed
>> on a public branch:
>> https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/commits/marvell-armada-wip
>> It was compiled together with the most recent Tianocore EDK2 revision.
>> Please refer to the firmware build instruction on MacchiatoBin board:
>> http://wiki.macchiatobin.net/tiki-index.php?page=Build+from+source+-+UEFI+EDK+II
>>
>> Above support configures 1G to use its PHY normally. 10G can work now
>> only with the link interrupt mode. Somehow reading of the
>> string property in fwnode_mdiobus_child_is_phy works only with
>> DT and cannot cope with 10G PHY nodes as in:
>> https://pastebin.com/3JnYpU0A
>>
>> Above root cause will be further checked. In the meantime I will
>> appreciate any comments or remarks for the kernel patches.
>>
>
> Hi Marcin,
>
> I have added linux-acpi and Graeme to cc. I think it makes sense to
> discuss the way you describe the device topology before looking at the
> patches in more detail.
>

Thanks. Tomasz Nowicki immediately pointed this to me off the lists.

> In particular, I would like to request feedback on the use of
> [redundant] 'reg' properties and the use of _DSD + compatible to
> describe PHYs. Usually, we try to avoid this, given that it is
> essentially a ACPI encapsulated DT dialect that is difficult to
> support in drivers unless they are based on DT to begin with. Also,
> non-standard _DSD properties require a vendor prefix, it is not
> freeform.
>

Already a lot of drivers use both DT + ACPI. Some have IMO very
fanciful bindings in both, mostly handled within the drivers with
custom functions. OF_ - only drivers can use of_mdio_ helper routines,
that assume a certain hierarchy:
MDIO device node with PHYs as children, which are referenced in the
ports node. I believe such approach could fit ACPI description too.
I'm aware however that my code is pretty much DT transposed into ACPI
environment and I'm of course open to discussion, how to do it in the
most proper way.

My main goal is to provide an fwnode-based glue code, that can be used
among the NIC/MDIO drivers  (+ phylink) without multiple ifs
differentiating between ACPI/OF. What I sent has single calls in
mvpp2/mvmdio with a common bottom layers, but I don't see a problem,
that, e.g. when iterating over PHY subnodes, in case of OF
'reg'/'compatible' are used, whereas with ACPI some specific _ADR/_CID
objects.

I'd appreaciate any feedback.

Best regards,
Marcin

> For reference, the ACPI description is here (starting at line 175)
> https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/blob/72d5ac23b20dd74d479daa5e40ba443264b31261/Platforms/Marvell/Armada/AcpiTables/Armada80x0McBin/Dsdt.asl
