From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 28 Mar 2014 08:48:06 +0100
Subject: [PATCH] i2c: mv64xxx: Fix compilation breakage
In-Reply-To: <20140324094137.GB5416@lukather>
References: <1394204370-22979-1-git-send-email-maxime.ripard@free-electrons.com>
 <CAP=VYLqCmG6fRmPPABoW4xg_tFgGh2pji=f5ML=cBgCu4zZocg@mail.gmail.com>
 <20140321191739.GT27873@lukather> <4177769.XedaQsoUgV@wuerfel>
 <20140324094137.GB5416@lukather>
Message-ID: <20140328074806.GB2708@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > I think there is something wrong with an interface that makes you use
> > IS_ERR_OR_NULL(). If you are calling reset_control_get_optional(), that'
> > should not return an error when there is no reset controller listed
> > in the device tree. We should still have a way to propagate -EPROBE_DEFER,
> > or bail out if there is a reset controller but there is something wrong
> > with it, but otherwise I'd suggest just leaving NULL as a valid pointer
> > in drv_data->rstc and making sure that the reset controller functions
> > can just deal with a NULL argument, so you never have to check it again.
> 
> Actually, it's not the reset framework but the driver itself that
> needs this. The framework will always return an error pointer here,
> but we won't ever call reset_control_get_optional if we are not probed
> with DT, and in that case, we will have NULL is data->rstc, hence why
> we need to use IS_ERR_OR_NULL.
> 
> We should probably fix the reset functions, but maybe that can come
> later so that we have marvell's defconfig fixed?

Yes, let's fix that incrementally.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140328/5c0becee/attachment.sig>
