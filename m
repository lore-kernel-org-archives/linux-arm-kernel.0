From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Wed, 21 May 2014 18:05:33 +0900
Subject: [PATCH] mmc: dw_mmc: Make sure we don't get stuck when we get an
 error
In-Reply-To: <CAD=FV=Vtpup1DaAnN1cO4R5CgxMKa0aosw53sj1eKcUPJsEoYg@mail.gmail.com>
References: <1395901126-6141-1-git-send-email-yuvaraj.cd@samsung.com>
 <CAKuRcOL_JVjOfLNspb14kRxcAXjpEwX4WkvmM+izryZbZBE4XA@mail.gmail.com>
 <CAPz6YkVwT0PrcLP1MJy0vVRw811+_7PwsV_ggKxQkqrjOWeWWw@mail.gmail.com>
 <002001cf6c59$b5b5e680$2121b380$%jun@samsung.com>
 <CAD=FV=X=9cTvST5cM=H9H23SMD28cHSExXt3YR=v2AQ6dFJY5w@mail.gmail.com>
 <001b01cf6e67$2183b400$648b1c00$%jun@samsung.com>
 <003a01cf73cd$fa2ee160$ee8ca420$%jun@samsung.com>
 <CAD=FV=Vtpup1DaAnN1cO4R5CgxMKa0aosw53sj1eKcUPJsEoYg@mail.gmail.com>
Message-ID: <000f01cf74d3$d2938b40$77baa1c0$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014, Doug Anderson wrote:
> Seungwon,
> 
> On Mon, May 19, 2014 at 6:51 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> >> > >> >> +                       } else {
> >> > >> >> +                               /*
> >> > >> >> +                                * If we don't have a command complete now we'll
> >> > >> >> +                                * never get one since we just reset everything;
> >> > >> >> +                                * better end the request.
> >> > >> >> +                                *
> >> > >> >> +                                * If we do have a command complete we'll fall
> >> > >> >> +                                * through to the SENDING_STOP command and
> >> > >> >> +                                * everything will be peachy keen.
> >> > >> >> +                                *
> >> > >> >> +                                * TODO: I guess we shouldn't send a stop?
> >
> > Please remove TODO:
> 
> OK
> 
> > We already reset controller in dw_mci_data_complete() through "mmc: dw_mmc: change to use
> recommended reset procedure"?
> > I guess it depends on that patch.
> > Then, we don't need to stop sequence anymore.
> 
> Even without that patch we've still pretty much stopped everything in
> dw_mci_fifo_reset(), so I'm not sure there's any strong dependency.
> ...but in our tree this did land after the patch you mention, so you
> could wait until it lands if you want.
> 
ciu-reset or stop/abort cmd is needed for recovery of controller FSM after getting error.
dw_mci_fifo_reset eventually has ciu-reset from that patch.
I think it's fine to apply after that.

> 
> NOTE: We found that on some machines we were getting warnings after
> enabling tuning and using this patch.  The warnings were benign, but
> we should probably squash the fix into this patch.  See
> <https://chromium-review.googlesource.com/#/c/200652/> for details.
Can it be accessible?

Thanks,
Seungwon Jeon

> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
