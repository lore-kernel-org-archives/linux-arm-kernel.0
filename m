From: wangyijing@huawei.com (wangyijing)
Date: Wed, 22 Jun 2016 09:07:57 +0800
Subject: [PATCH v1 00/25] PCI: Request host bridge window resources
In-Reply-To: <20160621150352.GB31917@localhost>
References: <20160606225630.20936.77349.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160618180735.GB20504@localhost> <57692BD0.6030609@huawei.com>
 <20160621150352.GB31917@localhost>
Message-ID: <5769E4ED.4050904@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2016/6/21 23:03, Bjorn Helgaas ??:
> On Tue, Jun 21, 2016 at 07:58:08PM +0800, wangyijing wrote:
>> Hi Bjorn, use devm_request_resource() for host bridge resource is cool,
>> what about do the similar change for x86, now we request host bridge resource
>> in pci_acpi_root_add_resources() in x86, and we would release the host bridge
>> resource when host bridge device refcount reach 0. This logic may introduce issue,
>> E.g.
>> If we try to remove a pci host bridge, but there is a child pci device which refcount
>> cannot decrease to 0 after remove the device, in this case, its parent pci_bus and
>> parent device, all their refcount cannot reach to 0, the result is pci host bridge
>> refcount can not reach 0, so its .release_fn() won't be called, and host bridge
>> resouces can not release. If we want to add the pci host bridge again, all pci devices
>> can not work because the resource is conflict with the old.
>>
>> devm resource would be released when the driver detach, this is better than what we do now, I think.
> 
> I'm not going to convert pci_root.c to use devm right now.  That might
> be a good thing, but this current series is mostly trivial.  I think
> changing pci_root.c would not be trivial, so that looks like a project
> all by itself.

OK.

> 
> I don't quite follow the example of removing a host bridge while a
> child PCI device refcount is non-zero.  That sounds like an invalid
> scenario regardless of whether the resources are released by a
> .release_fn() or by devm.

I would send a draft patch to describe and fix the issue, because it's not related to
this series, so let's discuess it in another thread. :)

Thanks!
Yijing.


> 
> Bjorn
> 
> .
> 
