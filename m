From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Jun 2014 12:20:21 -0600
Subject: [PATCH] ARM: dts: Add mask-tpm-reset to the device tree
In-Reply-To: <CAD=FV=UUFARvreHdWNsB1O1dEW6nX_E_C92t8Nma0vL=nAT5Rw@mail.gmail.com>
References: <1403774127-21892-1-git-send-email-vikas.sajjan@samsung.com>	<53ABED5B.8010506@samsung.com>	<CAD=FV=Vwgdis6FzJ8MHDwfuohB1kN8Mf--2N=rxGNeAfKjJMig@mail.gmail.com>	<53AD60D7.4040404@gmail.com>	<53AD978D.8060703@wwwdotorg.org>
 <CAD=FV=UUFARvreHdWNsB1O1dEW6nX_E_C92t8Nma0vL=nAT5Rw@mail.gmail.com>
Message-ID: <53ADB5E5.10102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 10:45 AM, Doug Anderson wrote:
> Stephen,
> 
> On Fri, Jun 27, 2014 at 9:10 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> Surely there's a driver (or could be a driver) for the TPM chip, and
>> that driver should have a reset-mask-gpios property, so the driver can
>> call gpio_get() and gpio_set_output() on the GPIO?
>>
>> Faking this out via a not-really-a-regulator or pinctrl hogs seems like
>> an abuse of those features to me.
> 
> This totally doesn't belong in the TPM chip driver.  This is an
> unabashed HACK at the board level.  Without a hog we need a board
> driver for this.
> 
> To be more specific:
> 
> * The TPM needs to be reset when the full system gets reset.  This
> unlocks the TPM and allows certain types of updates by the firmware.
> The firmware then locks the TPM before jumping to the kernel.
> 
> * The TPM is hooked up to the "reset out" line of the CPU so that when
> the system does a warm reset it will reset the TPM.
> 
> * Unfortunately the CPU asserts the "reset out" line when it's
> sleeping (because, of course, sleep is a reset).  This would allow the
> kernel to unlock the TPM which it's not supposed to be able to do.

To me, this does sound precisely like something that should be in the
TPM driver. I guess an overall board driver would be reasonable too,
since the issue probably doesn't to all boards with the TPM.

This kind of thing is *exactly* the kind of thing that's been discussed
in the past re: doing it in pinmux hogs, or GPIO initialization tables
that aren't specific to a driver, and has been rejected. I guess if
people want to change the decisions that's fine, but doing so will open
up the door to all the previously rejected similar use-cases. I'm not
sure how much I care either way, but we really should be consistent
instead of flip-flopping on this kind of issue.

As an aside, why do we even care about this? The kernel clearly can
unlock the TPM simply by failing to set the GPIO up correctly, so at
best this is security through obscurity. If someone actively wanted to
do something bad to the TPM, they'd simply comment out this piece of
code in the kernel. At least that's true with usptream kernels which
aren't validated at all during boot. For a downstream signed kernel,
perhaps this patch makes sense (although I haven't thought about all the
security angles), but then it'd make sense to keep this patch downstream.

> * To solve the problem, it's up to the kernel to "mask" out the reset
> line before going to sleep.  Then it's up to the read only firmware to
> validate that the kernel properly masked the reset before resuming
> from sleep.  If the firmware finds that the kernel cheated and didn't
> mask the reset then it will not resume to the kernel and will instead
> restart the system.
> 
> 
> The above is not beautiful in the least sense.  Getting suspend/resume
> working happened very late in the exynos5250-snow project and the
> above workaround was the best that we could come up with without
> slipping schedules.  It also had the side effect of being less
> expensive than other solutions.  Given that the solution was "proven
> out" for exynos5250-snow, it was kept in place for similar products.
> 
> -Doug
