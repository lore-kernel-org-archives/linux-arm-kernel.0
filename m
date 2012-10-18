From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Oct 2012 14:54:44 +0100
Subject: [PATCH V2 3/3] ARM: tegra: move debug-macro.S to include/debug
In-Reply-To: <5080088C.9090607@gmail.com>
References: <1350328024-30485-1-git-send-email-swarren@wwwdotorg.org>
 <1350328024-30485-3-git-send-email-swarren@wwwdotorg.org>
 <507EC303.1080000@gmail.com> <507EDB37.1060102@wwwdotorg.org>
 <507F1F31.2060503@wwwdotorg.org> <5080088C.9090607@gmail.com>
Message-ID: <20121018135444.GT21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 08:47:56AM -0500, Rob Herring wrote:
> Here is what I mentioned previously. This removes the static mapping from 
> the platforms. This is untested and probably breaks on different DEBUG_LL 
> options. For now, platforms call debug_ll_io_init, but once all platforms 
> are converted, this can be called from devicemaps_init.

There's a problem with this approach.  What if the platform specifically
sets the debug addresses to be within one of it's existing mappings (which
is definitely what you'd want to do with 8250-based UARTs attached to a
PCI bus.)

This isn't going to work in that case unless we split the debug mapping
from the PCI IO space mapping.
