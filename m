From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 24 Jan 2012 14:14:27 +0100
Subject: [RFC] IIO LRADC for mach-mxs
In-Reply-To: <201201241408.08083.marek.vasut@gmail.com>
References: <201201241408.08083.marek.vasut@gmail.com>
Message-ID: <20120124131427.GE2609@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 02:08:07PM +0100, Marek Vasut wrote:
> Hi guys,
> 
> I've been playing with a custom mxs board recently and I'd like to tinker with 
> ADC. Well, apparently there was some effort but it died silently.
> 
> Now, there are two approaches how to go about the MXS IIO LRADC. Firstly though, 
> here are some hw details:
> 
> 1) The ADC has 16 channels in total, some dedicated to particular function
> 2) The ADC can sample only up to 8 channels at the same time
> 3) The ADC delay triggers can trigger only up to 4 kinds of sampling for those 
> up to 8 selected channel
> 
> So how should we go about this:
> 
> A) Implement functions, to configure and select a channel at probe-time and then 
> never allow (at runtime) different channel to be selected.
> 
> + Channel configuration is static, passed via plat_data
> + The channels don't need to be reconfigured => when data are demanded, the 
> channel doesn't need to be reconfigured (if it's not configured in one of those 
> 8 options) and the user doesn't need to wait for data.
> - Only 8 channels can be used
> 
> B) Allow channel to be configured on-demand -- when it's value is requested, it 
> is configured (if it's not already) for the particular function.
> 
> + All 16 channels can be used
> - It's clunky and fragile to breakage
> - It's hard to implement good channel replacement algo (replacement as on the 
> delay triggers and on those 8 slots)
> 
> Which way do you consider better ?

CCing Jonathan and the iio-list (as found in MAINTAINERS). They probably
have more experience regardings those scenarios?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120124/ada27f02/attachment.sig>
