From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 11 Nov 2014 15:21:54 +0100
Subject: [RFC 2/2] regulator: qcom-rpm: Implement RPM assisted disable
In-Reply-To: <1415659966-16200-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1415659966-16200-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <CABxcv=nGyV2F9kYALOhTzmUfO8CC6NEwv4v3SPmrum-bBi-eDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Bjorn,

On Mon, Nov 10, 2014 at 11:52 PM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> Some regulators are used to power e.g. PLLs that clocks the core we're
> running on, so we can't turn them off directly; but we do want them off
> when the core is powered down. To handle this the Qualcomm SoC provides
> a means to specify a "sleep state" for RPM resources that can be
> triggered by the hardware when the cores are brought down.
>

The regulator core already has support to control the state of
regulators when the system enters into a sleep state. Now the generic
regulator DT binding has also been extended to support defining if a
regulator should be "regulator-{on,off}-in-suspend". Please take a
look at the topic/suspend branch [0] in the regulator tree that has
the latest binding.

If that is not enough for your hardware and use case, I've been
working on adding initial and suspend mode for regulators. The latest
series is [1] and the needed bits for the max77802 regulator driver is
[2].

It's always better to use existing functionality if possible, instead
of adding custom per driver DT bindings. So it would be great if you
can take a look to the mentioned patches.

>  Documentation/devicetree/bindings/mfd/qcom-rpm.txt |   28 ++++++++
>  drivers/regulator/qcom_rpm-regulator.c             |   68 +++++++++++++++-----

Against which tree this patch has been developed? afaict
Documentation/devicetree/bindings/mfd/qcom-rpm.txt does not exist even
in the latest for-next [3] branch of the mfd tree.

>
>         #include <dt-bindings/mfd/qcom-rpm.h>

This file doesn't exit either and the regulator driver depends on
MFD_QCOM_RPM which also is not present in mainline.

By looking at the mail archives I see that you posted both the
regulator and mfd driver in the same series [4] but only the regulator
driver was picked by Mark so I guess Lee has to pick the mfd driver in
order to allow the regulator driver to be built.

Best regards,
Javier

[0]: https://git.kernel.org/cgit/linux/kernel/git/broonie/regulator.git/log/?h=topic/suspend
[1]: https://lkml.org/lkml/2014/11/10/325
[2]: https://lkml.org/lkml/2014/11/11/403
[3]: https://git.kernel.org/cgit/linux/kernel/git/lee/mfd.git/log/?h=for-mfd-next
[4]: https://lkml.org/lkml/2014/9/22/731
