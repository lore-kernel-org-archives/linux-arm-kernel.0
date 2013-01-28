From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Jan 2013 15:27:19 -0700
Subject: [PATCH v2 11/27] clk: mvebu: create parent-child relation for
 PCIe clocks on Armada 370
In-Reply-To: <20130128232150.53b56e62@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-12-git-send-email-thomas.petazzoni@free-electrons.com>
 <5106F6EE.4000101@wwwdotorg.org> <20130128232150.53b56e62@skate>
Message-ID: <5106FB47.9000508@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2013 03:21 PM, Thomas Petazzoni wrote:
> Dear Stephen Warren,
> 
> On Mon, 28 Jan 2013 15:08:46 -0700, Stephen Warren wrote:
> 
>> I must admit, I know nothing about struct mvebu_soc_descr, but I'm
>> having a hard time seeing how that code change makes one of those clock
>> a parent of the other, since the pex0 entry doesn't reference anything
>> "pex1"-related, nor vice-versa. Is more explanation in the commit
>> message warranted here?
> 
> See the definition of mvebu_soc_descr:
> 
> struct mvebu_soc_descr {
>         const char *name;
>         const char *parent;
>         int bit_idx;
> };
> 
> It simply registers the pex0 clock with the pex0_en clock as its
> parents. Those clocks are normal gatable clocks, registered with
> clk_register_gate(). This ensures that whenever the pex0 clock is
> enabled, its parent clock pex0_en gets enabled as well.

Oh I see; I was confused by the patch description. The two clocks being
made child/parent are the two clocks for a port, and this relationship
is set up for each port; for some reason I thought there was a
requirement to make one port's clock a child of the other port's clock.
