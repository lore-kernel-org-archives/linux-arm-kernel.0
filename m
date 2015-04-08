From: lhikichi@broadcom.com (Lori Hikichi)
Date: Tue, 7 Apr 2015 19:28:40 -0700
Subject: [PATCH 0/2] Cygnus Audio Driver
In-Reply-To: <20150406095803.GD6023@sirena.org.uk>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <20150331064338.GE2869@sirena.org.uk> <551EEAF8.7050108@broadcom.com>
 <20150406095803.GD6023@sirena.org.uk>
Message-ID: <55249258.1020907@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15-04-06 02:58 AM, Mark Brown wrote:
> On Fri, Apr 03, 2015 at 12:33:12PM -0700, Scott Branden wrote:
>> On 15-03-30 11:43 PM, Mark Brown wrote:
>>> On Mon, Mar 30, 2015 at 08:16:22PM -0700, Scott Branden wrote:
>
>>>> The audio PLL is embedded in the audio block and only used
>>>> by the audio block. The audio PLL registers are also in the middle of
>>>> the audio register map.
>
>>> When you say it's only used by the audio block do you mean to say that
>>> the audio block exposes no clock signals other than the bit and frame
>>> clocks?
>
>> The audio block exposes the MCLK in addition to the bit and frame clock.
>
> OK, then it's going to need to be a clock provider at some point - the
> clock will be going into external devices which are going to need to be
> able to interact with the clock (for example, to get the rate).
>
Currently, the ASoC machine driver is responsible for requesting a 
certain frequency of MCLK be generated from our driver and then also 
sending the frequency information along to the external device (codec).
This is done via the snd_soc_dai_set_sysclk.  That is the only clock 
interaction we have needed for the core part of the driver.  For 
enhanced features, we also have the need to make minor adjustments 
(tweaks) to the PLL.  The tweaks are used to make the PLLs output 
frequency match as closely as possible to a true reference frequency. 
As such, we would like to provide the finest adjustment resolution as 
possible. The clocking framework only seems to allow for a 1 Hz 
adjustment. This limitation and the fact that no other device seems to 
need to interact directly will the PLL are why we have not put it in the 
clocking framework.
