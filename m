From: robherring2@gmail.com (Rob Herring)
Date: Thu, 18 Oct 2012 09:15:23 -0500
Subject: [PATCH V2 3/3] ARM: tegra: move debug-macro.S to include/debug
In-Reply-To: <20121018135444.GT21164@n2100.arm.linux.org.uk>
References: <1350328024-30485-1-git-send-email-swarren@wwwdotorg.org>
 <1350328024-30485-3-git-send-email-swarren@wwwdotorg.org>
 <507EC303.1080000@gmail.com> <507EDB37.1060102@wwwdotorg.org>
 <507F1F31.2060503@wwwdotorg.org> <5080088C.9090607@gmail.com>
 <20121018135444.GT21164@n2100.arm.linux.org.uk>
Message-ID: <50800EFB.9060503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/2012 08:54 AM, Russell King - ARM Linux wrote:
> On Thu, Oct 18, 2012 at 08:47:56AM -0500, Rob Herring wrote:
>> Here is what I mentioned previously. This removes the static mapping from 
>> the platforms. This is untested and probably breaks on different DEBUG_LL 
>> options. For now, platforms call debug_ll_io_init, but once all platforms 
>> are converted, this can be called from devicemaps_init.
> 
> There's a problem with this approach.  What if the platform specifically
> sets the debug addresses to be within one of it's existing mappings (which
> is definitely what you'd want to do with 8250-based UARTs attached to a
> PCI bus.)
> 
> This isn't going to work in that case unless we split the debug mapping
> from the PCI IO space mapping.

It is opt-in, so we may never get to the last step. We're still better
off than now. Is there a platform that is doing this? If so, I didn't
move any DEBUG_LL users to the fixed i/o space so they would still be
using their old i/o space address. Having 2 mappings would work, right?
You use the debug mapping initially and when PCI bus and the real
console driver are up, you switch to the fixed i/o space.

This isn't just a PCI issue. You could also have a mapping that covers a
block of SOC peripherals including the uart and you don't want a
separate mapping.

Rob
