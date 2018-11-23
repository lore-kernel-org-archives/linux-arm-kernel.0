From: biao.huang@mediatek.com (biao huang)
Date: Fri, 23 Nov 2018 09:31:16 +0800
Subject: [v5, PATCH 2/2] dt-binding: mediatek-dwmac: add binding
 document for MediaTek MT2712 DWMAC
In-Reply-To: <20181122151932.GD15403@lunn.ch>
References: <1542882521-18874-1-git-send-email-biao.huang@mediatek.com>
 <1542882521-18874-3-git-send-email-biao.huang@mediatek.com>
 <20181122151932.GD15403@lunn.ch>
Message-ID: <1542936676.24219.66.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew,

	Thanks for you remind.

	Sincerely, I respect any comment from any reviewer. If I didn't reply
for any comment, really sorry for that.

	As to this "tx-delay" issue, the following reply in v3 maybe ignored.
	https://lkml.org/lkml/2018/11/19/158

	"the delay time in mediatek dwmac design is not so accurate,
	the current mt2712 and the following ICs will not use the
	same delay design, but will use stages to indicate different
	delay time.
	so maybe "mediatek.tx-delay" represent the delay stage is a
	good choice"

	And to make it clearer here.

	In mt2712, there are two delay macro circuit: named fine-tune and
coarse-tune.
	a. fine-tune, 170+/-50ps per stage, total 32 stages
	b. coarse-tune, 0.55+/-0.2ns per stage, total 32 stages
	If we only consider mt2712, delay in fine-tune select a integer
multiple of 170ps, delay in coarse-tune select a integer multiple of
550ps, for stage 0~31, the delay in fine-tune will not have the same
value with that in coarse-tune.
	OK, It seems the property "fine-tune" can be eliminated .

	But the following ic will not have the same accuracy as mt2712,
and maybe will not have two delay macro circuit to be selected.
	1. assume two delay macro circuit in the following ic,
	fine-tune, 100ps per stage, coarse-tune, 0.55ns per stage,
	if we want delay 2.2ns, fine-tune will get a 22, and coarse-tune get a
4. We can't distinguish which delay macro we are choosing.
	2. assume only one delay macro circuit is used, a similar case as 1
will also increase the complexity of driver.
	Then, we need define more flag property to know which delay macro we
are handling.

	The common things for all delay macro circuit in MediaTek mac design is
the stages, not the accuracy. so if we maintain stage info in "mediatek,
tx-delay", we only need care which stage we should choose.
And for each IC, we will recommend a best stage as a candidate.

	Above is my personal opinion, may be my understanding is wrong,
welcome for further discussion.

	Thanks a lot.

On Thu, 2018-11-22 at 16:19 +0100, Andrew Lunn wrote:
> On Thu, Nov 22, 2018 at 06:28:41PM +0800, Biao Huang wrote:
> > The commit adds the device tree binding documentation for the MediaTek DWMAC
> > found on MediaTek MT2712.
> > 
> > Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> 
> > +Optional properties:
> > +- mediatek,tx-delay: TX clock delay macro value. Range is 0~31. Default is 0.
> > +	It should be defined for rgmii/rgmii-rxid/mii interface.
> > +- mediatek,rx-delay: RX clock delay macro value. Range is 0~31. Default is 0.
> > +	It should be defined for rgmii/rgmii-txid/mii/rmii interface.
> 
> You have received the same feedback at least twice now, from two
> different maintainers, that the delay should be specified in pS, and
> the driver should figure out what values to place into registers.
> 
> You should not ignore feedback like that. If you don't understand the
> feedback, please ask us to explain it. If you don't agree with the
> feedback, you need to argue why you think it is wrong, or why what you
> are doing is better, etc.
> 
> We are here to help, but just ignoring us won't get you anywhere.
> 
> For the moment:
> 
> NACK
> 
> 	Andrew
