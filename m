From: dianders@chromium.org (Doug Anderson)
Date: Thu, 12 May 2016 19:11:25 -0700
Subject: [PATCH 1/2] Revert "clk: rockchip: reset init state before mmc
 card initialization"
In-Reply-To: <2083095.luTHhmZ9EO@phil>
References: <1463076197-15900-1-git-send-email-dianders@chromium.org>
 <2083095.luTHhmZ9EO@phil>
Message-ID: <CAD=FV=XVMQ025Z-+C4fVQUuof=9wnjvJKr2PtuJhxOVwo7TjSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Thu, May 12, 2016 at 4:41 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Am Donnerstag, 12. Mai 2016, 11:03:16 schrieb Douglas Anderson:
>
> Not sure what the policy is for revert-subjects in the clock-tree, but I
> guess
>
> clk: rockchip: Revert "reset init state before mmc card initialization"
>
> might look nicer?

Sure.  If you want me to re-post with that, let me know.  Else feel
free to fix when applying.


>> This reverts commit 7a03fe6f48f3 ("clk: rockchip: reset init state
>> before mmc card initialization").
>
> I've tested these two patches together with the dw_mmc one and everything
> that worked before still works (tuning on veyron-jerry) and everything that
> didn't work still doesn't work (tuning on firefly [likely a regulator issue]).
>
> And re-checking the code against the TRM I now also see the mask that is to
> short (1 bit in the code vs. the actual 2 bits described in the manual)
>
> [...]
>
>> 1. Just this revert: likely will fix rk3288-veyron eMMC on some devices
>>    + other cases; might break someone with a strange bootloader that
>>    sets the phase to 0 or one that uses delay elements (pretty
>>    unpredicable what would happen in that case).
>> 2. Just dw_mmc patch: fixes everyone.  Effectly the dw_mmc patch will
>>    totally override the broken patch and fix everything.
>> 3. Both patches: fixes everyone.  Once dw_mmc is initting properly then
>>    any defaults from the clock code doesn't mattery.
>
> I'm still trying to make up my mind on how to proceed - aka in which order
> patches should get picked up.
>
> Going with the "if it isn't upstream it doesn't exist" mantra Rob wrote
> somewhere some days ago, taking this revert should not hurt anything, as all
> the non-veyron devices currently don't support any tuning at all.

Note that this patch can still affect devices that don't use tuning.
MMC Hold times are important not just for high speed modes but even
for low speed modes.


> So I'd think except for the issue Shawn was originally trying to fix (for
> some non-mainline board?) it should be possible to take this patch any time
> independently of the dw_mmc part.

Yeah, just not sure.  Shawn: do you know which specific device you
were trying to fix with the original patch?  Is it OK to revert for
now until the dw_mmc patch lands?
