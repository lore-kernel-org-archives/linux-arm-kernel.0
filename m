From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 16 May 2012 21:52:05 +0530
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <4FB3D294.4020505@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <CAJe_Zhe-SqDMDGOhrYZtBBJnCYqLR0H07cPKzG4SyUxiLrgFnQ@mail.gmail.com>
 <4FA3F308.6030900@ti.com>
 <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
 <4FB2FEBA.1030404@ti.com>
 <CAJe_ZhcrMycgOWf6EiGEjz25C1ZTkB1W=33Qqp4rFpcq-5QsDg@mail.gmail.com>
 <4FB3A87C.1000000@ti.com> <4FB3CF44.4040603@ti.com>
 <4FB3D294.4020505@wwwdotorg.org>
Message-ID: <CAJe_Zhe6uT7u-+0VEx2XCieuynmK5nOO=4DSpDDS_Q=N8-QtPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 May 2012 21:45, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/16/2012 10:01 AM, Jon Hunter wrote:
> ...
>> By the way, I do see your point. You wish to describe the all the
>> mappings available to all dma controllers and then set a mapping in the
>> device tree. Where as I am simply setting a mapping and do not list all
>> other possibilities (assuming that there some).
>>
>> What is still unclear to me, is if you use this token approach how
>> readable is the device-tree? For example, if you have a client that can
>> use one of two dmac and for each dmac the request/channel number is
>> different, then by using a global token how can I determine what the
>> options available for this client are?
>>
>> Take your example ...
>>
>> mmc1: mmc at 13002000 {
>> ? ? ? ? ...
>> ? ? ? ? dma_tx = <891> ? //some platform-wide unique value
>> ? ? ? ? dma_rx = <927> ? //some platform-wide unique value
>> ? ? ? ? ...
>> };
>
> I believe those properties (in the DMA client) should be completely
> omitted; there's no need for them.
>
> Also, we definitely should not be using "some platform-wide unique
> value", but rather the phandle of the DMA client, plus some
> client-defined client channel ID. ...
>
> (oh, and - rather than _ is idiomatic for DT property names)
>
>> DMAC's Node:-
>>
>> pdma2: pdma at 10800000 {
>> ? ? ? ? ?.......
>> ? ? ? dma_map = <891, 7>, ? ? ? // Map mmc1_tx onto i/f 7
>> ? ? ? ? ? ? ? ? <927, 8>, ? ? ? // Map mmc1_rx onto i/f 8
>> ? ? ? .......
>> };
>
> So this would become:
>
> pdma2: pdma at 10800000 {
> ? ? ? ?.......
> ? ? ? ?dma-map =
> ? ? ? ? ? ? ? ?... entries for channels 0.. 6
> ? ? ? ? ? ? ? ?<&mmc1, 0>, ? ? ? // Map mmc1_tx onto i/f 7
> ? ? ? ? ? ? ? ?<&mmc1, 1>, ? ? ? // Map mmc1_rx onto i/f 8
> ? ? ? ? ? ? ? ?... ;
> ? ? ? ?.......
> };
>
> This (a) follows existing DT practice of using phandle + specifier, and
> (b) makes it easy to know exactly what clients you're talking about,
> since all you need to do is search for the label "mmc1" throughout the DT.
>
>> But now I have another dmac which has the following options ...
>>
>> pdma1: pdma at 10000000 {
>> ? ? ? ? ?.......
>> ? ? ? dma_map = <598, 2>, ? ? ? // Map mmc1_tx onto i/f 2
>> ? ? ? ? ? ? ? ? <230, 3>, ? ? ? // Map mmc1_rx onto i/f 3
>> ? ? ? .......
>> };
>
> Which would become something very similar:
>
> pdma1: pdma at 10000000 {
> ? ? ? ?.......
> ? ? ? ?dma-map =
> ? ? ? ? ? ? ? ?... entries for channels 0.. 1
> ? ? ? ? ? ? ? ?<&mmc1, 0>, ? ? ? // Map mmc1_tx onto i/f 2
> ? ? ? ? ? ? ? ?<&mmc1, 1>, ? ? ? // Map mmc1_rx onto i/f 3
> ? ? ? ? ? ? ? ?... ;
> ? ? ? ?.......
> };
>
> Note that dma-map here is describing the list of DMA requests that the
> DMA controller knows about. As far as the binding goes, these are
> irrelevant to channels; only the driver for the DMAC knows whether it
> needs to use a specific channel ID to service a particular DMA request
> signal, or not.
>

OK, my guts feel people might be interested in what's cooking on
my side. I started with the binding text first and then would write
code based upon that approach.

The following might be tweaked as I look deeper into client and DMAC
drivers while deciding upon what the helper functions should be optimally...

-------------------- 8< --------------------


Generic binding to provide a way to provide the client-channel map and
other dmac specific parameters to the dma controller driver

DMA Model:-
  Only the most common characteristics of a dma setup are assumed
in this binding.
Client: Some h/w controller that could request a DMA controller in
the system to perform data transfer on its behalf. Example SPI, MMC,
I2S etc.
DMAC: A DMA Controller instance. Example, PL330, PL08X, SDMA etc.

 The assumed model of the DMAC, in this binding, has P peripheral
interfaces (P request signals) that could request a data transfer
and C physical channels that actually do the data transfers, hence,
at most C out of P peripherals could be served by the DMAC at any
point of time. Usually C := P, but not always. Usually, any of the
physical channels could be employed by the DMAC driver to serve any
client.
 The DMAC driver identifies a client by its i/f number, 'peri_id'
on the given DMAC. For example, TX for SPI has 7th while RX_TX
(half-duplex) for MMC has 10th peripheral interface (request-signal)
on a given DMAC. Usually, any of the physical channels could be
employed by the DMAC driver to serve a client.

* DMA Controller

Required property:

	- #map-cells: Number of elements in each chan-map entry.
		At least 3 elements are required by this binding.

	- chan-map: List of entries that specify clients' 'peri_id'.
		and also possibly DMAC specific per-client data.
		The first element of each entry being the client's
		phandle. The second the direction of data transfer
		w.r.t the client 1 for RX, 2 for TX and  3 for RX|TX.
		The third the 'peri_id' of the client's request signal
		on the DMAC.

Optional properties:

	- #dma-peri-ifs: P, usually the DMAC driver would simply assume the
		number of entries in the 'chan-map' property to be the
		effective number of peripheral request interfaces on the
		DMAC. If specified, it should be at least the number of
		entries in the 'chan-map' property.

	- #dma-channels: C, if specified, it should neither be more than
		the value of 'dma-peri-ifs' nor equal to zero.
		If unspecified,	it is assumed to be equal to the value of
		'dma-peri-ifs', i.e, C := P

	- #private-data: Peculiarities of the DMAC setup, not taken into
		account by this generic model. The decoding of it would
		be private to the DMAC's driver. For ex, some DMAC drivers
		for dmaengine would specify dma_cap_mask_t for the DMAC,
		if they don't need to specify it on a per-client basis
		(i.e, via 4th element of a 'chan-map' entry).

Example:

	dma-controller@0 {
		compatible = "foo,dmac-xxx";
		#private-data = <0x80808080>;
		#dma-peri-ifs = <32>;
		#dma-channels = <8>;
		#map-cells = <3>;
		chan-map =
			<&i2s1 1 2>,     /* peri_id of I2S's RX is 2 */
			<&i2s1 2 3>,     /* peri_id of I2S's TX is 3 */
			<&mmc1 3 5>,  /* peri_id of MMC's RX_TX is 5 */
			<&spi1 1 6>,
			<&spi1 2 8>,
			...;
	};


* Client Controller

Required property: None.
	The client's DT node doesn't need any DMA specifier.
	Typically it would only comment about the data transfer
	direction associated with each of its request signal.
	Preferably also mentioned in the binding.

Optional property: None.

Example:

	i2s1: i2s at 70002800 {
	/* This controller has a request-signal for TX and RX each
	 * i.e, the driver is going to request a channel for RX(1)
	 * and another for TX(2).
	 */
		...
	};

	mmc1: mmci at 05000 {
	/* This controller has only one request-signal which is
	 * common for TX and RX (3), i.e, the mmci driver is
	 * going to request a channel with half-duplex capability.
	 */
		...
	};

---------------------- >8------------------
