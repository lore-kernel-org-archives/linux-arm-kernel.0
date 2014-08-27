From: dianders@google.com (Doug Anderson)
Date: Wed, 27 Aug 2014 08:52:50 -0700
Subject: [PATCH V2 3/3] mmc: dw_mmc: Dont cut off vqmmc and vmmc
In-Reply-To: <CAPDyKFpUU643iXVbxuu9Vx1zY0K7x4z-ZxxVEWd+Lsuwp0iA+g@mail.gmail.com>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
 <1408715272-13833-4-git-send-email-yuvaraj.cd@samsung.com>
 <CAPDyKFqz8sGj2td=ihZXN4zvAqmu9FHZjWdCn-ZRcdHugNHe2g@mail.gmail.com>
 <CAPz6YkXH1mMOTwcLkKdffdUHN+TaCAhpa8oG0h+rFn9i+GMoCw@mail.gmail.com>
 <CAPDyKFqp7oEt9ASmdxrgUwbQ8aTZzAuJ7uD1oGN50iuzPzBfVg@mail.gmail.com>
 <CAD=FV=VQWzhiSU+iULACj+Dp_tDf3SszQ8ELLEGqVEyJJRQy1Q@mail.gmail.com>
 <CAPDyKFo9-5=uPqD8RvLGsYtSCynBFnGGeSCpwLZuzDtW+652hA@mail.gmail.com>
 <CAD=FV=VveHTYmiBu42DJeFFGARV2+1bS6Y2CQM995YkX_O9SQA@mail.gmail.com>
 <CAPDyKFpUU643iXVbxuu9Vx1zY0K7x4z-ZxxVEWd+Lsuwp0iA+g@mail.gmail.com>
Message-ID: <CAD=FV=Vqz=kA=D5KDyq_QuPi-6B05VixYManTsFe2PC-fzxRkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf,

On Wed, Aug 27, 2014 at 4:17 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> Now, we've got MMC_CAP_NEEDS_POLL, so dw_mmc will periodically be
>> called to check the card detect line, but with vmmc and vqmmc off.  It
>> will be unable to return a sensible value without actually turning on
>> vmmc and vqmmc.
>
> Currently MMC_CAP_NEEDS_POLL mean the mmc rescan work will reschedule
> itself with HZ interval. This to check for card insert/removal.
>
> Now, mmc_rescan() will, if present, invoke host's ->get_cd() callback
> to check whether it's worth to continue initialization sequence or if
> it should re-schedule itself again.
>
> If your host driver can distinguish whether a card is inserted, which
> in this case are when vccq is turned off, your ->get_cd() callback need
> to return 1. That will allow mmc_rescan() to continue it's
> initialization sequence and do mmc_power_up().

As per my other email, we can't tell whether a card is inserted when
vqmmc is off.

Does this mean that you have removed your objections to a solution
like Yuvaraj has posted?  We still need to break it into two patches
(the core part and the dwmmc part), but otherwise is it OK?  I can
post the original patch I sent Yuvaraj if it's helpful (or he can just
include my patch as part 1 of his series).

-Doug
