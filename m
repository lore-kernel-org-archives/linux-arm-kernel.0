From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 27 Mar 2018 16:03:10 +0200
Subject: [net-next PATCH 2/5] soc: ti: K2G: provide APIs to support
 driver probe deferral
In-Reply-To: <4aeeda56-c68b-cb64-1314-a669f721ff20@ti.com>
References: <1522095312-23249-1-git-send-email-m-karicheri2@ti.com>
 <1522095312-23249-3-git-send-email-m-karicheri2@ti.com>
 <20180326204802.GC5862@lunn.ch>
 <4aeeda56-c68b-cb64-1314-a669f721ff20@ti.com>
Message-ID: <20180327140310.GK5862@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Could you please elaborate? These knav dma and qmss drivers are
> introduced to support packet DMA hardware available in Keystone
> NetCP which couldn't be implemented using the DMA APIs available
> at the time this driver was introduced. Another reason was that
> the performance was really bad. We had an internal implementation
> based on DMA API before which couldn't be upstreamed at that time
> due to the reason that we were mis-using the API for this driver.
> So we introduced these knav_dma driver to support NetCP. We don't
> have any plan to re-write the driver at this time.
> 
> If your question is about EPROBE_DEFER being returned from an
> existing knav_dma API and using the return code to achieve probe
> defer instead of introducing these APIs, I can take a look into
> that and respond. So please clarify.
 
Hi Murali

So if i understood you right, at the time these drivers were written,
the linux DMA API did not do what you wanted. You could hack something
together by using the API wrongly, but that could not be mainlined. So
rather than fixing the DMA API to make it work for this hardware, you
ignored it, and made up your own API? This API now has its own
problems, it does not correctly handle ordering? So you are hacking
your own API further.

Does the Linux DMA API correctly handle probing order issues? Has the
Linux DMA API evolved so that it now does do what is needed by your
hardware?

If this was an old hardware which is slowly going away, it would not
be an issue. But it seems like there are new variants of the hardware
being released. So maybe you should go back and re-write the DMA
driver, rather than paper over the cracks?

	Andrew
