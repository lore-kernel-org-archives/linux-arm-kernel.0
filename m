From: andrew-ct.chen@mediatek.com (andrew-ct chen)
Date: Mon, 30 Nov 2015 19:43:39 +0800
Subject: [RESEND RFC/PATCH 3/8] media: platform: mtk-vpu: Support
 Mediatek VPU
In-Reply-To: <56584AC5.7020704@linaro.org>
References: <1447764885-23100-1-git-send-email-tiffany.lin@mediatek.com>
 <1447764885-23100-4-git-send-email-tiffany.lin@mediatek.com>
 <5655DDB4.2080002@linaro.org> <1448626209.7734.26.camel@mtksdaap41>
 <56584AC5.7020704@linaro.org>
Message-ID: <1448883819.15961.7.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-11-27 at 12:21 +0000, Daniel Thompson wrote:
> On 27/11/15 12:10, andrew-ct chen wrote:
> >>> +
> >>> > >+	memcpy((void *)send_obj->share_buf, buf, len);
> >>> > >+	send_obj->len = len;
> >>> > >+	send_obj->id = id;
> >>> > >+	vpu_cfg_writel(vpu, 0x1, HOST_TO_VPU);
> >>> > >+
> >>> > >+	/* Wait until VPU receives the command */
> >>> > >+	timeout = jiffies + msecs_to_jiffies(IPI_TIMEOUT_MS);
> >>> > >+	do {
> >>> > >+		if (time_after(jiffies, timeout)) {
> >>> > >+			dev_err(vpu->dev, "vpu_ipi_send: IPI timeout!\n");
> >>> > >+			return -EIO;
> >>> > >+		}
> >>> > >+	} while (vpu_cfg_readl(vpu, HOST_TO_VPU));
> >> >
> >> >Do we need to busy wait every time we communicate with the co-processor?
> >> >Couldn't we put this wait*before*  we write to HOST_TO_VPU above.
> >> >
> >> >That way we only spin when there is a need to.
> >> >
> > Since the hardware VPU only allows that one client sends the command to
> > it each time.
> > We need the wait to make sure VPU accepted the command and cleared the
> > interrupt and then the next command would be served.
> 
> I understand that the VPU  can only have on message outstanding at once.
> 
> I just wonder why we busy wait *after* sending the first command rather 
> than *before* sending the second one.

No other special reasons. Just send one command and wait until VPU gets
the command. Then, I think this wait also can be put before we write to
HOST_TO_VPU.Is this better than former? May I know the reason?


> 
> Streamed decode/encode typically ends up being rate controlled by 
> capture or display meaning that in these cases we don't need to busy 
> wait at all (because by the time we send the next frame the VPU has 
> already accepted the previous message).

For now, only one device "encoder" exists, it is true.
But, we'll have encoder and decoder devices, the decode and encode
requested to VPU are simultaneous.
Is this supposed to be removed for this patches and we can add it back
if the another device(decoder) is ready for review?


Andrew


> 
> 
> Daniel.
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
