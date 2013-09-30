From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 30 Sep 2013 15:44:05 -0600
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet ge0
 and ge1 clocks
In-Reply-To: <20130930213437.GG6735@lunn.ch>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130930213131.GB10393@obsidianresearch.com>
 <20130930213437.GG6735@lunn.ch>
Message-ID: <20130930214405.GA11808@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 11:34:37PM +0200, Andrew Lunn wrote:

> > Our bootloader gates the power and turns off the clock, having Linux
> > turn the clock back on without knowing how to control the power seems
> > like a possible problem.
> 
> This patch won't do that. This patch will stop it getting turn off. It
> will never turn it on. The only thing that will turn it on is the
> Ethernet driver. So if the bootloader turned it off, it should stay
> off.

Ok, that sounds good.

> The pseudo code looks nice, but i think in reality, the
> of_add_property(np, {"local-mac-address" = address}); is not so
> simple. Sebastian took a look at this.

Oh? I though it was just this:

struct Tmp
{
    struct property prop;
    u8 mac[6];
};

struct Tmp *prop = kzalloc(sizeof(struct Tmp));
prop->prop.name = "local-mac-address";
prop->prop.length = sizeof(prop->mac);
prop->prop.value = prop->mac;
prop->mac = (...);
of_add_property(np, &prop->prop);

That is basically what other stuff in the kernel does, at least.

Jason
