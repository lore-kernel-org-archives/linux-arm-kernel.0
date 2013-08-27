From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 27 Aug 2013 19:17:29 -0300
Subject: [PATCH 01/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
In-Reply-To: <20130827210248.GA19625@obsidianresearch.com>
References: <1377614079-10000-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377614079-10000-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130827163939.24636d80@skate> <20130827151136.GA10084@localhost>
 <20130827152535.GG19598@titan.lakedaemon.net>
 <20130827191337.GA2339@localhost> <521D063F.4040404@gmail.com>
 <20130827210248.GA19625@obsidianresearch.com>
Message-ID: <20130827221729.GA25413@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 03:02:48PM -0600, Jason Gunthorpe wrote:
> On Tue, Aug 27, 2013 at 10:04:15PM +0200, Sebastian Hesselbarth wrote:
> 
> > In the current use of watchdog even for non-DT boards, you do not
> > have to clear the interrupt cause. It will ultimately lead to a
> > reset in any way. Maybe it is not a big deal to remove it now
> > even without non-DT replacement.
> 
> But that is the likely reason..
> 
> AFAIK, to be immune to bootloader left over you must do these steps in
> order:
>  - Gain control of the WDT timer, so that it doesn't trigger
>  - Clear the cause register
>  - Enable the reset out function
> 
> Which is what orion_wdt_start does today.
> 
> If you fiddle with the order you risk creating an errant WDT trigger,
> depending on what the bootloader did.
> 
> eg having cause asserted and then setting the reset out bit will
> reboot the board.
> 
> Hoisting the reset out register write into board code now requires
> that the bootloader left the WDT subsystem in some kind of sane state,
> probably not great..
> 

Hm... that's not nice. And it's just as important as solving the cause
register clear issue.

The problem is: how do we handle the reset out enable in the watchdog
driver, while removing the hard-coded register (and hence the mach-header)
*at the same* time?

Should we return to the previously proposed idea of putting that
in the reg property? IOW:

  watchdog {
    reg = <timer control>, <rstout>;
  };

If we *must* access the rstout register from the watchdog driver,
and we *cannot* have any mach-xxx headers to find base addresses,
then the only valid solution is to pass this information from the DT.

Right?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
