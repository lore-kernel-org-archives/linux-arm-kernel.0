From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 13 Jan 2015 12:47:14 +0100
Subject: [PATCH v3] i2c: rk3x: Account for repeated start time requirement
In-Reply-To: <1418924647-23795-1-git-send-email-dianders@chromium.org>
References: <1418924647-23795-1-git-send-email-dianders@chromium.org>
Message-ID: <20150113114714.GD7660@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 09:44:07AM -0800, Doug Anderson wrote:
> On Rockchip I2C the controller drops SDA low slightly too soon to meet
> the "repeated start" requirements.
> 
> From my own experimentation over a number of rates:
>  - controller appears to drop SDA at .875x (7/8) programmed clk high.
>  - controller appears to keep SCL high for 2x programmed clk high.
> 
> The first rule isn't enough to meet tSU;STA requirements in
> Standard-mode on the system I tested on.  The second rule is probably
> enough to meet tHD;STA requirements in nearly all cases (especially
> after accounting for the first), but it doesn't hurt to account for it
> anyway just in case.
> 
> Even though the repeated start requirement only need to be accounted
> for during a small part of the transfer, we'll adjust the timings for
> the whole transfer to meet it.  I believe that adjusting the timings
> in just the right place to switch things up for repeated start would
> require several extra interrupts and that doesn't seem terribly worth
> it.
> 
> With this change and worst case rise/fall times, I see 100kHz i2c
> going to ~85kHz.  With slightly optimized rise/fall (800ns / 50ns) I
> see i2c going to ~89kHz.  Fast-mode isn't affected much because
> tSU;STA is shorter relative to tHD;STA there.
> 
> As part of this change we needed to account for the SDA falling time.
> The specification indicates that this should be the same, but we'll
> follow Designware's lead and add a binding.  Note that we deviate from
> Designware and assign the default SDA falling time to be the same as
> the SCL falling time, which is incredibly likely.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/2cf82651/attachment.sig>
