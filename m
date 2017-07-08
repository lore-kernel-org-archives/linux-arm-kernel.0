From: leedom@chelsio.com (Casey Leedom)
Date: Sat, 8 Jul 2017 00:30:12 +0000
Subject: [PATCH v6 0/3] Add new PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
In-Reply-To: <MWHPR12MB160087E9E0B17F7A17609714C8AA0@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <1498133721-21152-1-git-send-email-dingtianhong@huawei.com>,
 <MWHPR12MB160087E9E0B17F7A17609714C8AA0@MWHPR12MB1600.namprd12.prod.outlook.com>
Message-ID: <MWHPR12MB160006024D920ED58126048AC8AB0@MWHPR12MB1600.namprd12.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  By the way, it ~seems~ like the patch set confuses the idea of the PCIe Capability Device Control[Relaxed Ordering Enable] with the device's ability to handle incoming TLPs with the Relaxed Ordering Attribute set.  These are completely different things.  The PCIe Capability Device Control[Relaxed Ordering Enable] solely governs the ability of the device to _send_ TLPs with the Relaxed Ordering Attribute set.  It has nothing whatsoever to do with the handling of incoming TLPs with the Relaxed Ordering Attribute set.  In fact, there is any standard way to disable receipt processing of such TLPs.  That's kind of the whole point of the majority of the patch.  If there was a separate "Ignore Incoming Relaxed Ordering Attributes" then we'd mostly just have a quirk which would set that for problematic devices.

  Worse yet, if I'm reading the patch right, it _is_ turning off the PCIe Capability Device Control[Relaxed Ordering Enable] for the devices that we've identified with problematic receive handling.  Not only does this not solve the problem that we've been talking about, it actually almost certainly introduces a huge Graphics Performance Bug.  The Relaxed Ordering Attribute was originally developed for Graphics Device support in order to download textures, etc. to a graphics devices as fast as possible and only ensure ordering at points where needed.  For instance, as far as I know, the Intel Root Complexes that we've been talking about have no issues whatsoever in generating downstream TLPs with the Relaxed Ordering Attribute set.  By turning off the PCIe Capability Device Control[Relaxed Ordering Enable] on these Root Complexes, this patch prevents the generation of downstream TLPs with the Relaxed Ordering Attribute set targeted at devices like graphics adapters.

Casey
