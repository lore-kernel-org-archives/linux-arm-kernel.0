From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 31 Oct 2013 10:48:10 -0600
Subject: [PATCH v2] PCI: mvebu - Support a bridge with no IO port window
In-Reply-To: <20131031101357.5a56e2d0@skate>
References: <1381868182-8544-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20131031101357.5a56e2d0@skate>
Message-ID: <20131031164810.GA26426@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 10:13:57AM +0100, Thomas Petazzoni wrote:

> Sorry for the delay in testing this, I was busy with kernel summit /
> ELCE. Unfortunately, this patch still causes problems here: it breaks
> usage of I/O region. I have a modified version of the e1000e driver
> that makes it access an I/O region, that I have used for testing that
> I/O handling is at least minimally working. Without your patch, it
> works fine:

No problem, thank you for testing it, I don't have any hardware like
this..

> After debugging, it turns out that the following change is the problem:
> 
> -	if (port->bridge.iolimit < port->bridge.iobase ||
> +	if (port->bridge.iolimit <= port->bridge.iobase ||

Indeed.. I was having problems here because linux was writing 0,0
during discovery to the base,limit registers to 'disable' the IO
window, which triggered a window allocation. So I re-read the PCI
bridge spec (apparently too quickly) and decided 0,0 was OK, and it
should be <=.

However, looking again@the spec - it is very clear, < is the
correct test, and when the values is equal a 4k window should be
created.

So, I wonder if there is a little bug in the Linux discovery code
path, should it write FFFF,0 instead?

In any event, I can respin this patch so it works, I have to drop the
WARN_ON in that routine to accommodate the 0,0 write however.

> window is never created and the pci_ioremap_io() function is never
> called. Reverting this change makes your patch works fine for me.

Great, the next version should be good to go then.

Thanks,
Jason
