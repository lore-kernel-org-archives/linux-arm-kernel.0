From: biao.huang@mediatek.com (biao huang)
Date: Tue, 27 Nov 2018 09:39:29 +0800
Subject: [v5, PATCH 2/2] dt-binding: mediatek-dwmac: add binding
 document for MediaTek MT2712 DWMAC
In-Reply-To: <20181126214626.GA13830@bogus>
References: <1542882521-18874-1-git-send-email-biao.huang@mediatek.com>
 <1542882521-18874-3-git-send-email-biao.huang@mediatek.com>
 <20181122151932.GD15403@lunn.ch> <1542936676.24219.66.camel@mhfsdcap03>
 <20181126214626.GA13830@bogus>
Message-ID: <1543282769.24219.129.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rob,
	Thanks for your comments.
On Mon, 2018-11-26 at 15:46 -0600, Rob Herring wrote:
> On Fri, Nov 23, 2018 at 09:31:16AM +0800, biao huang wrote:
> > Dear Andrew,
> > 
> > 	Thanks for you remind.
> > 
> > 	Sincerely, I respect any comment from any reviewer. If I didn't reply
> > for any comment, really sorry for that.
> > 
> > 	As to this "tx-delay" issue, the following reply in v3 maybe ignored.
> > 	https://lkml.org/lkml/2018/11/19/158
> > 
> > 	"the delay time in mediatek dwmac design is not so accurate,
> > 	the current mt2712 and the following ICs will not use the
> > 	same delay design, but will use stages to indicate different
> > 	delay time.
> > 	so maybe "mediatek.tx-delay" represent the delay stage is a
> > 	good choice"
> > 
> > 	And to make it clearer here.
> > 
> > 	In mt2712, there are two delay macro circuit: named fine-tune and
> > coarse-tune.
> > 	a. fine-tune, 170+/-50ps per stage, total 32 stages
> > 	b. coarse-tune, 0.55+/-0.2ns per stage, total 32 stages
> > 	If we only consider mt2712, delay in fine-tune select a integer
> > multiple of 170ps, delay in coarse-tune select a integer multiple of
> > 550ps, for stage 0~31, the delay in fine-tune will not have the same
> > value with that in coarse-tune.
> > 	OK, It seems the property "fine-tune" can be eliminated .
> > 
> > 	But the following ic will not have the same accuracy as mt2712,
> > and maybe will not have two delay macro circuit to be selected.
> 
> New IC will have new compatible string then. If it is different, then 
> likely these properties would have to change or have different meaning 
> unless you use time.
> 
OK, I'll use tx-delay-ps instead of tx-delay.
> > 	1. assume two delay macro circuit in the following ic,
> > 	fine-tune, 100ps per stage, coarse-tune, 0.55ns per stage,
> > 	if we want delay 2.2ns, fine-tune will get a 22, and coarse-tune get a
> > 4. We can't distinguish which delay macro we are choosing.
> 
> Why wouldn't you just choose fine-tune for anything less than the max 
> range (3200ps in this example) and course for greater than 3100ps.
> 
The fine-tune circuit and coarse-tune circuit are parallel, and
fine-tuen is a select switch.
It depends on users to choose which circuit is take effect.
I shouldn't assume users would choose fine-tune when delay < 3200ps, and
coarse for > 3100ps.

so, tx-delay-ps will be chosen, and "fine-tune" boolean property should
be remained as a indicator.
> > 	2. assume only one delay macro circuit is used, a similar case as 1
> > will also increase the complexity of driver.
> > 	Then, we need define more flag property to know which delay macro we
> > are handling.
> > 
> > 	The common things for all delay macro circuit in MediaTek mac design is
> > the stages, not the accuracy. so if we maintain stage info in "mediatek,
> > tx-delay", we only need care which stage we should choose.
> > And for each IC, we will recommend a best stage as a candidate.
> 
> What if you had a 3rd delay circuit?
> 
OK, tx-delay-ps will be a meaningful property.
If more delay circuit is added, fine-tune property(boolean --> u32) can
still be a indicator.
> > 	Above is my personal opinion, may be my understanding is wrong,
> > welcome for further discussion.
> > 
> > 	Thanks a lot.
