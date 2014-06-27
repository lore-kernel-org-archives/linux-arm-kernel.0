From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 27 Jun 2014 13:56:46 -0600
Subject: [PATCH] ARM: dts: Add mask-tpm-reset to the device tree
In-Reply-To: <CAD=FV=XYFy_QpBtFPc-EURXmV9qMMyOkk0Ybhoy5E6r+hXGywA@mail.gmail.com>
References: <1403774127-21892-1-git-send-email-vikas.sajjan@samsung.com>	<53ABED5B.8010506@samsung.com>	<CAD=FV=Vwgdis6FzJ8MHDwfuohB1kN8Mf--2N=rxGNeAfKjJMig@mail.gmail.com>	<53AD60D7.4040404@gmail.com>	<53AD978D.8060703@wwwdotorg.org>	<CAD=FV=UUFARvreHdWNsB1O1dEW6nX_E_C92t8Nma0vL=nAT5Rw@mail.gmail.com>	<53ADB5E5.10102@wwwdotorg.org>
 <CAD=FV=XYFy_QpBtFPc-EURXmV9qMMyOkk0Ybhoy5E6r+hXGywA@mail.gmail.com>
Message-ID: <53ADCC7E.4000703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 12:30 PM, Doug Anderson wrote:
> Stephen,
> 
> On Fri, Jun 27, 2014 at 11:20 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 06/27/2014 10:45 AM, Doug Anderson wrote:
>>> Stephen,
>>>
>>> On Fri, Jun 27, 2014 at 9:10 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>> Surely there's a driver (or could be a driver) for the TPM chip, and
>>>> that driver should have a reset-mask-gpios property, so the driver can
>>>> call gpio_get() and gpio_set_output() on the GPIO?
>>>>
>>>> Faking this out via a not-really-a-regulator or pinctrl hogs seems like
>>>> an abuse of those features to me.
...
>> As an aside, why do we even care about this? The kernel clearly can
>> unlock the TPM simply by failing to set the GPIO up correctly, so at
>> best this is security through obscurity. If someone actively wanted to
>> do something bad to the TPM, they'd simply comment out this piece of
>> code in the kernel. At least that's true with usptream kernels which
>> aren't validated at all during boot. For a downstream signed kernel,
>> perhaps this patch makes sense (although I haven't thought about all the
>> security angles), but then it'd make sense to keep this patch downstream.
> 
> Check out the bullet point about the firmware checking for kernel
> cheats.  At resume time the chip actually re-loads read only firmware
> out of SPI flash (no choice about this).  This read only firmware can
> check the state of the mask pin (which is preserved across sleep wake)
> to see if the kernel cheated.

Ah, that covers the security issues then.

I'd argue that the RO firmware should be setting up GPIOs like this
myself (and the pinmux, from a nice big table), and the kernel simply
not touch it all since it has no direct use for the pin. But I suppose
if the firmware is already baked and read only, that's not possible.
