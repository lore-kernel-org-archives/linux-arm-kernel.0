From: brouer@redhat.com (Jesper Dangaard Brouer)
Date: Wed, 14 Feb 2018 09:49:15 +0100
Subject: [net PATCH] Revert "net: thunderx: Add support for xdp redirect"
In-Reply-To: <CA+sq2CfYosrbZUEb0hLZS1u6tiz+m4oxEXF3-43ZxyoHq=cAVg@mail.gmail.com>
References: <151854116184.18303.13476104443853509134.stgit@firesoul>
 <CA+sq2CfYosrbZUEb0hLZS1u6tiz+m4oxEXF3-43ZxyoHq=cAVg@mail.gmail.com>
Message-ID: <20180214094915.10fc6c36@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Feb 2018 01:05:16 +0530
Sunil Kovvuri <sunil.kovvuri@gmail.com> wrote:

> On Tue, Feb 13, 2018 at 10:29 PM, Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
> > This reverts commit aa136d0c82fcd6af14535853c30e219e02b2692d.
> >
> > As I previously[1] pointed out this implementation of XDP_REDIRECT is
> > wrong.  XDP_REDIRECT is a facility that must work between different
> > NIC drivers.  Another NIC driver can call ndo_xdp_xmit/nicvf_xdp_xmit,
> > but your driver patch assumes payload data (at top of page) will
> > contain a queue index and a DMA addr, this is not true and worse will
> > likely contain garbage.
> >
> > Given you have not fixed this in due time (just reached v4.16-rc1),
> > the only option I see is a revert.  
> 
> Sorry that i missed your email ie didn't respond.
>
> This driver is not for a generic PCI endpoint NIC, it's an on-silicon
> ethernet device found only on Cavium's ThunderX or OCTEONTX SOCs
> which supports upto 16 ports. XDP_REDIRECT here is mainly aimed at
> forwarding packets from one port to another
> port of same type.
> 
> The only way I could have avoided the payload data is by unmapping
> and remapping of DMA buffer which is quite expensive especially when
> IOMMU is enabled. So I thought this small optimization should be
> acceptable.

It is good that you bring up the need to avoid this DMA unmap+remap
issue, but we need to solve this in a generic way, as all drivers
would/should benefit from this optimization.


> If you still think that this shouldn't be done this way then go ahead
> and revert the patch,
> I will try to redo this as and when i find time.

Yes, please revert.

In connection with AF_XDP we need to improve/adjust the ndo_xdp_xmit
API.  We/I will try to incorporate the DMA mapping avoidance into the
API design.  Then it should hopefully be easier to redo this patch later.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
