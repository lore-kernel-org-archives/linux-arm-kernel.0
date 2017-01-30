From: sstabellini@kernel.org (Stefano Stabellini)
Date: Mon, 30 Jan 2017 13:02:21 -0800 (PST)
Subject: [RFC v2] Device memory mappings for Dom0 on ARM64 ACPI systems
Message-ID: <alpine.DEB.2.10.1701301154340.20188@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

a couple of weeks ago I sent a detailed email asking for feedback on a
problem with Linux on Xen on ACPI systems:

http://marc.info/?l=linux-arm-kernel&m=148469169210500&w=2

In short, on BUS_NOTIFY_ADD_DEVICE events, Linux (as Dom0) requests
stage-2 MMIO regions mappings via hypercall to Xen. This works well for
devices, but few MMIO regions exist which do not belong to any devices,
therefore today they don't get mapped. For example: ACPI
OperationRegion, ECAM, other memory regions described in static tables
such as BERT.

In the email linked above, I suggested a few different approaches to
solving this issue. It looks like the consensus is around solution b):

> b) Otherwise, we could write an alternative implementation of ioremap
> on arm64. The Xen specific ioremap would request a stage-2 mapping
> first, then create the stage-1 mapping as usual. However, this means
> issuing an hypercall for every ioremap call.

If that's OK for you, we are going to move forward with this approach.

Thanks,

Stefano
