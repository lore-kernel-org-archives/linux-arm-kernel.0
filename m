From: roger.pau@citrix.com (=?UTF-8?Q?Roger_Pau_Monn=c3=a9?=)
Date: Mon, 14 Sep 2015 17:23:04 +0200
Subject: [PATCH v4 00/20] xen/arm64: Add support for 64KB page in Linux
In-Reply-To: <alpine.DEB.2.02.1509141542430.2672@kaball.uk.xensource.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
 <55F68BC9.6020509@citrix.com> <55F6A437.3040403@citrix.com>
 <55F6A9DB.8040503@citrix.com> <55F6ADAE.1010609@citrix.com>
 <55F6B8CC.5090406@citrix.com> <55F6C1D2.7010206@citrix.com>
 <55F6D9DC.8060607@citrix.com>
 <alpine.DEB.2.02.1509141542430.2672@kaball.uk.xensource.com>
Message-ID: <55F6E658.4070908@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El 14/09/15 a les 16.54, Stefano Stabellini ha escrit:
> On Mon, 14 Sep 2015, Roger Pau Monn? wrote:
>> IMHO this splitting is just a workaround for the fact that we don't have
>> a 64KB PV block protocol, and this is the real problem that should be
>> solved.
> 
> 64K is a pure one guest kernel configuration option, not a platform wide
> option. The hypervisor interfaces are still the same, the ABI is the
> same and all the other guests are still the same, the Xen binary is
> still the same.

Yes, I understand that, but the PV block protocol is missing 64KB page
support, and that's a fact that cannot be ignored. To put an example, is
there a hardware SATA controller on ARM that doesn't support 64KB pages
and needs a similar workaround?

> A 64K block protocol could be a good performance imprevement, but should
> not be required to run kernels which have different config options.
> 
>> In the long term this will put a burden on all blkfronts (if 64KB pages
>> are also used by other OSes), while introducing a 64KB PV block protocol
>> will make the blkfront implementation in all OSes very similar to what
>> we have now, without replicating the splitting code amongst all the
>> possible blkfront implementations.
>>
>> Granted that some changes to blkback will be needed in order to support
>> mapping 64KB grants, but there are much fewer blkback implementations
>> out there than blkfronts.
> 
> I don't think we can rely on blkback having something in order to run
> new guests, otherwise we break compatibility: new guests won't run on
> old hypervisors.

I agree that this is far from ideal, but I don't think it's so
outrageous. For example Linux PVOPS Dom0 kernels require Xen 4.0.1 at
least in order to run, because previous versions lack the necessary
IOAPIC setup hypercall. Also, it won't prevent guests from booting, it
would just prevent them from using blkfront, but you can still get a
root filesystem using iSCSI, NFS or other means.

I'm not saying that we shouldn't take those patches, I'm just saying
that IMHO this is a workaround, and I would like to see a plan and
somebody committed to have it fixed in a proper way, by introducing a
64KB PV block protocol.

Roger.
