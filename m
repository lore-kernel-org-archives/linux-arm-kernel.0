From: dianders@chromium.org (Doug Anderson)
Date: Fri, 27 Jun 2014 11:30:07 -0700
Subject: [PATCH] ARM: dts: Add mask-tpm-reset to the device tree
In-Reply-To: <53ADB5E5.10102@wwwdotorg.org>
References: <1403774127-21892-1-git-send-email-vikas.sajjan@samsung.com>
 <53ABED5B.8010506@samsung.com>
 <CAD=FV=Vwgdis6FzJ8MHDwfuohB1kN8Mf--2N=rxGNeAfKjJMig@mail.gmail.com>
 <53AD60D7.4040404@gmail.com> <53AD978D.8060703@wwwdotorg.org>
 <CAD=FV=UUFARvreHdWNsB1O1dEW6nX_E_C92t8Nma0vL=nAT5Rw@mail.gmail.com>
 <53ADB5E5.10102@wwwdotorg.org>
Message-ID: <CAD=FV=XYFy_QpBtFPc-EURXmV9qMMyOkk0Ybhoy5E6r+hXGywA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

On Fri, Jun 27, 2014 at 11:20 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 06/27/2014 10:45 AM, Doug Anderson wrote:
>> Stephen,
>>
>> On Fri, Jun 27, 2014 at 9:10 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> Surely there's a driver (or could be a driver) for the TPM chip, and
>>> that driver should have a reset-mask-gpios property, so the driver can
>>> call gpio_get() and gpio_set_output() on the GPIO?
>>>
>>> Faking this out via a not-really-a-regulator or pinctrl hogs seems like
>>> an abuse of those features to me.
>>
>> This totally doesn't belong in the TPM chip driver.  This is an
>> unabashed HACK at the board level.  Without a hog we need a board
>> driver for this.
>>
>> To be more specific:
>>
>> * The TPM needs to be reset when the full system gets reset.  This
>> unlocks the TPM and allows certain types of updates by the firmware.
>> The firmware then locks the TPM before jumping to the kernel.
>>
>> * The TPM is hooked up to the "reset out" line of the CPU so that when
>> the system does a warm reset it will reset the TPM.
>>
>> * Unfortunately the CPU asserts the "reset out" line when it's
>> sleeping (because, of course, sleep is a reset).  This would allow the
>> kernel to unlock the TPM which it's not supposed to be able to do.
>
> To me, this does sound precisely like something that should be in the
> TPM driver. I guess an overall board driver would be reasonable too,
> since the issue probably doesn't to all boards with the TPM.

Right.  In fact I'd be willing to bet that there are zero other boards
(other than the ChromeOS boards with similar heritage) with this TPM
that do this.  It does seem unfair to burden an Infineon driver with a
board hack when it's something they didn't have anything to do with.

...but if that's the way it has to be then that's the way it has to be...

If consensus is a board driver that's fine too.  It's really all about
coming up with some solution that will make folks happy.


> This kind of thing is *exactly* the kind of thing that's been discussed
> in the past re: doing it in pinmux hogs, or GPIO initialization tables
> that aren't specific to a driver, and has been rejected. I guess if
> people want to change the decisions that's fine, but doing so will open
> up the door to all the previously rejected similar use-cases. I'm not
> sure how much I care either way, but we really should be consistent
> instead of flip-flopping on this kind of issue.
>
> As an aside, why do we even care about this? The kernel clearly can
> unlock the TPM simply by failing to set the GPIO up correctly, so at
> best this is security through obscurity. If someone actively wanted to
> do something bad to the TPM, they'd simply comment out this piece of
> code in the kernel. At least that's true with usptream kernels which
> aren't validated at all during boot. For a downstream signed kernel,
> perhaps this patch makes sense (although I haven't thought about all the
> security angles), but then it'd make sense to keep this patch downstream.

Check out the bullet point about the firmware checking for kernel
cheats.  At resume time the chip actually re-loads read only firmware
out of SPI flash (no choice about this).  This read only firmware can
check the state of the mask pin (which is preserved across sleep wake)
to see if the kernel cheated.

-Doug
