From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 24 Jan 2012 14:08:07 +0100
Subject: [RFC] IIO LRADC for mach-mxs
Message-ID: <201201241408.08083.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

I've been playing with a custom mxs board recently and I'd like to tinker with 
ADC. Well, apparently there was some effort but it died silently.

Now, there are two approaches how to go about the MXS IIO LRADC. Firstly though, 
here are some hw details:

1) The ADC has 16 channels in total, some dedicated to particular function
2) The ADC can sample only up to 8 channels at the same time
3) The ADC delay triggers can trigger only up to 4 kinds of sampling for those 
up to 8 selected channel

So how should we go about this:

A) Implement functions, to configure and select a channel at probe-time and then 
never allow (at runtime) different channel to be selected.

+ Channel configuration is static, passed via plat_data
+ The channels don't need to be reconfigured => when data are demanded, the 
channel doesn't need to be reconfigured (if it's not configured in one of those 
8 options) and the user doesn't need to wait for data.
- Only 8 channels can be used

B) Allow channel to be configured on-demand -- when it's value is requested, it 
is configured (if it's not already) for the particular function.

+ All 16 channels can be used
- It's clunky and fragile to breakage
- It's hard to implement good channel replacement algo (replacement as on the 
delay triggers and on those 8 slots)

Which way do you consider better ?

M
