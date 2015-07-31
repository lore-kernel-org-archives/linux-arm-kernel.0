From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 31 Jul 2015 20:02:40 +0200
Subject: [linux-sunxi] Re: [PATCH 5/5] ARM: dts: sun7i: Add dts file for
 Wits Pro A20 DKT
In-Reply-To: <20150731165655.GG2564@lukather>
References: <1438333194-21181-1-git-send-email-hdegoede@redhat.com>
 <1438333194-21181-6-git-send-email-hdegoede@redhat.com>
 <20150731102028.GE2564@lukather>
 <CAGb2v65TEogqYFAfen1VnOaiepvez5t8Oh+Q=OYsRS_aZUMO3A@mail.gmail.com>
 <20150731165655.GG2564@lukather>
Message-ID: <55BBB840.80107@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 31-07-15 18:56, Maxime Ripard wrote:
> On Fri, Jul 31, 2015 at 06:25:29PM +0800, Chen-Yu Tsai wrote:
>>> Note that it's a bit of a pain for now to support such cases, as
>>> there's nothing to tie something from the DT to an SDIO device. I
>>> don't have a better solution than marking it always-on at the moment,
>>> with a big FIXME comment on top... :/
>>
>> One could use the mmc-pwr-seq stuff. I don't know if it has been
>> extended for multiple GPIOs, not that you would need it in this use
>> case.
>
> It doesn't really improve the situation. It doesn't handle the
> regulators,

The regulator(s) are already handled by the vmmc and vqmcc regulators
of the mmc controller binding.

If more regulators are needed, we can easily extend mmc-pwrseq-simple
to support them, or define a whole new powerseq driver.

 > it doesn't allow the real driver to get its resources
> either, basically, it's just a hack.

Not involving the real driver is by design really, the real driver
cannot bind / have its probe function called until its sdio interface
has been probed which is where the pwrseq driver comes in.

This also allows re-using existing sdio drivers without needing
them to be aware of certain board perculiarities

If a special power on (or suspend) order is nescessary a custom
pwrseq driver can be created for this, even one which is meant
to work in tandem with a specific sdio device driver. The idea
is that the device driver will ask the mmc core to powerdown the
device for powersaving in certain cases (e.g. suspend) and then
the mmc core will call into the powerseq driver.

Granted there may be more complex scenarios where thighter control
over the resources is needed, but for now this seems to work really
well and it is much better then the deadlock we had before were
all solutions were shot down as not flexible enough.

>> Maybe we ought to fix up the other ones, like the CubieTruck and A31
>> Hummingbird?
>
> I'll do it.

Thanks.

Regards,

Hans
