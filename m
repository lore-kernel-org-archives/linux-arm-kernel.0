From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Wed, 16 Aug 2017 12:39:42 -0700
Subject: [PATCH 2/9] ASoC: cygnus: Update bindings for audio clock changes
In-Reply-To: <20170816105954.ve434zeeqinweo5a@sirena.org.uk>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
 <1502748417-26417-3-git-send-email-lori.hikichi@broadcom.com>
 <20170815171424.whcy4mftex6sgzgj@sirena.org.uk>
 <d7e7144b-26c7-b96a-663d-03744bb60c36@broadcom.com>
 <20170816105954.ve434zeeqinweo5a@sirena.org.uk>
Message-ID: <8c2fc92d-5ea8-8163-a588-0a4cba55e0f8@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 8/16/2017 3:59 AM, Mark Brown wrote:
> On Tue, Aug 15, 2017 at 12:29:44PM -0700, Lori Hikichi wrote:
>
>> I have put the mux assignment in DT because the assignment is a
>> static property and did not need run time programmability from the
>> machine driver.
> Why is this a static property, what prevents something wanting to change
> things at runtime?  You might be running with simpler setups now but
> perhaps you'll run into a more complex use case later?
The short answer is I have analyzed the possible use cases for Cygnus'
audio block, and nothing should need to change the assignments at
runtime.  The longer explanation follows.

The clocking configuration is this. There is one pll with its output run
through 3 post dividers. The audio ports can select one of these
outputs.  There are only 5 possible consumers of these 3 clocks.
The 3 i2s/tdm ports, 1 spdif port, and an exceptional case of another
"non-audio" IP block. For the i2s/tdm ports this clock is the MCLK.

By far the most common usage case for Cygnus is a configuration which
uses only the three i2s/tdm ports. In this case each port is assigned
a clock.  Each clock has the same capabilities so there would never be
a reason change the static mapping.

Now for the case when the "non-audio block" uses one of these clocks.
In this situation we will only need one i2s port because this
configuration of the chip is not audio intensive.  When the system
is designed we know if this non-audio block will be in use, it is not
a runtime configurable thing. Again, a static mapping is fine.

The only situation which could get more complex is with SPDIF.
First off, the SPDIF port is not actively used in any current
configuration and I do not think there are any plans for it to be used.
But, we are talking about possible future configurations.  The only
limitation the current static scheme would introduce is if SPDIF is
active along with all 3 i2s ports. Additionally, all 3 of the i2s ports
would need to be in master mode (slave mode would free up a clock for
SPDIF). In this case, two of the clock consumers would need to share a
clock. In this situation I envisioned that both consumers would agree on
a fixed rate and work within those limitation.  For example, the ports
would choose 24.576 MHz as their mclk and be limited to the the frame
rates that could be derived from that clock. 

At the time it did not seem necessary to make addition driver changes to
support a use case that will very likely never arise. As it turns out,
we are working on a new version of this audio block.  The clocking
configuration for this new version is more complex and I am already in
the process of creating clock bindings for all this this. I am hopeful
that the driver for this new version will be applicable to Cygnus.

Lori.
