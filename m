From: leedom@chelsio.com (Casey Leedom)
Date: Fri, 4 Aug 2017 20:20:37 +0000
Subject: [PATCH v7 2/3] PCI: Enable PCIe Relaxed Ordering if supported
In-Reply-To: <20170803083153.GB4883@otc-nc-03>
References: <e496ff1d-b836-ebef-fdf7-76273aaaaef6@codeaurora.org>
 <0260e398-bd8e-6615-6d5c-1f7c07b6fc09@huawei.com>
 <67be791f-e0cf-8284-9229-17174dc741ef@codeaurora.org>
 <5f9b8bfb-41a8-a17c-6fea-581aec1d5573@huawei.com>
 <20170724090516.2e0f0d2a@w520.home>
 <MWHPR12MB1600065968964410EDFBDA3BC8B90@MWHPR12MB1600.namprd12.prod.outlook.com>
 <75213fca-4522-2297-3cb8-338e643d3552@huawei.com>
 <CAKgT0UcqdRCwDDxD=22Q_jLuqz8KVHwH1-V45Aq-1WzQw=agcA@mail.gmail.com>
 <14218972-553d-eb60-0207-460ac7f4b064@huawei.com>
 <MWHPR12MB1600A6986E4AD13D302F2DC9C8B00@MWHPR12MB1600.namprd12.prod.outlook.com>,
 <20170803083153.GB4883@otc-nc-03>
Message-ID: <MWHPR12MB1600400EC7DEE92E4A3ADC5BC8B60@MWHPR12MB1600.namprd12.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

| From: Raj, Ashok <ashok.raj@intel.com>
| Sent: Thursday, August 3, 2017 1:31 AM
|
| I don't understand this completely.. So your driver would know not to send
| RO TLP's to root complex. But you want to send RO to the NVMe device? This
| is the peer-2-peer case correct?

Yes, this is the "heavy hammer" issue which you alluded to later.  There are
applications where a device will want to send TLPs to a Root Complex without
Relaxed Ordering set, but will want to use it when sending TLPs to a Peer
device (say, an NVMe storage device).  The current approach doesn't make
that easy ... and in fact, I still don't kow how to code a solution for this
with the proposed APIs.  This means that we may be trading off one
performance problem for another and that Relaxed Ordering may be doomed for
use under Linux for the foreseeable future.

As I've noted a number of times, it would be great if the Intel Hardware
Engineers who attempted to implement the Relaxed Ordering semantics in the
current generation of Root Complexes had left the ability to turn off the
logic which is obviously not working.  If there was a way to disable the
logic via an undocumented register, then we could have the Linux PCI Quirk
do that.  Since Relaxed Ordering is just a hint, it's completely legitimate
to completely ignore it.

Casey
