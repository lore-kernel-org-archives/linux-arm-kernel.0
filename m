From: leedom@chelsio.com (Casey Leedom)
Date: Wed, 26 Jul 2017 18:26:38 +0000
Subject: [PATCH v7 2/3] PCI: Enable PCIe Relaxed Ordering if supported
In-Reply-To: <20170724090516.2e0f0d2a@w520.home>
References: <1499955692-26556-1-git-send-email-dingtianhong@huawei.com>
 <1499955692-26556-3-git-send-email-dingtianhong@huawei.com>
 <e496ff1d-b836-ebef-fdf7-76273aaaaef6@codeaurora.org>
 <0260e398-bd8e-6615-6d5c-1f7c07b6fc09@huawei.com>
 <67be791f-e0cf-8284-9229-17174dc741ef@codeaurora.org>
 <5f9b8bfb-41a8-a17c-6fea-581aec1d5573@huawei.com>,
 <20170724090516.2e0f0d2a@w520.home>
Message-ID: <MWHPR12MB1600065968964410EDFBDA3BC8B90@MWHPR12MB1600.namprd12.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  By the way Ding, two issues:

 1. Did we ever get any acknowledgement from either Intel or AMD
    on this patch?  I know that we can't ensure that, but it sure would
    be nice since the PCI Quirks that we're putting in affect their
    products.

 2. I just realized that there's still a small hole in the patch with
    respect to PCIe SR-IOV Virtual Functions.  When the PCI Quirk
    notices a problematic PCIe Device and marks it to note that
    it's not "happy" receiving Transaction Layer Packets with the
    Relaxed Ordering Attribute set, it's my understanding that your
    current patch iterates down the PCIe Fabric and turns off the
    PCIe Capability Device Control[Relaxed Ordering Enable].
    But this scan may miss any SR-IOV VFs because they
    probably won't be instantiated at that time.  And, at a later
    time, when they are instantiated, they could well have their
    Relaxed Ordering Enable set.

    I think that the patch will need to be extended to modify
    drivers/pci.c/iov.c:sriov_enable() to explicitly turn off
    Relaxed Ordering Enable if the Root Complex is marked
    for no RO TLPs.

Casey
