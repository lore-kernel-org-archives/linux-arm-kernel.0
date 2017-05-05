From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Fri, 5 May 2017 07:04:53 -0700
Subject: [PATCH 1/2] PCI: Add new PCIe Fabric End Node flag,
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING
In-Reply-To: <MWHPR12MB1600E78DD7F530AA9DC2433DC8EA0@MWHPR12MB1600.namprd12.prod.outlook.com>
References: <cover.1493678834.git.leedom@chelsio.com>
 <758d0e431c732fe133e7b0e660bde5fc1beccdba.1493678834.git.leedom@chelsio.com>
 <CAKgT0UeuW88AHBX14H8xHteeG7vR0AH3apbjOeEDx_6p46x7tA@mail.gmail.com>
 <20170502165329.GB26406@linux.intel.com>
 <CAKgT0UcxjGCZu_QV-eF7_yWkDBbQpLpdaPqBf1gji8XXM5Cc=w@mail.gmail.com>
 <MWHPR12MB160095DF53CE981C923FE65DC8160@MWHPR12MB1600.namprd12.prod.outlook.com>
 <CAKgT0UdJ17DGAphuP5Y9co6ky-GBFdq2s-1nqctY_Tz_iz5__g@mail.gmail.com>
 <MWHPR12MB1600E78DD7F530AA9DC2433DC8EA0@MWHPR12MB1600.namprd12.prod.outlook.com>
Message-ID: <CAKgT0Ucwkp+fi-9HhMbze6t_i15dj4e2WQBp13Coi6MegrDh=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 4, 2017 at 2:01 PM, Casey Leedom <leedom@chelsio.com> wrote:
> | From: Alexander Duyck <alexander.duyck@gmail.com>
> | Sent: Wednesday, May 3, 2017 9:02 AM
> | ...
> | It sounds like we are more or less in agreement. My only concern is
> | really what we default this to. On x86 I would say we could probably
> | default this to disabled for existing platforms since my understanding
> | is that relaxed ordering doesn't provide much benefit on what is out
> | there right now when performing DMA through the root complex. As far
> | as peer-to-peer I would say we should probably look at enabling the
> | ability to have Relaxed Ordering enabled for some channels but not
> | others. In those cases the hardware needs to be smart enough to allow
> | for you to indicate you want it disabled by default for most of your
> | DMA channels, and then enabled for the select channels that are
> | handling the peer-to-peer traffic.
>
>   Yes, I think that we are mostly in agreement.  I had just wanted to make
> sure that whatever scheme was developed would allow for simultaneously
> supporting non-Relaxed Ordering for some PCIe End Points and Relaxed
> Ordering for others within the same system.  I.e. not simply
> enabling/disabling/etc.  based solely on System Platform Architecture.
>
>   By the way, I've started our QA folks off looking at what things look like
> in Linux Virtual Machines under different Hypervisors to see what
> information they may provide to the VM in the way of what Root Complex Port
> is being used, etc.  So far they've got Windows HyperV done and there
> there's no PCIe Fabric exposed in any way: just the attached device.  I'll
> have to see what pci_find_pcie_root_port() returns in that environment.
> Maybe NULL?

I believe NULL is one of the options. It all depends on what qemu is
emulating. Most likely you won't find a pcie root port on KVM because
the default is to emulate an older system that only supports PCI.

>   With your reservations (which I also share), I think that it probably
> makes sense to have a per-architecture definition of the "Can I Use Relaxed
> Ordering With TLPs Directed At This End Point" predicate, with the default
> being "No" for any architecture which doesn't implement the predicate.  And
> if the specified (struct pci_dev *) End Node is NULL, it ought to return
> False for that as well.  I can't see any reason to pass in the Source End
> Node but I may be missing something.
>
>   At this point, this is pretty far outside my level of expertise.  I'm
> happy to give it a go, but I'd be even happier if someone with a lot more
> experience in the PCIe Infrastructure were to want to carry the ball
> forward.  I'm not super familiar with the Linux Kernel "Rules Of
> Engagement", so let me know what my next step should be.  Thanks.
>
> Casey

For now we can probably keep this on the linux-pci mailing list. Going
that route is the most straight forward for now since step one is
probably just making sure we are setting the relaxed ordering bit in
the setups that make sense. I would say we could probably keep it
simple. We just need to enable relaxed ordering by default for SPARC
architectures, on most others we can probably default it to off.

I believe this all had started as Ding Tianhong was hoping to enable
this for the ARM architecture. That is the only one I can think of
where it might be difficult to figure out which way to default as we
were attempting to follow the same code that was enabled for SPARC and
that is what started this tug-of-war about how this should be done.
What we might do is take care of this in two phases. The first one
enables the infrastructure generically but leaves it defaulted to off
for everyone but SPARC. Then we can go through and start enabling it
for other platforms such as some of those on ARM in the platforms that
Ding Tianhong was working with.

- Alex
