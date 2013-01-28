From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 28 Jan 2013 23:21:50 +0100
Subject: [PATCH v2 11/27] clk: mvebu: create parent-child relation for
 PCIe clocks on Armada 370
In-Reply-To: <5106F6EE.4000101@wwwdotorg.org>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-12-git-send-email-thomas.petazzoni@free-electrons.com>
 <5106F6EE.4000101@wwwdotorg.org>
Message-ID: <20130128232150.53b56e62@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stephen Warren,

On Mon, 28 Jan 2013 15:08:46 -0700, Stephen Warren wrote:

> I must admit, I know nothing about struct mvebu_soc_descr, but I'm
> having a hard time seeing how that code change makes one of those clock
> a parent of the other, since the pex0 entry doesn't reference anything
> "pex1"-related, nor vice-versa. Is more explanation in the commit
> message warranted here?

See the definition of mvebu_soc_descr:

struct mvebu_soc_descr {
        const char *name;
        const char *parent;
        int bit_idx;
};

It simply registers the pex0 clock with the pex0_en clock as its
parents. Those clocks are normal gatable clocks, registered with
clk_register_gate(). This ensures that whenever the pex0 clock is
enabled, its parent clock pex0_en gets enabled as well. We do the same
for SATA clocks on Armada XP, for example:

static const struct mvebu_soc_descr __initconst
armada_xp_gating_descr[] = { { "audio", NULL, 0 },
[...]
        { "sata0lnk", NULL, 14 },
        { "sata0", "sata0lnk", 15 },
[...]
        { "sata1lnk", NULL, 29 },
        { "sata1", "sata1lnk", 30 },
        { }
};

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
