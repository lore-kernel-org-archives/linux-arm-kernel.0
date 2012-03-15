From: B04825@freescale.com (Tabi Timur-B04825)
Date: Thu, 15 Mar 2012 13:37:06 +0000
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <20120315130253.GA6065@S2101-09.ap.freescale.net>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315130253.GA6065@S2101-09.ap.freescale.net>
Message-ID: <4F61F080.4090800@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:

> Are you putting an example that has two sgtl5000 codecs connected to
> SSI1 and SSI2 on a particular board?

No, this is just a theoretical example.

> I have never seen a real case for such setup.  Have you actually seen?
> I do not even see the need to use two SSI controllers for all imx
> platforms I have seen.

The PowerPC MPC8610 has two SSIs, and I have a hacked up board that has 
both connected to two CS4270s.  This is how I tested multiple SSI support 
in my driver.

Since my driver supports any number of SSIs, I expect any changes to it to 
continue that support.

> The real case I have seen is imx28 saif driver, which has to use two
> saif controllers connected to one sgtl5000 to support full-duplex.
> I would expect something like below for that machine driver.
>
> sound2 {
> 	compatible = "fsl,imx28-evk-sgtl5000",
> 		     "fsl,mxs-audio-sgtl5000";
> 	model = "imx28-evk-sgtl5000";
> 	saif-controller =<&saif1,&saif2>;
> };
>
> We can have that controller property be a phandle array in the binding.

I can see how this style of binding would make it easier to support an 
N-to-M mapping of controllers to codecs.  However, this is not a concern 
for the SSI driver.

> I thought you have agreed that we can go for new binding for imx
> machine drivers per the discussion you and Mark had on the first
> version of the series.  That's why I changed to use the new binding
> in v2, and you even had given your ack tag on v2.  Now you are
> suddenly against that so strongly.  I really do not understand why.
> Can you share your concern regarding to that?  What's the problem
> with imx using new binding exactly?

I admit I may have been too hasty in giving that ACK, because I did not 
take the time to study the binding.  I figured that the new binding was 
superior to what I came up with years ago.

Now that I've studied the binding, I no longer believe that.  I don't 
understand what's so wonderful about the new binding that my driver has to 
support it *and* the old binding.  I think it would be easier if i.MX uses 
the original binding.

>> I still don't understand why
>> the binding that I invented for the SSI driver isn't good enough for i.MX.
>
> I guess Mark had made it clear that having "codec-handle" encoded in
> ssi node is not as good as what new binding does, having it encoded
> in "audio complex" node.

Even if the new binding is "better", I do not see how it's SOOOOO much 
better that my driver has to support it.  The drawback in supporting both 
is the added complexity.

>> Why can't we keep the same binding on i.MX,
>> to keep the code simpler?
>
> I hardly agree with that.  The PowerPC binding will require:
>
> 1. fsl_ssi's probe function needs to trigger machine driver's probe
> 2. machine driver needs to find ssi's node to access codec-handle
>
> which actually makes it complexer than the new binding.

But the driver already does this!  No one's asking you to add the code to 
perform these tasks.  Just use the existing code.

> Anyway, either way works, and I have tried both.  But unfortunately
> I still have not made everyone happy.  Are we going to make the series
> miss the v3.4 merge window just because of this argument, which does
> not make much point to me at all.

I can respect that concern, but at the same time, I still have to push for 
what I believe makes the most sense.

-- 
Timur Tabi
Linux kernel developer at Freescale
