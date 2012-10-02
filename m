From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 2 Oct 2012 22:28:35 +0200
Subject: [PATCH 11/12] pinctrl: samsung: use __devinit section for init
 code
In-Reply-To: <1348868177-21205-12-git-send-email-arnd@arndb.de>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-12-git-send-email-arnd@arndb.de>
Message-ID: <20121002202835.GA31446@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 11:36:16PM +0200, Arnd Bergmann wrote:
> The samsung pinctrl driver has a probe function that is
> __devinit and that calls a lot of other functions that are
> marked __init, which kbuild complains about.
> 
> Marking everything __devinit means that the code does not
> discarded when CONFIG_HOTPLUG is set, which is a little
> more wasteful, but also more consistent
> 
> Without this patch, building exynos_defconfig results in:
> 
> WARNING: drivers/pinctrl/built-in.o(.devinit.text+0x124): Section mismatch in reference from the function samsung_pinctrl_probe() to the function .init.text:samsung_gpiolib_register()
> The function __devinit samsung_pinctrl_probe() references
> a function __init samsung_gpiolib_register().
> If samsung_gpiolib_register is only used by samsung_pinctrl_probe then
> annotate samsung_gpiolib_register with a matching annotation.

Note that work is underway to remove HOTPLUG altogether (see commit
45f035a, "CONFIG_HOTPLUG should be always on" in linux-next), so it
may make more sense to just drop the __init markings.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121002/619651cc/attachment-0001.sig>
