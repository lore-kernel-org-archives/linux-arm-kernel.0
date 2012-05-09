From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 09 May 2012 14:49:14 +0200
Subject: Cyclic DMA - callback properties and tx_status residue
In-Reply-To: <20120509121945.GT26481@n2100.arm.linux.org.uk>
References: <20120502144555.GA4456@n2100.arm.linux.org.uk>
 <1335974475.1593.20.camel@vkoul-udesk3>
 <20120502162702.GE3548@n2100.arm.linux.org.uk>
 <CACRpkdYTpP_nW+CJiJNPLgU6fXtR6ku3-OQaA4ceYtB3ZM5sqQ@mail.gmail.com>
 <20120509093334.GS26481@n2100.arm.linux.org.uk>
 <20120509111614.GH3955@opensource.wolfsonmicro.com>
 <20120509121945.GT26481@n2100.arm.linux.org.uk>
Message-ID: <4FAA67CA.2050704@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2012 02:19 PM, Russell King - ARM Linux wrote:
> 
>> If we can resolve the issues with reading the current position in
>> dmaengine then this should be fairly simple to address more
>> comprehensively of course, though there will be some hardware imposed
>> limits on what we can do.
> 
> The issue with doing that is it will break existing setups - have a look
> at the various DMA engine implementations of the tx_status method, and
> how many actually set the 'residue' bytes correctly (the answer at the
> moment is none of them do, according to the definition that we've now
> come up with in this thread.)

Due to the modular design of the ALSA dmaengine wrapper we can use two
different pcm_pointer callback implementations for now. One which does the
callback counting and the other which uses tx_status. And than we can switch
the ASoC drivers over, which are known to only use DMA engine
implementations which have a tx_status method with proper residue information.

> 
> This is *exactly* the kind of issues we have with DMA engine at present;
> the implementations are at best poor quality, partly because the API is
> poorly documented and no one has particularly thought about these issues.
> Every DMA engine implementation implements the entire API using its own
> private code, so each one has its own differing behaviour.
> 
> So, really we're not at the point where ASoC maintainers can insist on
> anything of DMA engine at present; we need to get DMA engine stuff sorted
> out so that we have guaranteed API conditions which can be relied upon by
> all users of the API across each DMA engine driver for any particular
> kernel version.

I think having the common ASoC wrapper here really helps to sort this out,
because it forces us to come up with DMA engine drivers which behave in the
same way in regards to their API. Before basically every DMA engine user was
in a SoC specific driver and people would get away with API variations in
their DMA engine drivers, because the user was only expecting to ever see
that one DMA engine with it's specific API.

> 
> [...]
> 
> DMA engine is slowly getting better (mainly through my efforts at trying
> to extract common code, and fix down the API issues) but it needs folk
> with strong and good review skills to ensure that we stop the influx of
> non-conforming code and get that non-conforming code fixed.

I totally agree and quite thankful for the cleanups you've done over the
past few months.
