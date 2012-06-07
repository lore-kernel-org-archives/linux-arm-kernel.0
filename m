From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 7 Jun 2012 04:52:50 -0600 (MDT)
Subject: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
In-Reply-To: <4FD0602B.9070704@ti.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061308.25532.19767.stgit@dusk> <20120607073112.GX12766@atomide.com>
 <alpine.DEB.2.00.1206070136550.6684@utopia.booyaka.com>
 <20120607075158.GZ12766@atomide.com> <20120607075541.GF16342@arwen.pp.htv.fi>
 <4FD0602B.9070704@ti.com>
Message-ID: <alpine.DEB.2.00.1206070446070.6684@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jun 2012, Cousson, Benoit wrote:

> In fact we should delay the reset to the very last moment and 
> potentially reset the IPs not under driver control later after a couple 
> of second for example. It will avoid reseting every IP that will be 
> handled properly by drivers.

We discussed this a couple of years ago on the list and aligned on late 
and lazy resets, from my recollection.  The main reason why it wasn't 
implemented was because there were some drivers that were not yet PM 
runtime-converted.  This would have caused crashes, since the core code 
would have no idea that the non-PM-runtime drivers had initialized their 
devices, and so the core just went ahead and reset those anyway.

It might actually be safe now to switch to the late reset arrangement, 
depending on whether the rest of the drivers have been PM 
runtime-converted by now.

Of course, it would all be moot if the reset is moved away from the hwmod 
code into the drivers.


- Paul
