From: arnaud.pouliquen@st.com (Arnaud Pouliquen)
Date: Wed, 15 Feb 2017 14:59:18 +0100
Subject: [RFC v2 4/7] ASoC: dmaengine_pcm: add copy support
In-Reply-To: <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
 <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
Message-ID: <40633f7c-a2ac-1658-cc9d-b30eaff8a95a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 02/14/2017 06:16 PM, Mark Brown wrote:
> On Mon, Feb 13, 2017 at 05:38:26PM +0100, Arnaud Pouliquen wrote:
>> From: olivier moysan <olivier.moysan@st.com>
>> 
>> Add copy support in pcm damengine operations. As example, this
>> allows to: - process data before rendering (IEC status
>> insertion), - process captured sample ( sample mask and shift).
> 
> dmaengine with copy...  so not DMA at all?  I'm a bit confused
> about why we're extending the dmaengine code to have a copy
> operation rather than just writing driver code.
> 

For DFSDM we need to re-arrange samples after DMA transfer, before
sending them to application.
For this, a copy ops(called in snd_pcm_lib_read_transfer) alreday exists
in snd_pcm_ops struct.
This ops is not available at soc dma engine level, so at ASoC driver
level.
Aim of this patch is to expose the copy in driver. DMA is still used,
copy ops just allows to handle the copy_to_user in driver.
Advantage of this add-on is that we still able to take benefice of the
generic DMA in DFSDM driver.
Now if you estimate that it is too stm32 SOC specific, the other
solution is to handle directly the PCM platform device in DFSDM driver.

Regards
Arnaud
