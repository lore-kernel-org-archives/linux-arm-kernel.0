From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 11 Jun 2013 17:08:45 -0600
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <51B7A325.8070108@gmail.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130609014506.GB10027@obsidianresearch.com>
 <20130611135737.GC3996@localhost> <20835253.Agl4DfuI3k@wuerfel>
 <20130611215023.GA12649@obsidianresearch.com>
 <51B7A325.8070108@gmail.com>
Message-ID: <20130611230845.GB13892@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 12:22:29AM +0200, Sebastian Hesselbarth wrote:

> sorry to kick into this thread that late but Ezequiel made me think of
> address windows when asking on IRC. From what I can see from your and
> Arnd's proposal the only real difference is that having it Arnd's way
> allows you to have two or more windows mapped to e.g. devbus with
> totally independent address ranges - while yours requires one large
> window for all child devices?

Sorry, I'm having problems following the possessives in your paragraph
- which things are you comparing?

> Although, not thought to the bare end this could also work and maybe
> reflects the actual hardware more accuate:

I actually posted something like this a time ago, but Arnd's
suggestion to encode the target id in the address seems much clearer,
and more accurate, though a bit more work to parse.

It is 'better' in that the base addresses are in exactly one place -
the ranges of the mbus node. With marvell,mbus-target the base
addreses are strewn everywhere and now are difficult to change.

A main consideration here is that the bootloader needs to update the
base addresses - to support the 0xd0 vs 0xf1 internal-regs base
address issue. So I think that requirement alone is enough to make
marvell,mbus-target undesirable.

> When removing size from marvell,mbus-target above, mbus driver could
> also probe for required max size from the reg properties of the child
> nodes. Arnd already said that mbus isn't "simple-bus" anymore, why
> can't it just walk through the nodes and collect required windows?

With enough restrictions, I think it is pretty easy to parse
marvell,mbus-target, but you can employ the same restrictions to
simplify parsing the 2 cell address format too.

Jason
