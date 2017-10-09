From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Oct 2017 14:03:37 +0200
Subject: iMX6 PCIE IRQ not working with ath9k based Wifi
In-Reply-To: <d20644ba-0e1b-0fb4-41ba-d1d604800382@tubby.org>
References: <348346fa-1d70-1d08-9a32-18b660328e4f@tubby.org>
 <CAK8P3a0bF7=bbWBS9+7uBYp+yGpDUfS_QCX6K4i3WJv9mbgvEA@mail.gmail.com>
 <d20644ba-0e1b-0fb4-41ba-d1d604800382@tubby.org>
Message-ID: <CAK8P3a0kXf2FFGM+yF=mGEqvQUDf+djK5pW5hDGTSbaXN2w0vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 9, 2017 at 1:56 PM, Mike Tubby <mike@tubby.org> wrote:
> On 10/9/2017 11:19 AM, Arnd Bergmann wrote:

>
> Thanks for your reply.
>
> Here is the output of 'lspic -tv' and 'lspic -v':
>
> root at arm:/boot/uboot# lspci -tv
> -[0000:00]---00.0-[01]----00.0  Qualcomm Atheros AR93xx Wireless Network
> Adapter
> root at arm:/boot/uboot#

Ok, so no bridge, right?

> If I look at the 'Capabilities [50]' on the PCI bridge I see 'Enable+' and
> on the Atheros kernel driver (ath9k) I see 'Enable-' -- this appears to
> suggest a mis-match.

This just means that the host supports MSI in principle, that's not
a problem.

> If I understand correctly the ath9k driver in kernel 4.1.15 we're using
> doesn't enable MSI - so I assume that there is some backwards compatibility
> mode that then is not working because MSI is enabled at the CPU end, and
> hence the patch you referred to is used to turn this off.

> At the same time on the mailing list:
>
> https://www.mail-archive.com/ath9k-devel at lists.ath9k.org/msg14332.html
>
> which is part of:
>
>     https://wireless.wiki.kernel.org/en/users/Drivers/ath9k
>
> there is talk of a patch to the ath9k driver to properly implement MSI in
> the updated driver in kernel 4.6
>
> So, for us the question is which way to head:
>
>     a) disable MSI at the CPU and try to use legacy; or
>
>     b) update the ath9k driver to try and enable MSI ?
>
>
> We will also check the DTS/DTB in case something is mis-assigned.

You can try enabling MSI for debugging, but it shouldn't
be necessary. There is no reason for the driver to enable
MSI here, it would only add more latency to the interrupt
path on this hardware AFAICT.

     Arnd
