From: lars@metafoo.de (Lars-Peter Clausen)
Date: Fri, 22 Mar 2013 12:39:49 +0100
Subject: [alsa-devel] [PATCH 0/2] ASoC: dmaengine_pcm: support generic
 DMA binding users
In-Reply-To: <20130322113056.GA4977@n2100.arm.linux.org.uk>
References: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
 <20130321023858.GD6281@S2101-09.ap.freescale.net> <514B21F3.90803@metafoo.de>
 <20130321152206.GA14768@opensource.wolfsonmicro.com>
 <514B34AB.1080107@metafoo.de> <20130322113056.GA4977@n2100.arm.linux.org.uk>
Message-ID: <514C4305.8030803@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2013 12:30 PM, Russell King - ARM Linux wrote:
> On Thu, Mar 21, 2013 at 05:26:19PM +0100, Lars-Peter Clausen wrote:
>> The problem with the current library is that we don't know yet which
>> dmaengine device is going to be used by the time we pre-allocate the
>> audio buffers, since the DMA filter parameters often are provided by
>> the DAI driver.
> 
> That's not really a problem.  The CPU DAI can provide the data via
> the playback_dma_data and capture_dma_data pointers, which the ASoC
> DMA engine driver can pick up on when it initializes.  This data can
> contain everything that the ASoC DMA engine driver needs.

Yes and no. Unfortunately it doesn't work for all drivers. But yes that's
the way I want to move forward for the non dt case. Let the channels be
requested in the pcm_new callback.

> 
> Where my driver falls down is if you need to reconfigure the DMA engine
> later - it doesn't provide an API for that, but that's trivially easy
> to augment the API.
> 
> If you want to look at what I did for sa11x0 Assabet platforms, it's
> still all here:
> 
> http://ftp.arm.linux.org.uk/git/gitweb.cgi?p=linux-arm.git;a=shortlog;h=2f03d47
> 
> As you will see from the dates, it's over a year old now - the only
> thing I do with it is occasionally rebase it to bring it up to a more
> modern kernel.
