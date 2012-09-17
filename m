From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Sep 2012 10:45:15 +0200
Subject: [PATCH v4 03/10] pinctrl: mvebu: kirkwood pinctrl driver
In-Reply-To: <50559737.8000705@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20120916074652.GM28177@lunn.ch> <50559737.8000705@gmail.com>
Message-ID: <CACRpkdY-Nyn73EJLvE1RsL4hgMRm6hALtnS-eKAXU7edot2V9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 16, 2012 at 11:09 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> On 09/16/2012 09:46 AM, Andrew Lunn wrote:

>> Here you are suggesting we have to put into the DT what chip we expect
>> to be on.
>>
>> What is the advantage of this, over getting the information from the
>> device itself?
>
> If there are no objections from the others, I agree to determine the
> variant from the existing kirkwood_id(). I was just unsure if it is
> ok to use platform-specific code with DT here.
>
> Any ideas how to get kirkwood_id() linked into pinctrl-kirkwood with
> the get-rid-of-arch-includes policy?

You found the weak spot between two consolidation tracks.

Getting rid of a broadcast autodetect functions from say
<mach/foo-id-probe.h> is nominally done by passing the data
to the driver as platform data instead, and only using
these functions in the mach-foo folder when populating
platform data, and thus it can be made into a local
header, say mach-foo/foo-id-probe.h

So the machine/arch code reads these registers to
populate the platform data and device drivers only
look at the platform data, which has some enum or
bool indicating what hardware it's running on, cool.

But according to the other consolidation track, platform
data should go into device tree bindings.

So the conclusion is that the DT must contain the data
about the platform, so it's not auto-probed by the kernel.
(I.e. the kernel reads no registers to figure out what hardware
this is, that stuff comes from the device tree.)

DT purists will say that the boot loader should ask the chipset
what it is with the same register writes and populate the
DT accordingly, instead of loading a precompiled blob.
Some may even ponder the crazy concept of amending the
DT in the kernel at early boot.

But in practice someone will give up, encode the stuff in
the static device tree and autoprobing of the platform
goes out the window.

Yours,
Linus Walleij
