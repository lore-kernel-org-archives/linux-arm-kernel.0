From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 28 Aug 2013 10:33:34 -0600
Subject: [PATCH 01/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
In-Reply-To: <20130828120801.GC2348@localhost>
References: <1377614079-10000-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130827163939.24636d80@skate> <20130827151136.GA10084@localhost>
 <20130827152535.GG19598@titan.lakedaemon.net>
 <20130827191337.GA2339@localhost> <521D063F.4040404@gmail.com>
 <20130827210248.GA19625@obsidianresearch.com>
 <20130827221729.GA25413@localhost>
 <20130827222532.GA1632@obsidianresearch.com>
 <20130828120801.GC2348@localhost>
Message-ID: <20130828163334.GB31381@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 28, 2013 at 09:08:02AM -0300, Ezequiel Garcia wrote:

> Hm.. but in order to make this work, we need the bridge interrupt
> controller introduced by Sebastian, but not available in the "older"
> platforms (right?).

TBH, I'm not sure of the state of this - I thought the last patches I
saw covered everything (though perhaps DT bindings are needed for some
platforms)?

Some platforms don't have a bridge cause register, the WDT comes
directly off the main interrupt controller and the write to a 'bridge
cause regsiter' in the wdt driver is already completely bogus. This is
why the irq chip driver needs to take care of this.

> So, in order to add support to Armada 370/XP watchdog (which was the
> initial goal of all of this) I think our sane option reduce to two:
> 
> * Drop watchdog support on non-DT platforms and add support for
>   A370/XP in the orion-wdt driver.
>   I don't quite like the idea of dropping support on anything,
>   so I can't say I'm thrilled by this idea.

Well, can you pass all the register addresess and interrupts in
through platform_data on these unconverted boards?

Maybe a config switch 'CONFIG_ARMADA_WATCHDOG_SINGLE_PLATFORM' to
enable the old behavior and include the mach headers, otherwise the
driver is multiplatform and DT only?

But I don't see alot of value in doing this work, since I doubt anyone
will ever use it :(

> * Support A370/AXP in a different and new armada-wdt driver.
>   The differences between the SoC might be small, but maybe
>   enough to justify a separate driver and avoid more problems.

But A370/AXP isn't really different, it just doesn't have to be
compatible with boards that haven't finished DT conversion..

Jason
