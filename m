From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Jun 2017 13:49:09 +0100
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <cover.1498642745.git.viresh.kumar@linaro.org>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
Message-ID: <20170629124908.GV4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 03:56:33PM +0530, Viresh Kumar wrote:
> A typical example of that can be the LCD controller, which is used by
> the bootloaders to show image(s) while the machine is booting into
> Linux. The LCD controller can be using some resources, like clk,
> regulators, etc, that are shared between several devices. These shared
> resources should be programmed so that all the users of them are
> satisfied. If a user (X) driver gets probed before the LCD controller
> driver in this case, then it may end up reconfiguring these resources to
> ranges satisfying the current users (only user X) and that can make the
> LCD screen unstable.

The thing that concerns me most about this is that typically the LCD
controller will be performing DMA to system RAM.

The location of the frame buffer is unknown to the decompressor - and
as the decompressor self-relocates itself (using purely assembly code),
it could relocate itself on top of the frame buffer, causing the "nice"
image to become very colourful.

The decompressor doesn't have the information from DT at that point to
know what are safe locations, so it's up to the boot loader to place
the frame buffer somewhere out of the way.  (If people want to write
a DT parser in position independent ARM assembly code that may change.)

As long as people realise this, then it's not a problem, but given the
number of problems that we've already encountered with boot loaders and
memory space layout, I don't trust them to get this right.

Right now, the ARM kernel booting document requires:

- Quiesce all DMA capable devices so that memory does not get
  corrupted by bogus network packets or disk data. This will save
  you many hours of debug.

so we would need to modify that to make an exception for LCD controllers.
However, we definitely can't have devices left enabled which are capable
of writing to system memory, or which changing system memory is likely
to cause bad effects (eg, packet ring buffers, USB buffers etc, which is
really what the above requirement is about.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
