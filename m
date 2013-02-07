From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Feb 2013 01:54:22 +0100
Subject: [PATCH 06/14] ARM: pci: Keep pci_common_init() around after init
In-Reply-To: <CACRpkdYV5w6BksUjXvXs=88BovUyXgRt-vXSD0twjRpzbZcvFQ@mail.gmail.com>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-7-git-send-email-thierry.reding@avionic-design.de>
 <CACRpkdYV5w6BksUjXvXs=88BovUyXgRt-vXSD0twjRpzbZcvFQ@mail.gmail.com>
Message-ID: <9348609.HjKCmL9u9S@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 February 2013 17:38:20 Linus Walleij wrote:
> On Wed, Jan 9, 2013 at 9:43 PM, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> 
> > When using deferred driver probing, PCI host controller drivers may
> > actually require this function after the init stage.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> 
> There seem to be a proliferation of these patches now.
> 
> Isn't this just papering over the real problem? The discarding
> of __init sections need to happen *after* all deferred probes
> are complete, lest we have to remove *all* __init sections from
> *all* drivers in the kernel, don't we?

No, I think it's not quite that bad. I think the rule is still
just that .probe() functions and anything called from them must
not be __init. They used to be __devinit, which would cause
problems with deferred probing on !HOTPLUG systems but that's
gone in 3.9.

Thierry's patch is just necessary because pci_common_init used
to be called only from actual __init functions, and not it
gets called from a .probe() function for the first time.

	Arnd
