From: swingboard@gmail.com (swingboard)
Date: Fri, 5 Sep 2014 11:34:57 +0800
Subject: [PATCH 2/8] spi: sirf: request and free cs gpio in setup and
 cleanup callbacks
In-Reply-To: <20140904191954.GO29327@sirena.org.uk>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
 <1409648468-5436-3-git-send-email-Barry.Song@csr.com>
 <20140904191954.GO29327@sirena.org.uk>
Message-ID: <CA+qxAP06x5uHzObuWzmcAjFz4YKHRxxH5FE5cGZYzKQNUsJdyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-09-05 3:19 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Tue, Sep 02, 2014 at 05:01:02PM +0800, Barry Song wrote:
>> From: Qipan Li <Qipan.Li@csr.com>
>>
>> move spi controller's gpio request work out from probe() to spi device
>> register stage, so after spi device register spi controller can deactive
>> device's gpio chipselect. old code can't do it because gpio request has
>> not be done until device register is finised in spi_bitbang_start.
>> and add cleanup function to free CS gpio.
>
> I'm not quite sure I understand the rationale here - as far as I can
> tell this is making the GPIO request happen later not earlier so it's
> not clear to me what the problem this is fixing in the existing code.
> If the goal is to move the request around in the probe function why not
> just move the existing code earlier in probe()?
>
> This also won't interact well with deferred probe, though a better
> solution here would be some kind of deferred device registration and
> typically the link ordering will mean it won't be an issue when
> everything is built in.

As GPIO cs can be high or low validate and the used GPIO pin with
default value may high or low,
it is need do spi device's chipselect invalidation work in spi_setup,
the patch purpose for it.
master->cs_gpios only assigned after spi_bitbang_start and the
function call spi_setup,
if keep the existing code there will result gpio usage before gpio request.
just move gpio request code in spi_sirfsoc_setup before gpio use.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140905/4af903d9/attachment.sig>
