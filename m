From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 24 Aug 2011 20:54:55 +0200
Subject: [alsa-devel] [PATCH v2 1/1] ASoC: soc-core: check rate for
	symmetry only when pcm is active
In-Reply-To: <20110824172703.GF16653@opensource.wolfsonmicro.com>
References: <1314183728-23627-1-git-send-email-b29396@freescale.com>
	<4E5520CE.60204@ti.com> <4E552F5F.9070801@metafoo.de>
	<20110824172703.GF16653@opensource.wolfsonmicro.com>
Message-ID: <4E5548FF.1030709@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2011 07:27 PM, Mark Brown wrote:
> On Wed, Aug 24, 2011 at 07:05:35PM +0200, Lars-Peter Clausen wrote:
> 
>> A more sensible solution would in my opinion be to save the current rate in the
>> dai struct itself and not in the pcm struct. Upon opening a stream check for
>> cpu and codec DAI whether they require symmetry. If they do and are active
>> constraint the rate to DAIs rate. This also ensures that if boths DAIs are
>> already active and are running at different rates there will be no valid rate
>> for the new stream.
> 
> We need to store in all three places I think - the symmetry requirement
> can also come from the link itself.  But generally this is what we're
> actually looking for, yes.

It should be sufficient to just store the rate for the cpu and codec DAI.
Though the rate constraint should be applied if either the DAI or the link
wants symmetric rates.
