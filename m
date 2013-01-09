From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 09 Jan 2013 12:43:38 +0100
Subject: [PATCH v4 0/7] Add fully tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <20130109032305.GA22404@nchen-desktop>
References: <1356591603-23323-1-git-send-email-peter.chen@freescale.com>
 <50EC3AD9.8000109@free-electrons.com> <20130109032305.GA22404@nchen-desktop>
Message-ID: <50ED57EA.6080309@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Thanks for your answer.

On 09/01/2013 04:23, Peter Chen wrote:
> On Tue, Jan 08, 2013 at 04:27:21PM +0100, Maxime Ripard wrote:
>> Hi Peter,
>>
>> On 27/12/2012 07:59, Peter Chen wrote:
>>> (Sorry for update slowly due to long time business trip)
>>>
>>> Changes for v4 mainly for 2/7, 3/7, 4/7, see individual
>>> patch commit for detail.
>>>
>>> This patchset adds fully tested otg id switch function and
>>> vbus connect/disconnect detection for chipidea driver.
>>> The mainly design of id/vbus handling follows msm otg driver.
>>> I hope the msm usb maintainer can have a look of this patchset,
>>> and give some comments, and move the whole msm usb driver to
>>> chipidea framework if possible in the future.
>>>
>>> This patchset is fully tested at i.mx6Q saberlite board.
>>
>> Have you tested it on a 3.8 kernel?
> Hi Maxime,
> 
> I just tested my branch (https://github.com/hzpeterchen/linux-usb)
> It works ok at i.mx6Q saberlite board.
> The version is Linux version 3.8.0-rc2+, and it is based on greg's
> usb-next(top of 102ee001912f67a7701f26a56ef2bcf84fc78028).

Ok, I finally got what's going on.

Commit 09f6ffde introduced a dependency on USB_EHCI_HCD for host mode,
that in turn depends on USB_ARCH_HAS_EHCI, which isn't selected by MXS.
It was thus removing the host mode support when switching from 3.7 to
3.8, and I somehow overlooked that.
Enabling the host mode solved the panic.

> Please always enable both device and host mode for chipidea driver.
> Current code still not consider all things for different mode config,
> like device-only, host-only, otg.  In future, it is supposed to do
> at dts file, and judge probe.

Then isn't the gadget mode configuration option supposed to depends on
the host mode if it's known to be broken otherwise?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
