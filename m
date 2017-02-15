From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Wed, 15 Feb 2017 16:46:44 +0100
Subject: [RFC v2 4/7] ASoC: dmaengine_pcm: add copy support
In-Reply-To: <20170215145341.sntwx7oqyqmw6azv@sirena.org.uk>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
 <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
 <40633f7c-a2ac-1658-cc9d-b30eaff8a95a@st.com>
 <20170215145341.sntwx7oqyqmw6azv@sirena.org.uk>
Message-ID: <338f8db7-2077-626f-986b-b4e3df40469c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/15/2017 03:53 PM, Mark Brown wrote:
> On Wed, Feb 15, 2017 at 02:59:18PM +0100, Arnaud Pouliquen wrote:
> 
>> For DFSDM we need to re-arrange samples after DMA transfer,
>> before sending them to application. For this, a copy ops(called
>> in snd_pcm_lib_read_transfer) alreday exists in snd_pcm_ops
>> struct.
> 
> No, copy() is an alternative to doing DMA rather than something
> that works with DMA.  If you want to have some sort of post
> processing operation it shoudn't be called copy().  It's probably
> worth considering just making a new format and letting userspace
> convert things here.
> 
You mean using a plug-in alsa to do it? this seems not possible with
tiny-alsa...
Without a plug-in, driver will not be compatible with standard audio
application.

I'm newbies in alsa plugin But it seems quite tricky to do it. This
solution means that userspace has to be aware on hardware constraint.
Processing to do is a mask on 8 LSB + a left shift on bits. T shift
value depends on several parameters: the SPI frequency, the sampling
rate and the filter parameters.
That means an alsa control to get scaling, handled by the plugin.

So i would prefer to find a way to do it in driver...

I saw that blackfin driver implements this kind of mechanism
(bf5xx_pcm_copy) to support the TDM mode. if i well understood the code
they process the TDM buffer filled by DMA. Samples are extracted from
the good TDM slots and copied in buffer that will be sent to userland.

Do you think this would be reasonable if i implement something similar
in my driver, without using the soc generic DMA engine?

Regards
Arnaud
