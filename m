From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Jan 2015 17:48:45 +0000
Subject: [PATCH 1/2] mmc: core: use card pointer as the first parameter
 of execute_tuning()
In-Reply-To: <CAD=FV=X9x0gW5TyLi4ERm8nxixQB__Y=5bRAtOax-_w+T33rCg@mail.gmail.com>
References: <1422271175-19445-1-git-send-email-addy.ke@rock-chips.com>
 <1422271175-19445-2-git-send-email-addy.ke@rock-chips.com>
 <CAPDyKFp=5epMggHu0+u_LU7ETujcoeP2xOpB7iD6JF2bs8BnEA@mail.gmail.com>
 <CAD=FV=X9x0gW5TyLi4ERm8nxixQB__Y=5bRAtOax-_w+T33rCg@mail.gmail.com>
Message-ID: <20150126174845.GJ26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 09:45:07AM -0800, Doug Anderson wrote:
> Ulf,
> 
> On Mon, Jan 26, 2015 at 7:15 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On 26 January 2015 at 12:19, Addy Ke <addy.ke@rock-chips.com> wrote:
> >> We need to take the card pointer in execute_tuning() for mmc_send_status(),
> >
> > mmc_send_status() is an mmc core function, not intended for host's to call.
> >
> >> but mmc->card is NULL in tuning state. So we need change the first parameter
> >> of execute_tuning() to card pointer(struct mmc_card * card).
> >
> > So, why do we need this?
> 
> I asked Addy to post upstream against mmc_send_tuning(), but I guess
> he didn't (he posted against Alex's NAKed patch instead).
> 
> ...when I talked to him about it, Addy was asserting that when tuning
> fails it is important (at least on dw_mmc on rk3288) that we wait for
> the card to stop being busy and that the way to detect was using
> mmc_send_status().
> 
> That would mean that against upstream you'd need to change
> mmc_send_tuning() to take in the card as well (or move the "host->card
> = card" assignment to before UHS init, which seems less desirable?)
> 
> What do you think about that?  Is there a better solution?

That sounds like a generic thing though - in which case, what do the
specs have to say on this, and does the code implement what it says?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
