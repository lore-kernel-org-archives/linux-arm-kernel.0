From: leedom@chelsio.com (Casey Leedom)
Date: Wed, 26 Jul 2017 19:05:49 +0000
Subject: [PATCH v7 2/3] PCI: Enable PCIe Relaxed Ordering if supported
In-Reply-To: <CAKgT0Udn2vh6NaqZyiF69nXVnz2sT=e0ZgiDjWznhGZz-Gk+qQ@mail.gmail.com>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-3-git-send-email-dingtianhong@huawei.com>
 <e496ff1d-b836-ebef-fdf7-76273aaaaef6@codeaurora.org>
 <0260e398-bd8e-6615-6d5c-1f7c07b6fc09@huawei.com>
 <67be791f-e0cf-8284-9229-17174dc741ef@codeaurora.org>
 <5f9b8bfb-41a8-a17c-6fea-581aec1d5573@huawei.com>
 <20170724090516.2e0f0d2a@w520.home>
 <MWHPR12MB1600065968964410EDFBDA3BC8B90@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAKgT0UeAad6WArvrE71MFJywDs1wOnCF-iJRnbNLrL+knqhXeA@mail.gmail.com>
 <CAKgT0Uf5hdXUXja_jUB6_kBg6pyX8zXuOMOGzCVNgeBFMUsWqQ@mail.gmail.com>,
 <CAKgT0Udn2vh6NaqZyiF69nXVnz2sT=e0ZgiDjWznhGZz-Gk+qQ@mail.gmail.com>
Message-ID: <MWHPR12MB16007782C422082A92F4765DC8B90@MWHPR12MB1600.namprd12.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

| From: Alexander Duyck <alexander.duyck@gmail.com>
| Sent: Wednesday, July 26, 2017 11:44 AM
| 
| On Jul 26, 2017 11:26 AM, "Casey Leedom" <leedom@chelsio.com> wrote:
| |
| | ? ? I think that the patch will need to be extended to modify
| | ? ? drivers/pci.c/iov.c:sriov_enable() to explicitly turn off
| | ? ? Relaxed Ordering Enable if the Root Complex is marked
| ? ? for no RO TLPs.
| 
| I'm not sure that would be an issue. Wouldn't most VFs inherit the PF's settings?

Ah yes, you're right.  This is covered in section 3.5.4 of the Single Root I/O
Virtualization and Sharing Specification, Revision 1.0 (September 11, 2007),
governing the PCIe Capability Device Control register.  It states that the VF
version of that register shall follow the setting of the corresponding PF.

So we should enhance the cxgb4vf/sge.c:t4vf_sge_alloc_rxq() in the same
way we did for the cxgb4 driver, but that's not critical since the Relaxed
Ordering Enable supersedes the internal chip's desire to use the Relaxed
Ordering Attribute.

Ding, send me a note if you'd like me to work that up for you.

| Also I thought most of the VF configuration space is read only.

Yes, but not all of it.  And when a VF is exported to a Virtual Machine,
then the Hypervisor captures and interprets all accesses to the VF's
PCIe Configuration Space from the VM.

Thanks again for reminding me of the subtle aspect of the SR_IOV
specification that I forgot.

Casey
