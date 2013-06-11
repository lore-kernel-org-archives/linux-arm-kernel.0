From: agraf@suse.de (Alexander Graf)
Date: Tue, 11 Jun 2013 10:28:49 +0200
Subject: [PATCH 2/2] add initial kvm dev passhtrough support
In-Reply-To: <51B6D52E.4030707@huawei.com>
References: <51B6D52E.4030707@huawei.com>
Message-ID: <A501B176-B65B-4CEB-BB12-3EE7C165945C@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 11.06.2013 um 09:43 schrieb Mario Smarduch <mario.smarduch@huawei.com>:

> 
> This is the initial device pass through support.
> At this time host == guest only is supported.
> Basic Operation:
> 
> - QEMU parameters: -device kvm-device-assign,host=<device name>
>  for example - kvm-device-assign,host='arm-sp804'. Essentially
>  any device that does PIO should be supported.

Yikes!

Over the last few years we've worked very hard to get rid of the unfortunate intertwining of device assignment and KVM. There are a number of reasons it's a bad idea:

  - kvm access is a potential priviledge escalation
  - device assignment is limited to kvm

The solution to both of the above is VFIO. You get a completely separate interface for accessing your devices with a few connecting bits (irqfd, eventfd) to communicate quickly between vfio and kvm.

Is there any particular reason you're not going down that path for your ARM implementation?

On the embedded PPC side we've been discussing vfio and how it fits into a device tree, non-PCI world for a while. If you like, we can dive into more detail on that, either via email or via phone.


Alex
