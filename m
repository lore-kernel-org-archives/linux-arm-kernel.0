From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Jan 2017 16:26:45 +0100
Subject: [PATCH 15/20] ARM/hw_breakpoint: Convert to hotplug state machine
In-Reply-To: <20170104135644.GA29212@leverpostej>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
 <20161117183541.8588-16-bigeasy@linutronix.de>
 <CACRpkdZE+h0+3EizLCMUr-e-4pv4w9iAatSqL8k0Ovd2iUaS8Q@mail.gmail.com>
 <CACRpkda2gdjM--LSoJTL0dvqyw796w1hMSAhUQwv9X0EPzJHig@mail.gmail.com>
 <20170102150015.GJ14217@n2100.armlinux.org.uk>
 <CACRpkdaxAPSU-XPQrgVRoBecAD1ZpVVP4qPe59af-yy11WqBQw@mail.gmail.com>
 <20170103093335.GA5605@leverpostej> <20170104135644.GA29212@leverpostej>
Message-ID: <CACRpkdYCG71AUe9iBdV+2t_LNFSzYO18vM=-pa=jWDTT53FnwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2017 at 2:56 PM, Mark Rutland <mark.rutland@arm.com> wrote:

> I've just reproduced this locally on my dragonboard APQ8060.

Sweet!

> It looks like the write_wb_reg() call that's exploding is from
> get_max_wp_len(), which we call immediately after registering the
> dbg_reset_online callback. Clearing DBGPRSR.SPD before the write_wb_reg() hides
> the problem, so I suspect we're seeing the issue I mentioned above -- it just
> so happens that we go idle in a new place.
>
> The below hack allows boot to continue, but is not a real fix. I'm not
> immediately sure what to do.

Me neither. But Will's suggestion to simply blacklist this chip might be
best.

> Linus, I wasn't able to get ethernet working. Do I need anything on top
> of v4.10-rc2 && multi_v7_defconfig?

I haven't tried it with multi_v7 but I should probably try that and patch
up the defconfigs, those are probably the root of the problem.

I do this on top of qcom_defconfig:

scripts/config --file .config \
        --enable QCOM_EBI2 \
        --enable ETHERNET \
        --enable NET_VENDOR_SMSC \
        --enable SMSC911X

Maybe you are missing the EBI2 config?

Yours,
Linus Walleij
