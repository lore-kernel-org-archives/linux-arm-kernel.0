From: msalter@redhat.com (Mark Salter)
Date: Wed, 26 Aug 2015 15:13:22 -0400
Subject: [PATCH] ARM64: kernel: implement ACPI parking protocol
In-Reply-To: <20150826160716.GB11863@red-moon>
References: <1436959990-32054-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1437063431.3583.2.camel@redhat.com> <20150716171221.GB18582@red-moon>
 <1437068449.3583.4.camel@redhat.com> <20150826160716.GB11863@red-moon>
Message-ID: <1440616402.13044.16.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-08-26 at 17:07 +0100, Lorenzo Pieralisi wrote:
> Mark,
> 
> On Thu, Jul 16, 2015 at 06:40:49PM +0100, Mark Salter wrote:
> 
> [...]
> 
> > > > The kernel will only add cached memory regions to linear mapping 
> > > > and
> > > > presumably, the FW will mark the mailboxes as uncached. Otherwise, 
> > > > it
> > > > is a FW bug. But I suppose we could run into problems with kernels
> > > > using 64K pagesize since firmware assumes 4k.
> > > 
> > > Nope, ioremap takes care of that, everything should be fine.
> > 
> > The mailbox is 4K. If it is next to a cached UEFI region, the kernel 
> > may
> > have to overlap the mailbox with a cached 64K mapping in order to 
> > include
> > the adjoining UEFI region in the linear map. Then the ioremap would 
> > fail
> > because the mailbox is included in the linear mapping.
> 
> You have to acknowledge that what you describe is a bit of a corner
> case (and a silly FW set-up), are you aware of any existing FW set-up
> where we actually hit the corner case above ?

Oh sure. It could definitely be a corner case. I'm not aware of any
existing firmware supporting the protocol implemented by your patch.
So time will tell how well firmware vendors which do implement it
avoid the corner case problem. I am aware of some existing firmwares
which put the mailbox area in RAM which is also in the kernel linear
mapping as cached memory. But those wouldn't work with your patch for
more reasons than that.

> 
> I think it is fine to leave code as-is, at least the mailbox
> mappings, I will check to see I can improve the MADT parsing,
> somehow.

I'm not strenuously opposed to leaving it as-is. But we need to
acknowledge that if the 64K pagesize issue isn't covered by the
protocol spec, we're relying on firmware vendors to be diligent
not to break 64K pagesize kernels.
