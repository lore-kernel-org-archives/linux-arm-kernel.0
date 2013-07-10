From: balbi@ti.com (Felipe Balbi)
Date: Wed, 10 Jul 2013 19:11:58 +0300
Subject: Boot hang regression 3.10.0-rc4 -> 3.10.0
In-Reply-To: <20130710160704.GH18966@arwen.pp.htv.fi>
References: <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi>
 <87mwpuakod.fsf@linaro.org> <20130710142633.GV5523@atomide.com>
 <20130710160704.GH18966@arwen.pp.htv.fi>
Message-ID: <20130710161158.GA19716@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 10, 2013 at 07:07:04PM +0300, Felipe Balbi wrote:
> how about something like below ? It makes omap_device/hwmod and
> pm_runtime agree on the initial state of the device and will prevent
> ->runtime_resume() from being called on first pm_runtime_get*() done
> during probe.
> 
> This is similar to what PCI bus does (if you look at pci_pm_init()).
> 
> commit 59108a500b4ab4b1a5102648a3360276dbf7df6f
> Author: Felipe Balbi <balbi@ti.com>
> Date:   Wed Jul 10 18:50:16 2013 +0300
> 
>     arm: omap2plus: unidle devices which are about to probe
>     
>     in order to make HWMOD and pm_runtime agree on the
>     initial state of the device, we will unidle the device
>     and call pm_runtime_set_active() to tell pm_runtime
>     that the device is really active.
>     
>     By the time driver's probe() is reached, a call to
>     pm_runtime_get_sync() will not cause driver's
>     ->runtime_resume() method to be called at first, only
>     after a successful ->runtime_suspend().
>     
>     Signed-off-by: Felipe Balbi <balbi@ti.com>

btw, this is RFC, haven't tested at all.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130710/18f596e3/attachment.sig>
