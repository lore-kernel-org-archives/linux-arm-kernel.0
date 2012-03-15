From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 15 Mar 2012 21:02:58 +0800
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <4F612319.50302@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
Message-ID: <20120315130253.GA6065@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 06:00:41PM -0500, Timur Tabi wrote:
> Mark Brown wrote:
> 
> > All of which is exactly the same as for any other device and essentially
> > irrelevant to how we define the bindings for the cards.
> 
> So using imx-audio-sgtl5000.txt as an example, you're saying that if I
> have two SSIs, I should do this in my device tree:
> 
> sound1 {
> 	compatible = "fsl,imx51-babbage-sgtl5000",
> 		     "fsl,imx-audio-sgtl5000";
> 	model = "imx51-babbage-sgtl5000";
> 	ssi-controller = <&ssi1>;
> 	audio-codec = <&sgtl5000_1>;
> 	mux-int-port = <1>;
> 	mux-ext-port = <3>;
> };
> 
> sound2 {
> 	compatible = "fsl,imx51-babbage-sgtl5000",
> 		     "fsl,imx-audio-sgtl5000";
> 	model = "imx51-babbage-sgtl5000";
> 	ssi-controller = <&ssi2>;
> 	audio-codec = <&sgtl5000_2>;
> 	mux-int-port = <1>;
> 	mux-ext-port = <3>;
> };
> 
Are you putting an example that has two sgtl5000 codecs connected to
SSI1 and SSI2 on a particular board?

I have never seen a real case for such setup.  Have you actually seen?
I do not even see the need to use two SSI controllers for all imx
platforms I have seen.

The real case I have seen is imx28 saif driver, which has to use two
saif controllers connected to one sgtl5000 to support full-duplex.
I would expect something like below for that machine driver.

sound2 {
	compatible = "fsl,imx28-evk-sgtl5000",
		     "fsl,mxs-audio-sgtl5000";
	model = "imx28-evk-sgtl5000";
	saif-controller = <&saif1, &saif2>;
};

We can have that controller property be a phandle array in the binding.

> >>> The biggest improvement is that the SoC binding knows nothing about the
> >>> card binding at all, cards are completely separate and are free to
> >>> define any binding they choose using any number of on-SoC and off-SoC
> >>> devices.
> > 
> >> Ok, I don't understand that at all.
> > 
> > Do you have some questions about the above?  What is it that you find
> > unclear?   
> 
> What's the difference between an "SoC binding" and a "card binding"?
> 
I guess "SoC binding" means the binding for fsl_ssi while "card
binding" means the binding for imx-sgtl5000 in this particular case.

> > We've been through this *repeatedly*, including in the message you're
> > replying to, and we're still going back to square one every time you
> > decide to start talking about device tree again.  This is frustrating
> > in the extreme.
> 
> I'm sorry you're frustrated, but so am I.

And, so am I :(

I thought you have agreed that we can go for new binding for imx
machine drivers per the discussion you and Mark had on the first
version of the series.  That's why I changed to use the new binding
in v2, and you even had given your ack tag on v2.  Now you are
suddenly against that so strongly.  I really do not understand why.
Can you share your concern regarding to that?  What's the problem
with imx using new binding exactly?

> I still don't understand why
> the binding that I invented for the SSI driver isn't good enough for i.MX.

I guess Mark had made it clear that having "codec-handle" encoded in
ssi node is not as good as what new binding does, having it encoded
in "audio complex" node.

>  The binding and the code was documented and approved a long time ago.
> Why can't we keep the same binding on i.MX,
> to keep the code simpler?

I hardly agree with that.  The PowerPC binding will require:

1. fsl_ssi's probe function needs to trigger machine driver's probe
2. machine driver needs to find ssi's node to access codec-handle

which actually makes it complexer than the new binding.

Anyway, either way works, and I have tried both.  But unfortunately
I still have not made everyone happy.  Are we going to make the series
miss the v3.4 merge window just because of this argument, which does
not make much point to me at all.

-- 
Regards,
Shawn
