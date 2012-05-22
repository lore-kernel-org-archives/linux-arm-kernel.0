From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 22 May 2012 16:58:13 +0300
Subject: [PATCH] clk: Fix race conditions between clk_set_parent() and
 clk_enable()
In-Reply-To: <4FB29E7C.7010606@codeaurora.org>
References: <1336798797-8724-1-git-send-email-skannan@codeaurora.org>
 <4FB29E7C.7010606@codeaurora.org>
Message-ID: <20120522135813.GL8730@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 08:20:44PM +0200, Saravana Kannan wrote:
> On 05/11/2012 09:59 PM, Saravana Kannan wrote:
> > Without this patch, the following race conditions are possible.
> >
> > Race condition 1:
> > * clk-A has two parents - clk-X and clk-Y.
> > * All three are disabled and clk-X is current parent.
> > * Thread A: clk_set_parent(clk-A, clk-Y).
> > * Thread A:<snip execution flow>
> > * Thread A: Grabs enable lock.
> > * Thread A: Sees enable count of clk-A is 0, so doesn't enable clk-Y.
> > * Thread A: Releases enable lock.
> > * Thread B: Calls clk_enable(clk-A), which in turn enables clk-X.
> > * Thread A: Switches clk-A's parent to clk-Y in hardware.
> >
> > clk-A is now enabled in software, but not clocking in hardware.
> >
> > Race condition 2:
> > * clk-A has two parents - clk-X and clk-Y.
> > * All three are disabled and clk-X is current parent.
> > * Thread A: clk_set_parent(clk-A, clk-Y).
> > * Thread A:<snip execution flow>
> > * Thread A: Switches parent in hardware to clk-Y.
> > * Thread A: Grabs enable lock.
> > * Thread A: Sees enable count of clk-A is 0, so doesn't disable clk-X.
> > * Thread A: Releases enable lock.
> > * Thread B: Calls clk_enable(clk-A)
> > * Thread B: Software state still says parent is clk-X.
> > * Thread B: So, enables clk-X and then itself.
> > * Thread A: Updates parent in software state to clk-Y.
> >

This looks correct to me. Is there any usecase where enabling/disabling a
clock would require sleeping but changing the parent would not?

Cheers,

Peter.
