From: olivier.moysan@st.com (Olivier MOYSAN)
Date: Wed, 20 Dec 2017 12:42:10 +0000
Subject: [RFC PATCH 2/2] ASoC: select sysclk clock from mlck clock
 provider in wm8994 driver
In-Reply-To: <20171219093506.GD8563@sirena.org.uk>
References: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
 <1513270438-18523-3-git-send-email-olivier.moysan@st.com>
 <20171214173624.GM9788@sirena.org.uk>
 <43426b67-3546-8422-7fcb-9fa1ff192679@st.com>
 <20171219093506.GD8563@sirena.org.uk>
Message-ID: <c51bf5a8-27f7-6d76-f4fb-c8884387bdca@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 12/19/2017 10:35 AM, Mark Brown wrote:
> On Fri, Dec 15, 2017 at 03:15:22PM +0000, Olivier MOYSAN wrote:
> 
>> You are right. wm8994 allows to select either MCLK for each AIF.
>>   From this point of view, the current patch is too limiting.
>> MCLK information in DT allows to enforce MCLK use, but an additionnal
>> information is required to determine AIF MCLK assignment.
>> Available properties in codec DAI node, such as clocks property, cannot
>> help here.
> 
>> Maybe a DAPM linked to a control is a better way to select AIF source,
>> When source is not provided by clk_id in wm8994_set_dai_sysclk().
>> In this case, wm8994_set_dai_sysclk() would only have to check
>> if clock source is not already set.
> 
>> Please let me know if this option sounds better to you.
> 
> What are you trying to accomplish here?  You appear to be trying to move
> the system clocking configuration from the machine driver to the CODEC
> which is not how things are supposed to work.
> 

As a generic machine, simple or audio graph cards are not able to manage 
codec clock muxing.
If we exclude the management of muxing through codec controls,
the remaining solution is to handle it fully through clock framework.
The current patch only supports a limited range of muxing capabilities 
of the codec.
To have a full management of the muxing, I think it is necessary to add
a device tree node for each codec interface and to define an aif clock 
in these nodes.
Then parent clock assignment of these aif clocks would allow to handle 
the muxing.

Please, let me known if is this the right direction for you.

BRs
olivier
