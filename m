From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 May 2016 18:51:02 +0100
Subject: [RFC PATCH 1/3] asm-generic: io: Add exec versions of ioremap
In-Reply-To: <573C7844.5030107@ti.com>
References: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
 <1462830111-28172-2-git-send-email-d-gerlach@ti.com>
 <20160512163759.GW5783@n2100.arm.linux.org.uk>
 <573C7844.5030107@ti.com>
Message-ID: <20160518175102.GX5783@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2016 at 09:12:20AM -0500, Dave Gerlach wrote:
> Ok thank you for the pointer. I agree, the memremap API looks like a better
> fit for this. I think it likely makes the most sense to still add these
> ioremap_exec and ioremap_exec_nocache and then call them through the
> memremap API based on new flags. This will fit into the current use model
> for memremap as it currently uses all of the other ioremap calls internally,
> and doing it how I just described will let this code evolve along with
> memremap.

I would _really_ prefer not to do that.  Why?  Because IO memory does
not have the required properties to be executable.  IO memory is normally
memory which has side effects - and by side effects, I mean reading it
can provoke hardware to perform some action.  You don't want to be
executing from such memory.

So, in my mind, ioremap_exec makes absolutely no sense, and having it
gives people a new interface to abuse - and abuse they will.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
