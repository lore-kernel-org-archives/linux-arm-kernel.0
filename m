From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 7 Dec 2011 19:10:48 -0500 (EST)
Subject: Bug#651215: Kernel fails to boot on NSLU2
In-Reply-To: <20111207225718.GI14542@n2100.arm.linux.org.uk>
References: <20111206194048.12063.82586.reportbug@vrnul03074nb.vr-netze.vrnet>
 <1323237747.18450.7.camel@deadeye> <8739cwxcjd.fsf@lebrac.rtp-net.org>
 <20111207225718.GI14542@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1112071902360.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Dec 2011, Russell King - ARM Linux wrote:

> On Wed, Dec 07, 2011 at 11:05:58PM +0100, Arnaud Patard wrote:
> > I may be wrong but it seems that arm_dma_zone_size is used before being
> > set. It would be interesting if someone can boot test a nslu2 kernel with
> > appended patch.
> 
> It does look like that's the case - arm_dma_zone_size is used in
> arm_bootmem_free(), which is called from bootmem_init() and in turn
> paging_init().
> 
> So, arm_dma_zone_size needs to be set before paging_init() is called.

Oops, indeed.

> I'd actually suggest moving it before:
> 
>         if (mdesc->restart_mode)
>                 reboot_setup(&mdesc->restart_mode);
> 
> so that it's set real early, to avoid any future problems with this.
> The earlier these kinds of things are set, the less likely this kind
> of bug will happen.

Arnaud: please resubmit your patch moving the call as suggested by 
Russell and mark it with:

Acked-by: Nicolas Pitre <nico@linaro.org>

and

CC: stable at kernel.org

Thanks


Nicolas
