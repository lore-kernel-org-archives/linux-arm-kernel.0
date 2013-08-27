From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 27 Aug 2013 16:25:32 -0600
Subject: [PATCH 01/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
In-Reply-To: <20130827221729.GA25413@localhost>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377614079-10000-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130827163939.24636d80@skate> <20130827151136.GA10084@localhost>
 <20130827152535.GG19598@titan.lakedaemon.net>
 <20130827191337.GA2339@localhost> <521D063F.4040404@gmail.com>
 <20130827210248.GA19625@obsidianresearch.com>
 <20130827221729.GA25413@localhost>
Message-ID: <20130827222532.GA1632@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 07:17:29PM -0300, Ezequiel Garcia wrote:

> The problem is: how do we handle the reset out enable in the watchdog
> driver, while removing the hard-coded register (and hence the mach-header)
> *at the same* time?
> 
> Should we return to the previously proposed idea of putting that
> in the reg property? IOW:
> 
>   watchdog {
>     reg = <timer control>, <rstout>;
>   };
> 
> If we *must* access the rstout register from the watchdog driver,
> and we *cannot* have any mach-xxx headers to find base addresses,
> then the only valid solution is to pass this information from the DT.

Makes sense to me..

I think the need for strong ordering between the timer control and the
rstout registers trumps other considerations.

Ditto for the interrupt, specify the interrupt in the DT, and request
it in the driver. Ensure that the irq driver clears the cause register
bit for an interrupt before attaching an irq (this is fairly standard
irq practice).

Jason
