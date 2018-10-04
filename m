From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Oct 2018 19:07:55 +0100
Subject: [RFC PATCH] skb: Define NET_IP_ALIGN based on
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
In-Reply-To: <CAKv+Gu9MBJ0w+23XMg+w_EYEf0Hx8dkW-w-rf4Bzu_c3GN_YiQ@mail.gmail.com>
References: <20181004173631.3nchegr6rm3jgz24@xylophone.i.decadent.org.uk>
 <CAKv+Gu9MBJ0w+23XMg+w_EYEf0Hx8dkW-w-rf4Bzu_c3GN_YiQ@mail.gmail.com>
Message-ID: <20181004180755.GE30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 04, 2018 at 07:43:59PM +0200, Ard Biesheuvel wrote:
> (+ Arnd, Russell, Catalin, Will)
> 
> On 4 October 2018 at 19:36, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> > NET_IP_ALIGN is supposed to be defined as 0 if DMA writes to an
> > unaligned buffer would be more expensive than CPU access to unaligned
> > header fields, and otherwise defined as 2.
> >
> > Currently only ppc64 and x86 configurations define it to be 0.
> > However several other architectures (conditionally) define
> > CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, which seems to imply that
> > NET_IP_ALIGN should be 0.
> >
> > Remove the overriding definitions for ppc64 and x86 and define
> > NET_IP_ALIGN solely based on CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
> >
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> 
> While this makes sense for arm64, I don't think it is appropriate for
> ARM per se.
> 
> The unusual thing about ARM is that some instructions require 32-bit
> alignment even when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set,
> (i.e., load/store multiple, load/store double), and we rely on
> alignment fixups done by the kernel to deal with the fallout if such
> instructions happen to be used on unaligned quantities (Russell,
> please correct me if this is inaccurate)

Correct, and we do have some assembly that use ldmia in the net code
(eg, for checksum calculation.)  Having NET_IP_ALIGN be 0 on ARM
coupled with a network adapter that doesn't do its own checksumming
would mean every non-hw-checksummed IP packet hitting the alignment
fixup - and not just once per packet.

So it's likely that this change could provoke reports of performance
regressions for ARM.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
