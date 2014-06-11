From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 11 Jun 2014 12:22:50 +0100
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <5397360B.80102@huawei.com>
References: <20140328184517.GA27219@cbox> <5397360B.80102@huawei.com>
Message-ID: <CACxGe6tpoCmvD0yjqf1j=priMURoVE0rMH=oQtQSn+RdG5dgGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Jun 2014 17:45, "Claudio Fontana" <claudio.fontana@huawei.com> wrote:
>
> Hello all,
>
> I just wanted to share with you guys how we are using virtualization on ARM64 over here for the OSv project.
> I don't know if that's something that could be useful for your specification effort.
>
> In OSv, creating and starting a VM to some level means starting an application.
> That is, OSv should be a very thin bare bones guest server OS, which also acts as a kind of run-time library for an application to run.
> All the devices are assumed to be virtualized and heavily relying on virtio.
>
> Therefore we see a higher need for quick VM launch than it might be for other use cases.
>
> One aspect of this is that we currently start executing the image directly (no UEFI involved on the guest),
> and in some cases we might not need a full fledged file system at all,
> as the communication can happen via virtio channels.

The purpose of this spec is for creating portable disk images. It is
intended to support the virtual-machine-looks-just-like-a-real-machine
model, and is intended to provide exactly the same interface to
installers as to real machines.

It isn't really interesting for use cases like OSv or anyone who wants
to start the kernel directly. You don't need UEFI in that case because
the host has pre-knowledge of which kernel binary to load. In that
regard this spec doesn't affect you.

>
> We do have a need for ACPI for discovery of information like gic addresses, timers, interrupts... (no interest on device trees, really), and of PCI-E.

This may be a problem for you then. The only time we're planning to
support ACPI in a VM is when UEFI is used for booting. Even the first
version of this spec specifies FDT, not ACPI. FDT support is there now
in Xen and KVM, but there is nothing for ACPI on ARM VMs.

What is the objection to obtaining discovery information from FDT?

> By skipping steps like UEFI, grub, firmware load, etc we strive to keep our application launch time low.
> Is this going to create problems for us in the future if you start requiring every VM to boot using those instead?

No, we're not requiring a full firmware stack to boot. As described
above, this is only for booting disk images.

g.
