From: olivier.moysan@st.com (Olivier MOYSAN)
Date: Fri, 15 Dec 2017 15:15:22 +0000
Subject: [RFC PATCH 2/2] ASoC: select sysclk clock from mlck clock
 provider in wm8994 driver
In-Reply-To: <20171214173624.GM9788@sirena.org.uk>
References: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
 <1513270438-18523-3-git-send-email-olivier.moysan@st.com>
 <20171214173624.GM9788@sirena.org.uk>
Message-ID: <43426b67-3546-8422-7fcb-9fa1ff192679@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

Thanks for your comment.

On 12/14/2017 06:36 PM, Mark Brown wrote:
> On Thu, Dec 14, 2017 at 05:53:58PM +0100, Olivier Moysan wrote:
>> When defined in device tree, MCLK1 and MCLK2 are used
>> as sysclk for aif1 and aif2 interfaces respectively.
> 
> That's not a valid assumption as far as I remember?  The AIFs can use
> either MCLK depending on the system configuration I think.
> 

You are right. wm8994 allows to select either MCLK for each AIF.
 From this point of view, the current patch is too limiting.
MCLK information in DT allows to enforce MCLK use, but an additionnal 
information is required to determine AIF MCLK assignment.
Available properties in codec DAI node, such as clocks property, cannot 
help here.

Maybe a DAPM linked to a control is a better way to select AIF source,
When source is not provided by clk_id in wm8994_set_dai_sysclk().
In this case, wm8994_set_dai_sysclk() would only have to check
if clock source is not already set.

Please let me know if this option sounds better to you.

>> If clock rate is let 0, the frequency provided by
>> wm8994_set_dai_sysclk() is used instead.
> 
> I'd expect this the other way around, if we didn't specify a frequency
> then read it from the input otherwise try to use clk_set_rate() to
> propagate things up.
> 

If I implement a control to select the AIF source, I will drop the code
related to mclk clock provider.

Regards
Olivier
